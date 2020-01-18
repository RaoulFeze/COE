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
        //This method returns the Crew of a crew based on the Date and UnitID
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

        //This method create a new crew
        [DataObjectMethod(DataObjectMethodType.Insert, false)]
        public void Add_To_A_Crew(int unitId, int employeeId)
        {
            using(var context = new COESystemContext())
            {
                Crew crew = (from x in context.Crews
                            where x.UnitID == unitId && DbFunctions.TruncateTime(DateTime.Now) == DbFunctions.TruncateTime(x.CrewDate)
                            select x).FirstOrDefault();

                List<string> reasons = new List<string>();

                if(crew == null)
                {
                    //Create the new Crew
                    crew = new Crew();
                    crew.UnitID = unitId;
                    crew.CrewDate = (DateTime)DbFunctions.TruncateTime(DateTime.Now);
                    context.Crews.Add(crew);
                }
                else
                {
                    int count = (from x in context.CrewMembers
                                 where x.CrewID == crew.CrewID
                                 select x).Count();

                    CrewMember member = null;
                    member = crew.CrewMembers.SingleOrDefault(x => x.EmployeeID == employeeId);

                    if(member != null)
                    {
                        //An employee cannot be assigned only once in a Crew
                        reasons.Add(context.Employees.Find(employeeId).Name + " is already assigned to this Crew");
                    }
                    else if (count > 5)
                    {
                        //A Crew cannot have more than 5 employees
                        reasons.Add("A crew cannot have more than five (5) members");
                    }
                    else
                    {
                        //Check if the added employee is already assigned to a different Crew.
                        List<CrewMember> CurrentCrews = (from x in context.CrewMembers
                                                         where DbFunctions.TruncateTime(x.Crew.CrewDate) == DbFunctions.TruncateTime(DateTime.Now)
                                                         select x).ToList();

                        foreach (CrewMember memb in CurrentCrews)
                        {
                            if (memb.EmployeeID == employeeId)
                            {
                                reasons.Add(context.Employees.Find(employeeId).Name + " is already in assigned to a crew");
                            }
                        }
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

        //This Method returns the List of the current crews
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<CurrentCrew> GetCurrentCrew(int yardId)
        {
            using(var context = new COESystemContext())
            {
                var CurrentCrews = from x in context.Crews
                                   where x.Unit.YardID == yardId && DbFunctions.TruncateTime(x.CrewDate) == DbFunctions.TruncateTime(DateTime.Now )

                                   select new CurrentCrew
                                   {
                                       Unit = x.Unit.UnitNumber,
                                       Crew = (from cr in context.CrewMembers
                                               where cr.CrewID == x.CrewID
                                               orderby cr.Employee.FirstName
                                               select new Member
                                               {
                                                   EmployeeID = cr.EmployeeID,
                                                   Name = cr.Employee.FirstName + " " + cr.Employee.LastName
                                               }).ToList()

                                   };
                return CurrentCrews.ToList();
            }
        }

    }
}
