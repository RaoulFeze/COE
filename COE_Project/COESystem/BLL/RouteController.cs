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
#endregion

namespace COESystem.BLL
{
    [DataObject]
    public class RouteController
    {
        public List<RouteStatus> RouteStatus_List()
        {
            using (var context = new COESystemContext())
            {
                var RouteList = from site in context.Sites
                                orderby site.Community.Name ascending
                                where site.Season.SeasonYear == 2018 && site.Yard.YardID == 1 && site.SiteType.SiteTypeDescription == 'B'
                                select new RouteStatus
                                {
                                    Pin = site.Pin,
                                    Community = site.Community.Name,
                                    Address = site.StreetAddress,
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
    }
}
