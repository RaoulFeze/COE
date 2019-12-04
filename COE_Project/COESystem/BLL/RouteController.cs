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
#endregion

namespace COESystem.BLL
{
    [DataObject]
    public class RouteController
    {
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<RouteStatus> RouteStatus_List(int season, int yardId)
        {
            using (var context = new COESystemContext())
            {
                var RouteList = from site in context.Sites
                                orderby site.Community.Name ascending
                                where site.Season.SeasonYear == 2018 && site.Yard.YardID == 1
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
        public List<RouteStatus> RouteStatus_List(int season, int yardId, string routeType)
        {
            using (var context = new COESystemContext())
            {
                var RouteList = from site in context.Sites
                                orderby site.Community.Name ascending
                                where site.Season.SeasonYear == season && site.Yard.YardID == yardId && site.SiteType.SiteTypeDescription == routeType
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
        public string YardName(int yardId)
        {
            
            using(var context = new COESystemContext())
            {
                var yardName = from x in context.Yards
                               where x.YardID == yardId
                               select x.YardName;
                    
                    //context.Yards
                    //                .Where(x => x.YardID == yardId)
                    //                .Select(x => x.YardName);

                return yardName.ToList()[0];
            }
        }

        //Search a specific route based in the exact Pin and the current season (Year)
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<RouteStatus> GetRouteStatus(int pin)
        {
            using(var context = new COESystemContext())
            {
                var results = from site in context.Sites
                                orderby site.Community.Name ascending
                                where site.Season.SeasonYear == 2018 && site.Pin == pin //(int)DateTime.Now.Year
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

    }
}
