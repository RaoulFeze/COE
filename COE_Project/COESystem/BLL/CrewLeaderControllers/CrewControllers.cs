using System;
using System.Text;
using System.Threading.Tasks;

#region Additional namespaces
using COESystem.DAL;
using COESystem.Data.Entities;
using COECommon.UserControls;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Entity;
using System.Linq;
using COESystem.Data.DTOs;
using COESystem.Data.POCOs;
#endregion

namespace COESystem.BLL.CrewLeaderControllers
{
    [DataObject]
    public class CrewControllers
    {
        //This method returns a Crew based on the Date and UnitID
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public Crew GetCrew(int unitID, DateTime date)
        {
            using(var context = new COESystemContext())
            {
                Crew crew = (from x in context.Crews
                           where x.UnitID == unitID && DbFunctions.TruncateTime(date) == DbFunctions.TruncateTime(x.CrewDate)
                            select x).FirstOrDefault();
                return crew;
            }
        } 

        //This method create a new Crew and update current Crews
        public int Add_To_A_Crew(int unitId, int employeeId)
        {
            int crewId = 0;
            using(var context = new COESystemContext())
            {
                Crew crew = (from x in context.Crews
                            where x.UnitID == unitId && DbFunctions.TruncateTime(DateTime.Now) == DbFunctions.TruncateTime(x.CrewDate)
                            select x).FirstOrDefault();

                List<string> reasons = new List<string>();


                //Check if the added employee is already assigned to a different Crew.
                List<CrewMember> CurrentCrews = (from x in context.CrewMembers
                                                 where DbFunctions.TruncateTime(x.Crew.CrewDate) == DbFunctions.TruncateTime(DateTime.Now)
                                                 select x).ToList();

                foreach (CrewMember memb in CurrentCrews)
                {
                    if (memb.EmployeeID == employeeId)
                    {
                        throw new Exception(context.Employees.Find(employeeId).Name + " is already in assigned to a crew (" + memb.Crew.Unit.UnitNumber + ")");
                    }
                }

                if (crew == null)
                {
                    //Create the new Crew
                    crew = new Crew();
                    crew.UnitID = unitId;
                    crew.CrewDate = DateTime.Now;
                    context.Crews.Add(crew);
                }
                else
                {
                    int count = (from x in context.CrewMembers
                                 where x.CrewID == crew.CrewID
                                 select x).Count();

                    CrewMember member = null;
                    member = crew.CrewMembers.SingleOrDefault(x => x.EmployeeID == employeeId);

                    if (member != null)
                    {
                        //An employee cannot be assigned only once in a Crew
                        reasons.Add(context.Employees.Find(employeeId).Name + " is already assigned to this Crew");
                    }
                    else if (count == 5)
                    {
                        //A Crew cannot have more than 5 employees
                        reasons.Add("A crew cannot have more than five (5) members");
                    }

                }

                if (reasons.Count() > 0)
                {
                    throw new BusinessRuleException("Adding Crew Member ", reasons);
                }
                else
                {
                    CrewMember member = new CrewMember();
                    member.EmployeeID = employeeId;

                    //Use the navigational property to add the crew memeber because the pkey (crewID) 
                    //is not know when the we create a brand new crew.
                    crew.CrewMembers.Add(member);

                    context.SaveChanges();
                    crewId = (from x in context.Crews
                             where x.UnitID == crew.UnitID && DbFunctions.TruncateTime(DateTime.Now) == DbFunctions.TruncateTime(x.CrewDate)
                             select x.CrewID).First();
                }
                return crewId;
            }
        }

        //This method removes a Crew member from his crew.
        public void RemoveCrewMember(int crewMemberID)
        {
            using(var context = new COESystemContext())
            {
                CrewMember member = context.CrewMembers.Find(crewMemberID);
                List<string> message = new List<string>();
                if(member == null)
                {
                    message.Add("This employee you tried to remove did not belong to the current crew");
                }

                if(message.Count() > 0)
                {
                    throw new BusinessRuleException("Removing a crew Memeber Failed", message);
                }
                else
                {
                    context.CrewMembers.Remove(member);
                    context.SaveChanges();
                }
            }
        }

        //Assigns Sites to a Crew
        public string Add_Site_To_Crew(int crewId, int siteId)
        {
            using(var context = new COESystemContext())
            {
                string units = "";

                
                CrewSite crewSite = (from x in context.CrewSites
                                     where x.CrewID == crewId && x.SiteID == siteId
                                     select x).FirstOrDefault();
                List<string> reasons = new List<string>();

                if (crewSite != null)
                {
                    reasons.Add("This site is already assigned to the current crew");
                }
                else
                {
                    //Notify user that the site is already assigned to at least another crew
                    List<CrewSite> crewSites = new List<CrewSite>();
                    crewSites = (from x in context.CrewSites
                                 where DbFunctions.TruncateTime(x.Crew.CrewDate) == DbFunctions.TruncateTime(DateTime.Now) && siteId == x.SiteID
                                 select x).ToList();

                    if(crewSites != null)
                    {
                        foreach (CrewSite cs in crewSites)
                        {
                            units += cs.Crew.Unit.UnitNumber + ", ";
                        }
                    }


                    //Create a new CrewSite for the current Crew
                    crewSite = new CrewSite();
                    crewSite.SiteID = siteId;
                    crewSite.CrewID = crewId;

                    context.CrewSites.Add(crewSite);
                }

                if (reasons.Count() > 0)
                {
                    throw new BusinessRuleException("Adding Site", reasons);
                }
                context.SaveChanges();
                return units;

            }
        }

        //This Method returns the List of the current crews
        public List<CurrentCrew> GetCurrentCrew(int yardId)
        {
            using(var context = new COESystemContext())
            {
                var CurrentCrews = from x in context.Crews
                                   where x.Unit.YardID == yardId && DbFunctions.TruncateTime(x.CrewDate) == DbFunctions.TruncateTime(DateTime.Now)
                                   orderby x.CrewID descending
                                   select new CurrentCrew
                                   {
                                       CrewID = x.CrewID,
                                       Unit = x.Unit.UnitNumber,
                                       UnitID = x.UnitID,
                                       Crew = (from cr in context.CrewMembers
                                               where cr.CrewID == x.CrewID
                                               orderby cr.Employee.FirstName
                                               select new Member
                                               {
                                                   CrewMemberID = cr.CrewMemberID,
                                                   Name = cr.Employee.FirstName + " " + cr.Employee.LastName,
                                                   Driver = cr.Driver
                                               }).ToList(),
                                       Sites = (from y in context.CrewSites
                                                where y.CrewID == x.CrewID
                                                orderby y.SiteID ascending
                                                select new WorkSite
                                                {
                                                    SiteID = y.SiteID.Equals(null) ? 0 : y.SiteID,
                                                    Pin = y.Site.Pin.Equals(null) ? 0 : y.Site.Pin
                                                }).ToList()

                                   };
                return CurrentCrews.ToList();
            }
        }

        //This method deletes a Crew and all its crew members
        public void DeleteCrew(int crewId)
        {
            using(var context = new COESystemContext())
            {
                Crew crew = context.Crews.Find(crewId);
                List<string> message =new List<string>();
                if(crew == null)
                {
                    message.Add( "This Crew is no longer in the database");
                }
                else
                {
                    List<CrewMember> crewMembers = crew.CrewMembers.Select(x => x).ToList();
                    List<CrewSite> crewSites = crew.CrewSites.Select(x => x).ToList();
                    if (crewMembers != null)
                    {
                        foreach (CrewMember cm in crewMembers)
                        {
                            context.CrewMembers.Remove(cm);
                        }
                    }

                    if (crewSites != null)
                    {
                        foreach (CrewSite cs in crewSites)
                        {
                            context.CrewSites.Remove(cs);
                        }
                    }
                }

                if (message.Count > 0)
                {
                    throw new BusinessRuleException("Removing crew Failed!", message);
                }
                context.Crews.Remove(crew);
                context.SaveChanges();
            }
        }

        public void RemoveCrewSite(int crewSiteId)
        {
            using(var context = new COESystemContext())
            {
                List<string> message = new List<string>();

                CrewSite cs =  context.CrewSites.Find(crewSiteId);

                List<Grass> grassList = cs.Grasses.Select(x => x).ToList();
                List<Watering> wateringList = cs.Waterings.Select(x => x).ToList();
                List<Planting> plantinList = cs.Plantings.Select(x => x).ToList();
                List<SBM> sBMList = cs.SBMs.Select(x => x).ToList();
                List<Mulching> mulchingList = cs.Mulchings.Select(x => x).ToList();
                List<Pruning> pruningList = cs.Prunings.Select(x => x).ToList();
                List<Uprooting> uprootingList = cs.Uprootings.Select(x => x).ToList();

                if (cs == null)
                {
                    message.Add("This Site was not assigned to the current Crew");
                }

                if(message.Count() > 0)
                {
                    throw new BusinessRuleException("Removing Site from current Crew Failed", message);
                }
                else
                {
                    foreach (Grass item in grassList)
                    {
                        context.Grasses.Remove(item);
                    }
                    foreach (Watering item in wateringList)
                    {
                        context.Waterings.Remove(item);
                    }
                    foreach (Planting item in plantinList)
                    {
                        context.Plantings.Remove(item);
                    }
                    foreach (SBM item in sBMList)
                    {
                        context.SBMs.Remove(item);
                    }
                    foreach (Mulching item in mulchingList)
                    {
                        context.Mulchings.Remove(item);
                    }
                    foreach (Pruning item in pruningList)
                    {
                        context.Prunings.Remove(item);
                    }
                    foreach (Uprooting item in uprootingList)
                    {
                        context.Uprootings.Remove(item);
                    }

                    context.CrewSites.Remove(cs);
                    context.SaveChanges();
                }
            }
        }

        public int unitNumber (int crewId)
        {
            using(var context = new COESystemContext())
            {
                return context.Crews.Find(crewId).Unit.UnitID;
            }
        }

        public int GetCrewID(int unitId)
        {
            using(var context = new COESystemContext())
            {
                return (from x in context.Crews
                        where x.UnitID == unitId && DbFunctions.TruncateTime(x.CrewDate) == DbFunctions.TruncateTime(DateTime.Now)
                        select x.CrewID).FirstOrDefault();
            }
        }
    }
}
