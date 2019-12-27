using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#region Additionnal Namesapces
using System.ComponentModel;
using COESystem.Data.DTOs;
using COESystem.Data.Entities;
using COESystem.Data.POCOs;
using COESystem.DAL;
using COESystem.Data.Entities2;
#endregion

namespace COESystem.BLL
{
    [DataObject]
    public class RouteController
    {
        #region COE_db
        [DataObjectMethod(DataObjectMethodType.Select,false)]
        public List<Status> RouteTest()
        {
            using (var context = new COE_DBSystemContext())
            {
                var RouteList = from site in context.Sites
                                orderby site.Community.Name ascending
                                where site.Season.SeasonYear == 2019 && site.Yard.YardID == 1 && site.SiteType.SiteTypeDescription.Equals("A")
                                select new Status
                                {
                                    Pin = site.Pin,
                                    Community = site.Community.Name,
                                    Neighbourhood = site.Neighbourhood,
                                    Address = site.StreetAddress,
                                    Area = site.Area,
                                    Notes = site.Notes,
                                    Cycle1 = ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).FirstOrDefault()).Equals(null)
                                             ? (DateTime?)null : ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).FirstOrDefault()).GetDate(),

                                    Cycle2 = ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).Skip(1).FirstOrDefault()).Equals(null)
                                             ? (DateTime?)null : ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).Skip(1).FirstOrDefault()).GetDate(),

                                    Cycle3 = ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).Skip(2).FirstOrDefault()).Equals(null)
                                             ? (DateTime?)null : ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).Skip(2).FirstOrDefault()).GetDate(),

                                    Cycle4 = ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).Skip(3).FirstOrDefault()).Equals(null)
                                             ? (DateTime?)null : ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).Skip(3).FirstOrDefault()).GetDate(),

                                    Cycle5 = ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).Skip(4).FirstOrDefault()).Equals(null)
                                             ? (DateTime?)null : ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).Skip(4).FirstOrDefault()).GetDate(),

                                    Pruning = ((from prune in context.Prunings where prune.CrewSite.SiteID == site.SiteID select new Cycle { Date = prune.CrewSite.Crew.TodayDate }).FirstOrDefault()).Equals(null)
                                              ? (DateTime?)null : ((from prune in context.Prunings where prune.CrewSite.SiteID == site.SiteID select new Cycle { Date = prune.CrewSite.Crew.TodayDate }).FirstOrDefault()).GetDate(),

                                    Mulching = ((from mulch in context.Mulchings where mulch.CrewSite.SiteID == site.SiteID select new Cycle { Date = mulch.CrewSite.Crew.TodayDate }).FirstOrDefault()).Equals(null)
                                              ? (DateTime?)null : ((from mulch in context.Mulchings where mulch.CrewSite.SiteID == site.SiteID select new Cycle { Date = mulch.CrewSite.Crew.TodayDate }).FirstOrDefault()).GetDate()

                                };
                return RouteList.ToList();
            }
        }

        #endregion
        //Returs a specific route based on the exact Pin and the current season (Year)
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<RouteStatus> RouteStatus_Search(int pin, int yardId)
        {
            using (var context = new COESystemContext())
            {
                var results = from site in context.Sites
                              orderby site.Community.Name ascending
                              where site.Season.SeasonYear == DateTime.Now.Year && site.Pin == pin && site.Yard.YardID == yardId
                              select new RouteStatus
                              {
                                  Pin = site.Pin,
                                  Community = site.Community.Name,
                                  Address = site.StreetAddress,
                                  Description = site.Neighbourhood,
                                  Area = site.Area,
                                  Notes = site.Notes,
                                  JobDone = (from crewSite in context.CrewSites
                                             where crewSite.SiteID == site.SiteID
                                             select new SiteStatus
                                             {
                                                 SBM = crewSite.SBM == true ? crewSite.Crew.TodayDate : (DateTime?)null,
                                                 Mulch = crewSite.Mulch == true ? crewSite.Crew.TodayDate : (DateTime?)null,
                                                 Prune = crewSite.Prune == true ? crewSite.Crew.TodayDate : (DateTime?)null,
                                             }).ToList()
                              };
                return results.ToList();
            }
        }

        //returnes Routes search base of the community name
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<RouteStatus> RouteStatus_Search(string community, int yardId)
        {
            using (var context = new COESystemContext())
            {
                var results = from site in context.Sites
                              orderby site.Community.Name ascending
                              where site.Community.Name.Contains(community) && site.Yard.YardID == yardId
                              select new RouteStatus
                              {
                                  Pin = site.Pin,
                                  Community = site.Community.Name,
                                  Address = site.StreetAddress,
                                  Description = site.Neighbourhood,
                                  Area = site.Area,
                                  Notes = site.Notes,
                                  JobDone = (from crewSite in context.CrewSites
                                             where crewSite.SiteID == site.SiteID
                                             select new SiteStatus
                                             {
                                                 SBM = crewSite.SBM == true ? crewSite.Crew.TodayDate : (DateTime?)null,
                                                 Mulch = crewSite.Mulch == true ? crewSite.Crew.TodayDate : (DateTime?)null,
                                                 Prune = crewSite.Prune == true ? crewSite.Crew.TodayDate : (DateTime?)null,
                                             }).ToList()
                              };
                return results.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<RouteStatus> RouteStatus_List(int yardId)
        {
            using (var context = new COESystemContext())
            {
                var RouteList = from site in context.Sites
                                orderby site.Community.Name ascending
                                where site.Season.SeasonYear == DateTime.Now.Year && site.Yard.YardID == yardId
                                select new RouteStatus
                                {
                                    Pin = site.Pin,
                                    Community = site.Community.Name,
                                    Address = site.StreetAddress,
                                    Description = site.Neighbourhood,
                                    Area = site.Area,
                                    Notes = site.Notes,
                                    JobDone = (from crewSite in context.CrewSites
                                               where crewSite.SiteID == site.SiteID
                                               select new SiteStatus
                                               {
                                                   SBM = crewSite.SBM == true ? crewSite.Crew.TodayDate : (DateTime?)null,
                                                   Mulch = crewSite.Mulch == true ? crewSite.Crew.TodayDate : (DateTime?)null,
                                                   Prune = crewSite.Prune == true ? crewSite.Crew.TodayDate : (DateTime?)null,
                                               }).ToList()
                                };
                return RouteList.ToList();
            }
        }

        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<RouteStatus> RouteStatus_List(int yardId, string routeType)
        {
            using (var context = new COESystemContext())
            {
                var RouteList = from site in context.Sites
                                orderby site.Community.Name ascending
                                where site.Season.SeasonYear == DateTime.Now.Year && site.Yard.YardID == yardId && site.SiteType.SiteTypeDescription == routeType
                                select new RouteStatus
                                {
                                    Pin = site.Pin,
                                    Community = site.Community.Name,
                                    Address = site.StreetAddress,
                                    Description = site.Neighbourhood,
                                    Area = site.Area,
                                    Notes = site.Notes,
                                    JobDone = (from crewSite in context.CrewSites
                                               where crewSite.SiteID == site.SiteID
                                               select new SiteStatus
                                               {
                                                   SBM = crewSite.SBM == true ? crewSite.Crew.TodayDate : (DateTime?)null,
                                                   Mulch = crewSite.Mulch == true ? crewSite.Crew.TodayDate : (DateTime?)null,
                                                   Prune = crewSite.Prune == true ? crewSite.Crew.TodayDate : (DateTime?)null,
                                               }).ToList()
                                };
                return RouteList.ToList();
            }
        }

        //Returns the Yard Name based on the YardID
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public string GetYardName(int userId)
        {

            using (var context = new COESystemContext())
            {
                var yardName = from x in context.Employees
                               where x.YardID == userId
                               select x.Yard.YardName;

                return yardName.ToList()[0];
            }
        }

        //Returns the YardID based on the EmployeeID
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public int GetYardId(int? employeeId)
        {
            using(var context = new COESystemContext())
            {
                var yardId = from x in context.Employees
                             where x.EmployeeID == employeeId
                             select x.YardID;
                return yardId.ToList()[0];
            }
        }

    }
}
