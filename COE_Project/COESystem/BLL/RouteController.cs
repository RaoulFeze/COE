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
        //Returs a specific route based on the exact Pin and the current season (Year)
        [DataObjectMethod(DataObjectMethodType.Select, false)]
        public List<RouteStatus> RouteStatus_Search(int pin)
        {
            using (var context = new COESystemContext())
            {
                var results = from site in context.Sites
                              orderby site.Community.Name ascending
                              where site.Season.SeasonYear == DateTime.Now.Year && site.Pin == pin 
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
        public List<RouteStatus> RouteStatus_Search(string community)
        {
            using (var context = new COESystemContext())
            {
                var results = from site in context.Sites
                              orderby site.Community.Name ascending
                              where site.Community.Name.Contains(community)
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
        public string YardName(int yardId)
        {

            using (var context = new COESystemContext())
            {
                var yardName = from x in context.Yards
                               where x.YardID == yardId
                               select x.YardName;

                return yardName.ToList()[0];
            }
        }

    }
}
