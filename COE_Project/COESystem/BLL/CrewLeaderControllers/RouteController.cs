using System;
using System.Collections.Generic;
using System.Linq;

#region Additionnal Namesapces
using System.ComponentModel;
using COESystem.Data.POCOs;
using System.Data.Entity;
using COESystem.DAL;
using COESystem.Data.Entities;
#endregion

namespace COESystem.BLL
{
    [DataObject]
    public class RouteController
    {
        #region COE_db_Test
        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public List<Status> RouteList(int year, int yardId, string siteType)
        {
            using (var context = new COESystemContext())
            {
                var RouteList = from site in context.Sites
                                orderby site.Community.Name ascending
                                where site.Season.SeasonYear == 2019 && site.Yard.YardID == yardId && site.SiteType.SiteTypeDescription == siteType
                                select new Status
                                {
                                    Pin = site.Pin,
                                    Community = site.Community.Name,
                                    Neighbourhood = site.Neighbourhood,
                                    Address = site.StreetAddress,
                                    Area = site.Area,
                                    Notes = site.Notes,
                                    Cycle1 = ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.TodayDate) }).OrderBy(x => x.Date).FirstOrDefault()).Equals(null)
                                             ? (DateTime?)null : ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.TodayDate) }).OrderBy(x => x.Date).FirstOrDefault()).Date,

                                    Cycle2 = ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.TodayDate) }).OrderBy(x => x.Date).Skip(1).FirstOrDefault()).Equals(null)
                                             ? (DateTime?)null : ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.TodayDate) }).OrderBy(x => x.Date).Skip(1).FirstOrDefault()).Date,

                                    Cycle3 = ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.TodayDate) }).OrderBy(x => x.Date).Skip(2).FirstOrDefault()).Equals(null)
                                             ? (DateTime?)null : ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.TodayDate) }).OrderBy(x => x.Date).Skip(2).FirstOrDefault()).Date,

                                    Cycle4 = ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.TodayDate) }).OrderBy(x => x.Date).Skip(3).FirstOrDefault()).Equals(null)
                                             ? (DateTime?)null : ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.TodayDate) }).OrderBy(x => x.Date).Skip(3).FirstOrDefault()).Date,

                                    Cycle5 = ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.TodayDate) }).OrderBy(x => x.Date).Skip(4).FirstOrDefault()).Equals(null)
                                             ? (DateTime?)null : ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.TodayDate) }).OrderBy(x => x.Date).Skip(4).FirstOrDefault()).Date,

                                    Pruning = ((from prune in context.Prunings where prune.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(prune.CrewSite.Crew.TodayDate) }).FirstOrDefault()).Equals(null)
                                              ? (DateTime?)null : ((from prune in context.Prunings where prune.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(prune.CrewSite.Crew.TodayDate) }).FirstOrDefault()).Date,

                                    Mulching = ((from mulch in context.Mulchings where mulch.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(mulch.CrewSite.Crew.TodayDate) }).FirstOrDefault()).Equals(null)
                                              ? (DateTime?)null : ((from mulch in context.Mulchings where mulch.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(mulch.CrewSite.Crew.TodayDate) }).FirstOrDefault()).Date

                                };
                return RouteList.ToList();
                //var RouteList = from site in context.Sites
                //                orderby site.Community.Name ascending
                //                where site.Season.SeasonYear == 2019 && site.Yard.YardID == 1 && site.SiteType.SiteTypeDescription == "A"
                //                let Cycles = (from sbm in context.SBMs
                //                              where sbm.CrewSite.SiteID == site.SiteID
                //                              orderby sbm.CrewSite.Crew.TodayDate ascending
                //                              select new Cycle
                //                              {
                //                                  Date = sbm.CrewSite.Crew.TodayDate

                //                              }).ToList()
                //                select new Status
                //                {
                //                    Pin = site.Pin,
                //                    Community = site.Community.Name,
                //                    Neighbourhood = site.Neighbourhood,
                //                    Address = site.StreetAddress,
                //                    Area = site.Area,
                //                    Notes = site.Notes,
                //                    Cycle1 = Cycles.OrderBy(x => x.Date).FirstOrDefault().Date,
                //                    Cycle2 = Cycles.OrderBy(x => x.Date).Skip(1).FirstOrDefault().Equals(null) ? (DateTime?)null : Cycles.OrderBy(x => x.Date).Skip(1).FirstOrDefault().Date,
                //                    Cycle3 = Cycles.OrderBy(x => x.Date).Skip(2).FirstOrDefault().Equals(null) ? (DateTime?)null : Cycles.OrderBy(x => x.Date).Skip(2).FirstOrDefault().Date,
                //                    Cycle4 = Cycles.OrderBy(x => x.Date).Skip(3).FirstOrDefault().Equals(null) ? (DateTime?)null : Cycles.OrderBy(x => x.Date).Skip(3).FirstOrDefault().Date,
                //                    Cycle5 = Cycles.OrderBy(x => x.Date).Skip(4).FirstOrDefault().Equals(null) ? (DateTime?)null : Cycles.OrderBy(x => x.Date).Skip(4).FirstOrDefault().Date,
                //                };
                //return RouteList.ToList();
            }
        }

        public List<GrassStatus> GrassList()
        {
            using(var context = new COESystemContext())
            {
                var GrassList = from site in context.Sites
                             where site.Season.SeasonYear == 2019 && site.YardID == 1 && site.Grass > 0
                             orderby site.Community.Name ascending
                             select new GrassStatus
                             {
                                 Pin = site.Pin,
                                 Community = site.Community.Name,
                                 Neighbourhood = site.Neighbourhood,
                                 Address = site.StreetAddress,
                                 Area = site.Area,
                                 Notes = site.Notes,
                                 Count = site.Grass,
                                 Date = ((from grass in context.Grasses where grass.CrewSite.SiteID == site.SiteID select new Cycle { Date = grass.CrewSite.Crew.TodayDate }).FirstOrDefault()).Equals(null) ? (DateTime?)null :
                                         ((from grass in context.Grasses where grass.CrewSite.SiteID == site.SiteID select new Cycle { Date = grass.CrewSite.Crew.TodayDate }).FirstOrDefault()).Date
                             };
                return GrassList.ToList();
            }
        }

        //Returns the Yard Name based on the YardID
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public string GetYardName(int? userId)
        {

            using (var context = new COESystemContext())
            {
                var yardName = from x in context.Employees
                               where x.EmployeeID == userId
                               select x.Yard.YardName;

                return yardName.ToList()[0];
            }
        }

        //Returns the YardID based on the EmployeeID
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public int GetYardId(int? employeeId)
        {
            using (var context = new COESystemContext())
            {
                var yardId = from x in context.Employees
                             where x.EmployeeID == employeeId
                             select x.YardID;
                return yardId.ToList()[0];
            }
        }

        //Returns the list of Units of a given Yard (YardID)
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<Unit>GetUnits(int yardId)
        {
            using(var context = new COESystemContext())
            {
                var unitList = from x in context.Units
                               where x.YardID == yardId
                               select x;
                return unitList.ToList();
            }    
        }

        //Returns the list of field employees of a given Yard (YardID)
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<Employee>GetEmployees(int yardId)
        {
            using(var context = new COESystemContext())
            {
                var employeeList = from x in context.Employees
                                   where x.YardID == yardId && x.TeamLeader == false && x.CrewLeader == false
                                   select x;
                return employeeList.ToList();
            }
        }
        #endregion

        #region this code uses COE_DB 
        //Returs a specific route based on the exact Pin and the current season (Year)
        //[DataObjectMethod(DataObjectMethodType.Select, false)]
        //public List<RouteStatus> RouteStatus_Search(int pin, int yardId)
        //{
        //    using (var context = new COESystemContext())
        //    {
        //        var results = from site in context.Sites
        //                      orderby site.Community.Name ascending
        //                      where site.Season.SeasonYear == DateTime.Now.Year && site.Pin == pin && site.Yard.YardID == yardId
        //                      select new RouteStatus
        //                      {
        //                          Pin = site.Pin,
        //                          Community = site.Community.Name,
        //                          Address = site.StreetAddress,
        //                          Description = site.Neighbourhood,
        //                          Area = site.Area,
        //                          Notes = site.Notes,
        //                          JobDone = (from crewSite in context.CrewSites
        //                                     where crewSite.SiteID == site.SiteID
        //                                     select new SiteStatus
        //                                     {
        //                                         SBM = crewSite.SBM == true ? crewSite.Crew.TodayDate : (DateTime?)null,
        //                                         Mulch = crewSite.Mulch == true ? crewSite.Crew.TodayDate : (DateTime?)null,
        //                                         Prune = crewSite.Prune == true ? crewSite.Crew.TodayDate : (DateTime?)null,
        //                                     }).ToList()
        //                      };
        //        return results.ToList();
        //    }
        //}

        ////returnes Routes search base of the community name
        //[DataObjectMethod(DataObjectMethodType.Select, false)]
        //public List<RouteStatus> RouteStatus_Search(string community, int yardId)
        //{
        //    using (var context = new COESystemContext())
        //    {
        //        var results = from site in context.Sites
        //                      orderby site.Community.Name ascending
        //                      where site.Community.Name.Contains(community) && site.Yard.YardID == yardId
        //                      select new RouteStatus
        //                      {
        //                          Pin = site.Pin,
        //                          Community = site.Community.Name,
        //                          Address = site.StreetAddress,
        //                          Description = site.Neighbourhood,
        //                          Area = site.Area,
        //                          Notes = site.Notes,
        //                          JobDone = (from crewSite in context.CrewSites
        //                                     where crewSite.SiteID == site.SiteID
        //                                     select new SiteStatus
        //                                     {
        //                                         SBM = crewSite.SBM == true ? crewSite.Crew.TodayDate : (DateTime?)null,
        //                                         Mulch = crewSite.Mulch == true ? crewSite.Crew.TodayDate : (DateTime?)null,
        //                                         Prune = crewSite.Prune == true ? crewSite.Crew.TodayDate : (DateTime?)null,
        //                                     }).ToList()
        //                      };
        //        return results.ToList();
        //    }
        //}

        //[DataObjectMethod(DataObjectMethodType.Select, false)]
        //public List<RouteStatus> RouteStatus_List(int yardId)
        //{
        //    using (var context = new COESystemContext())
        //    {
        //        var RouteList = from site in context.Sites
        //                        orderby site.Community.Name ascending
        //                        where site.Season.SeasonYear == DateTime.Now.Year && site.Yard.YardID == yardId
        //                        select new RouteStatus
        //                        {
        //                            Pin = site.Pin,
        //                            Community = site.Community.Name,
        //                            Address = site.StreetAddress,
        //                            Description = site.Neighbourhood,
        //                            Area = site.Area,
        //                            Notes = site.Notes,
        //                            JobDone = (from crewSite in context.CrewSites
        //                                       where crewSite.SiteID == site.SiteID
        //                                       select new SiteStatus
        //                                       {
        //                                           SBM = crewSite.SBM == true ? crewSite.Crew.TodayDate : (DateTime?)null,
        //                                           Mulch = crewSite.Mulch == true ? crewSite.Crew.TodayDate : (DateTime?)null,
        //                                           Prune = crewSite.Prune == true ? crewSite.Crew.TodayDate : (DateTime?)null,
        //                                       }).ToList()
        //                        };
        //        return RouteList.ToList();
        //    }
        //}

        //[DataObjectMethod(DataObjectMethodType.Select, false)]
        //public List<RouteStatus> RouteStatus_List(int yardId, string routeType)
        //{
        //    using (var context = new COESystemContext())
        //    {
        //        var RouteList = from site in context.Sites
        //                        orderby site.Community.Name ascending
        //                        where site.Season.SeasonYear == DateTime.Now.Year && site.Yard.YardID == yardId && site.SiteType.SiteTypeDescription == routeType
        //                        select new RouteStatus
        //                        {
        //                            Pin = site.Pin,
        //                            Community = site.Community.Name,
        //                            Address = site.StreetAddress,
        //                            Description = site.Neighbourhood,
        //                            Area = site.Area,
        //                            Notes = site.Notes,
        //                            JobDone = (from crewSite in context.CrewSites
        //                                       where crewSite.SiteID == site.SiteID
        //                                       select new SiteStatus
        //                                       {
        //                                           SBM = crewSite.SBM == true ? crewSite.Crew.TodayDate : (DateTime?)null,
        //                                           Mulch = crewSite.Mulch == true ? crewSite.Crew.TodayDate : (DateTime?)null,
        //                                           Prune = crewSite.Prune == true ? crewSite.Crew.TodayDate : (DateTime?)null,
        //                                       }).ToList()
        //                        };
        //        return RouteList.ToList();
        //    }
        //}


        #endregion

    }
}
