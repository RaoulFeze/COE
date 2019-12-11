﻿using System;
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
