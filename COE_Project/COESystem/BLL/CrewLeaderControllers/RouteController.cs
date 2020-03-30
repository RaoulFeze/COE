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
        public List<RouteStatus> RouteList(int yardId, int siteTypeId)
        {
            using (var context = new COESystemContext())
            {
                //var RouteList = from site in context.Sites
                //                orderby site.Community.Name ascending
                //                where site.Yard.YardID == yardId && site.SiteTypeID == siteTypeId
                //                let Cycles = (from sbm in context.SBMs
                //                              where sbm.CrewSite.SiteID == site.SiteID && sbm.CrewSite.Crew.CrewDate.Year == DateTime.Now.Year
                //                              orderby sbm.CrewSite.Crew.CrewDate ascending
                //                              select new Cycle
                //                              {
                //                                  Date = sbm.CrewSite.Crew.CrewDate

                //                              }).ToList()
                //                select new RouteStatus
                //                {
                //                    Pin = site.Pin,
                //                    Community = site.Community.Name,
                //                    Neighbourhood = site.Neighbourhood,
                //                    Address = site.StreetAddress,
                //                    Area = site.Area,
                //                    Notes = site.Notes,
                //                    Cycle1 = Cycles.OrderBy(x => x.Date).FirstOrDefault().Date.Equals(null) ? (DateTime?)null : Cycles.OrderBy(x => x.Date).FirstOrDefault().Date,
                //                    Cycle2 = Cycles.OrderBy(x => x.Date).Skip(1).FirstOrDefault().Equals(null) ? (DateTime?)null : Cycles.OrderBy(x => x.Date).Skip(1).FirstOrDefault().Date,
                //                    Cycle3 = Cycles.OrderBy(x => x.Date).Skip(2).FirstOrDefault().Equals(null) ? (DateTime?)null : Cycles.OrderBy(x => x.Date).Skip(2).FirstOrDefault().Date,
                //                    Cycle4 = Cycles.OrderBy(x => x.Date).Skip(3).FirstOrDefault().Equals(null) ? (DateTime?)null : Cycles.OrderBy(x => x.Date).Skip(3).FirstOrDefault().Date,
                //                    Cycle5 = Cycles.OrderBy(x => x.Date).Skip(4).FirstOrDefault().Equals(null) ? (DateTime?)null : Cycles.OrderBy(x => x.Date).Skip(4).FirstOrDefault().Date,

                //                    Pruning = ((from prune in context.Prunings where prune.CrewSite.SiteID == site.SiteID select new { Date = prune.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Equals(null)
                //                                                      ? (DateTime?)null : ((from prune in context.Prunings where prune.CrewSite.SiteID == site.SiteID select new { Date = prune.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Date,
                //                    Mulching = ((from mulch in context.Mulchings where mulch.CrewSite.SiteID == site.SiteID select new { Date = mulch.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Equals(null)
                //                                                      ? (DateTime?)null : ((from mulch in context.Mulchings where mulch.CrewSite.SiteID == site.SiteID select new { Date = mulch.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Date

                //                };

                //return RouteList.ToList();

            var RouteList = (from site in context.Sites
                                orderby site.Community.Name ascending
                                where site.Season.SeasonYear == DateTime.Now.Year && site.Yard.YardID == yardId && site.SiteTypeID == siteTypeId
                                orderby site.Community.Name ascending
                                select new RouteStatus
                                {
                                    SiteID = site.SiteID,
                                    Pin = site.Pin,
                                    Community = site.Community.Name,
                                    Neighbourhood = site.Neighbourhood,
                                    Address = site.StreetAddress,
                                    Area = site.Area,
                                    Notes = site.Notes,
                                    Cycle1 = ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.CrewDate) }).OrderBy(x => x.Date).FirstOrDefault()).Equals(null)
                                            ? (DateTime?)null : ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.CrewDate) }).OrderBy(x => x.Date).FirstOrDefault()).Date,

                                    Cycle2 = ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.CrewDate) }).OrderBy(x => x.Date).Skip(1).FirstOrDefault()).Equals(null)
                                            ? (DateTime?)null : ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.CrewDate) }).OrderBy(x => x.Date).Skip(1).FirstOrDefault()).Date,

                                    Cycle3 = ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.CrewDate) }).OrderBy(x => x.Date).Skip(2).FirstOrDefault()).Equals(null)
                                            ? (DateTime?)null : ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.CrewDate) }).OrderBy(x => x.Date).Skip(2).FirstOrDefault()).Date,

                                    Cycle4 = ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.CrewDate) }).OrderBy(x => x.Date).Skip(3).FirstOrDefault()).Equals(null)
                                            ? (DateTime?)null : ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.CrewDate) }).OrderBy(x => x.Date).Skip(3).FirstOrDefault()).Date,

                                    Cycle5 = ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.CrewDate) }).OrderBy(x => x.Date).Skip(4).FirstOrDefault()).Equals(null)
                                            ? (DateTime?)null : ((from sbm in context.SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(sbm.CrewSite.Crew.CrewDate) }).OrderBy(x => x.Date).Skip(4).FirstOrDefault()).Date,

                                    Pruning = ((from prune in context.Prunings where prune.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(prune.CrewSite.Crew.CrewDate) }).FirstOrDefault()).Equals(null)
                                            ? (DateTime?)null : ((from prune in context.Prunings where prune.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(prune.CrewSite.Crew.CrewDate) }).FirstOrDefault()).Date,

                                    Mulching = ((from mulch in context.Mulchings where mulch.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(mulch.CrewSite.Crew.CrewDate) }).FirstOrDefault()).Equals(null)
                                            ? (DateTime?)null : ((from mulch in context.Mulchings where mulch.CrewSite.SiteID == site.SiteID select new Cycle { Date = DbFunctions.TruncateTime(mulch.CrewSite.Crew.CrewDate) }).FirstOrDefault()).Date

                                });
                return RouteList.ToList();
            }
        }

        //Grass List
        public List<RouteStatus> GrassRouteList(int yardId)
        {
            using(var context = new COESystemContext())
            {
                var RouteList = from site in context.Sites
                             where site.Season.SeasonYear == DateTime.Now.Year && site.YardID == yardId && site.Grass > 0
                             orderby site.Community.Name ascending
                             select new RouteStatus
                             {
                                 SiteID = site.SiteID,
                                 Pin = site.Pin,
                                 Community = site.Community.Name,
                                 Neighbourhood = site.Neighbourhood,
                                 Address = site.StreetAddress,
                                 Area = site.Area,
                                 Notes = site.Notes,
                                 Count = site.Grass,
                                 Trimming = ((from grass in context.Grasses where grass.CrewSite.SiteID == site.SiteID select new Cycle { Date = grass.CrewSite.Crew.CrewDate }).FirstOrDefault()).Equals(null) ? (DateTime?)null :
                                         ((from grass in context.Grasses where grass.CrewSite.SiteID == site.SiteID select new Cycle { Date = grass.CrewSite.Crew.CrewDate }).FirstOrDefault()).Date
                             };
                return RouteList.ToList();
            }
        }

        //Planting Routes
        public List<RouteStatus> PlantingList(int yardId)
        {
            using(var context = new COESystemContext())
            {
                var PlantingList = from site in context.Sites
                                   where site.YardID == yardId && site.Planting == true && site.Season.SeasonYear == DateTime.Now.Year
                                   orderby site.Pin
                                   select new RouteStatus
                                   {
                                       SiteID = site.SiteID,
                                       Pin = site.Pin,
                                       Community = site.Community.Name,
                                       Neighbourhood = site.Neighbourhood,
                                       Address = site.StreetAddress,
                                       Area = site.Area,
                                       Notes = site.Notes,
                                       Planting = ((from plant in context.Plantings where plant.CrewSite.SiteID == site.SiteID select new Cycle { Date = plant.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Equals(null)
                                               ? (DateTime?)null : ((from plant in context.Plantings where plant.CrewSite.SiteID == site.SiteID select new Cycle { Date = plant.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Date,
                                       Uprooting = ((from uproot in context.Uprootings where uproot.CrewSite.SiteID == site.SiteID select new { Date = uproot.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Equals(null)
                                               ? (DateTime?)null : ((from uproot in context.Uprootings where uproot.CrewSite.SiteID == site.SiteID select new Cycle { Date = uproot.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Date
                                   };
                return PlantingList.ToList();
            }
        }

        //Watering Routes
        public List<RouteStatus> WateringList(int yardId)
        {
            using (var context = new COESystemContext())
            {
                var WateringList = from site in context.Sites
                                   where site.YardID == 1 && site.Watering == true && site.Season.SeasonYear == DateTime.Now.Year
                                   orderby site.Pin
                                   select new RouteStatus
                                   {
                                       SiteID = site.SiteID,
                                       Pin = site.Pin,
                                       Community = site.Community.Name,
                                       Neighbourhood = site.Neighbourhood,
                                       Address = site.StreetAddress,
                                       Area = site.Area,
                                       Notes = site.Notes,
                                       Cycle1 = ((from water in context.Waterings where water.CrewSite.SiteID == site.SiteID select new { Date = water.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Equals(null)
                                               ? (DateTime?)null : ((from water in context.Waterings where water.CrewSite.SiteID == site.SiteID select new { Date = water.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Date,
                                       Cycle2 = ((from water in context.Waterings where water.CrewSite.SiteID == site.SiteID select new { Date = water.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).Skip(1).FirstOrDefault()).Equals(null)
                                               ? (DateTime?)null : ((from water in context.Waterings where water.CrewSite.SiteID == site.SiteID select new { Date = water.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).Skip(1).FirstOrDefault()).Date,
                                       Cycle3 = ((from water in context.Waterings where water.CrewSite.SiteID == site.SiteID select new { Date = water.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).Skip(2).FirstOrDefault()).Equals(null)
                                               ? (DateTime?)null : ((from water in context.Waterings where water.CrewSite.SiteID == site.SiteID select new { Date = water.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).Skip(2).FirstOrDefault()).Date
                                   };
                return WateringList.ToList();                     
            }
        }

        //Returns the Yard Name based on the EmployeeID
        public string GetYardName(int? userId)
        {

            using (var context = new COESystemContext())
            {
                return context.Employees.Find(userId).Yard.YardName;
            }
        }

        //Returns the YardID based on the EmployeeID
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public int GetYardId(int? employeeId)
        {
            using (var context = new COESystemContext())
            {
                return context.Employees.Find(employeeId).YardID;
            }
        }
    }
}
