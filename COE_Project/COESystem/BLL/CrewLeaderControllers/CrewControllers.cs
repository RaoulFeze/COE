﻿using System;
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
        public void Add_To_A_Crew(int unitId, int employeeId)
        {
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

                    //Create the First CrewSite

                    //CrewSite crewSite = new CrewSite();
                    //crew.CrewSites.Add(crewSite);
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
                }
            }
        }

        //This method removes a Crew member from his crew.
        public void RemoveCrewMember(int crewMemberID)
        {
            using(var context = new COESystemContext())
            {
                CrewMember member = context.CrewMembers.Find(crewMemberID);
                if(member == null)
                {
                    throw new Exception("This employee is already removed from the crew");
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


                    if(reasons.Count() > 0)
                    {
                        throw new BusinessRuleException("Adding Site", reasons);
                    }
                    else
                    {
                        //Create a new CrewSite
                        crewSite = new CrewSite();
                        crewSite.SiteID = siteId;
                        crewSite.CrewID = crewId;

                        context.SaveChanges();
                    }
                }

                return units;

            }
        }

        //This Method returns the List of the current crews
        [DataObjectMethod(DataObjectMethodType.Select, false)]
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
                List<CrewMember> crewMembers = crew.CrewMembers.Select(x => x).ToList();
                
                if(crewMembers != null)
                {
                    foreach(CrewMember cm in crewMembers)
                    {
                        context.CrewMembers.Remove(cm);
                    }
                }

                context.Crews.Remove(crew);
                context.SaveChanges();
            }
        }

        public int unitNumber (int crewId)
        {
            using(var context = new COESystemContext())
            {
                return context.Crews.Find(crewId).Unit.UnitID;
            }
        }
    }
}
