<Query Kind="Program">
  <Connection>
    <ID>31702c39-067f-4f10-adee-28efe15fdcab</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>COE_DB_TEST</Database>
    <ShowServer>true</ShowServer>
  </Connection>
</Query>

void Main()
{	
		var RouteList =	from site in Sites
						orderby site.Community.Name ascending
						where site.Season.SeasonYear == 2019 && site.Yard.YardID == 1 && site.SiteType.SiteTypeDescription == 'A'
						let Cycles = (from sbm in SBMs
									  where sbm.CrewSite.SiteID == site.SiteID
									  orderby sbm.CrewSite.Crew.TodayDate ascending
									  select new
									  {
									  	sbm.CrewSite.Crew.TodayDate
										
									  }).ToList()
						select new 
						{
							Pin = site.Pin,
							Community = site.Community.Name,
							Neighbourhood = site.Neighbourhood,
							Address = site.StreetAddress,
							Area = site.Area,
							Notes = site.Notes,
							Cycle1 = Cycles.First(),
							Cycle2 = Cycles.Skip(1).First(),
							Cycle3 = Cycles.Skip(2).First(),
							Cycle4 = Cycles.Skip(3).First(),
							Cycle5 = Cycles.Skip(4).First(),
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