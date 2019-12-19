<Query Kind="Program">
  <Connection>
    <ID>e6f370bf-cf26-4e84-86eb-95c1e0bf1e12</ID>
    <Persist>true</Persist>
    <Server>LAPTOP-JJ3E4IVO\MSSQLSERVER1</Server>
    <Database>COE_DB_TEST</Database>
    <ShowServer>true</ShowServer>
  </Connection>
</Query>

void Main()
{
		var Count = 1;
	
		var RouteList =	from site in Sites
						orderby site.Community.Name ascending
						where site.Season.SeasonYear == 2019 && site.Yard.YardID == 1 && site.SiteType.SiteTypeDescription == 'A'
						select new 
						{
							Pin = site.Pin,
							Community = site.Community.Name,
							Description = site.Neighbourhood,
							Address = site.StreetAddress,
							Area = site.Area,
							Notes = site.Notes,
							Cycles = (from sbm in SBMs
									  where sbm.CrewSite.SiteID == site.SiteID
									  select new
									  {
									  	sbm.CrewSite.Crew.TodayDate
										
									  }).ToList(),
							Pruning = (from prune in Prunings
									   where prune.CrewSite.SiteID == site.SiteID
									   select new
									   {
									   	prune.CrewSite.Crew.TodayDate
									   }).ToList(),
							Mulching = (from mulch in Mulchings
										where mulch.CrewSite.SiteID == site.SiteID
										select new
										{
											mulch.CrewSite.Crew.TodayDate
										}).ToList()
							
						};
						RouteList.Dump();
}

// Define other methods and classes here
