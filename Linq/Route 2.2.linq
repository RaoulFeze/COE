<Query Kind="Program">
  <Connection>
    <ID>31702c39-067f-4f10-adee-28efe15fdcab</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>COE_DB_TEST</Database>
    <ShowServer>true</ShowServer>
  </Connection>
  <Namespace>LINQPad.User</Namespace>
</Query>

void Main()
{
	var RouteList = from site in Sites
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
						Cycle1 = ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).FirstOrDefault()).Equals(null)
								 ? (DateTime?)null : ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).FirstOrDefault()).GetDate(),
						Cycle2 = ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).Skip(1).FirstOrDefault()).Equals(null)
								 ? (DateTime?)null : ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).Skip(1).FirstOrDefault()).GetDate(),
						Cycle3 = ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).Skip(2).FirstOrDefault()).Equals(null)
								 ? (DateTime?)null : ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).Skip(2).FirstOrDefault()).GetDate(),
						Cycle4 = ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).Skip(3).FirstOrDefault()).Equals(null)
								 ? (DateTime?)null : ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).Skip(3).FirstOrDefault()).GetDate(),
						Cycle5 = ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).Skip(4).FirstOrDefault()).Equals(null)
								 ? (DateTime?)null : ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.TodayDate }).OrderBy(x => x.Date).Skip(4).FirstOrDefault()).GetDate(),
						Pruning = ((from prune in Prunings where prune.CrewSite.SiteID == site.SiteID select new Cycle { Date = prune.CrewSite.Crew.TodayDate }).FirstOrDefault()).Equals(null)
								  ? (DateTime?) null : ((from prune in Prunings where prune.CrewSite.SiteID == site.SiteID select new Cycle { Date = prune.CrewSite.Crew.TodayDate }).FirstOrDefault()).GetDate(),
						Mulching = ((from mulch in Mulchings where mulch.CrewSite.SiteID == site.SiteID select new Cycle { Date = mulch.CrewSite.Crew.TodayDate }).FirstOrDefault()).Equals(null)
								  ? (DateTime?) null : ((from mulch in Mulchings where mulch.CrewSite.SiteID == site.SiteID select new Cycle { Date = mulch.CrewSite.Crew.TodayDate }).FirstOrDefault()).GetDate()
					};
	RouteList.Dump();
}


// Define other methods and classes here
public class Status
{
	public int Pin { get; set; }

	public string Community { get; set; }

	public string Neighbourhood { get; set; }

	public string Address { get; set; }

	public int Area { get; set; }

	public string Notes { get; set; }

	public DateTime? Cycle1 { get; set; }

	public DateTime? Cycle2 { get; set; }

	public DateTime? Cycle3 { get; set; }

	public DateTime? Cycle4 { get; set; }

	public DateTime? Cycle5 { get; set; }

	public DateTime? Pruning { get; set; } 

	public DateTime? Mulching { get; set; }
}

public class Cycle
{
	private DateTime _Date;
	
	public DateTime Date 
	{ 
		get => _Date;
		
		set => _Date = value;
	}
	
	public DateTime GetDate ()
	{
		return _Date;
	}
}