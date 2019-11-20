<Query Kind="Program">
  <Connection>
    <ID>ce4cd064-7610-426e-a517-cad4564954d2</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>COE_BD</Database>
  </Connection>
</Query>

void Main()
{
	/* From the 2018 Season, select B routes of the Kennedale Yard (YardID = 1)*/
	
	var RouteList =	from site in Sites
					orderby site.Community.Name ascending
					where site.Season.SeasonYear == 2018 && site.Yard.YardID == 1 && site.SiteType.SiteTypeDescription == 'B'
					select new RouteStatus
					{
						Pin = site.Pin,
						Community = site.Community.Name,
						Description = site.Neighbourhood,
						Address = site.StreetAddress,
						Area = site.Area,
						Notes = site.Notes,
						JobDone = (from crewSite in CrewSites 
											where crewSite.SiteID == site.SiteID
											select new SiteStatus
											{
												SBM = crewSite.SBM == true ? crewSite.Crew.TodayDate : (DateTime?) null,
												Mulch = crewSite.Mulch == true ? crewSite.Crew.TodayDate : (DateTime?) null,
												Prune = crewSite.Prune == true ? crewSite.Crew.TodayDate : (DateTime?) null,
											}).ToList()
					};
					RouteList.Dump();
	/*var SiteGrass = from site in Sites
					where site.Grass == true
					select new
					{
						Pin = site.Pin,
						Community = site.Community.Name,
						Address = site.StreetAddress,
						Area = site.Area,
						Notes = site.Notes,
						//Grass = 
					}*/
}

// Define other methods and classes here
	
	public class SiteStatus
	{
		public DateTime? SBM {get; set;}
		public DateTime? Prune {get; set;}
		public DateTime? Mulch {get; set;}
	}
	
	public class RouteStatus
	{
		public int Pin {get; set;}
		public string Community {get; set;}
		public string Description{get;set;}
		public string Address {get; set;}
		public int Area {get; set;}
		public string Notes {get; set;}
		public List<SiteStatus> JobDone {get; set;}
	}