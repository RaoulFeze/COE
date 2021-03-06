<Query Kind="Program">
  <Connection>
    <ID>31702c39-067f-4f10-adee-28efe15fdcab</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>COE_DB</Database>
    <ShowServer>true</ShowServer>
  </Connection>
  <Namespace>LINQPad.User</Namespace>
</Query>

void Main()
{
	var RouteList = from site in Sites
					orderby site.Community.Name ascending
					where site.Season.SeasonYear == DateTime.Now.Year && site.Yard.YardID == 1 && site.SiteType.SiteTypeID == 1
					select new Status
					{
						Pin = site.Pin,
						Community = site.Community.Name,
						Neighbourhood = site.Neighbourhood,
						Address = site.StreetAddress,
						Area = site.Area,
						Notes = site.Notes,
						Cycle1 = ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Equals(null)
								 ? (DateTime?)null : ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Date,
						Cycle2 = ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).Skip(1).FirstOrDefault()).Equals(null)
								 ? (DateTime?)null : ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).Skip(1).FirstOrDefault()).Date,
						Cycle3 = ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).Skip(2).FirstOrDefault()).Equals(null)
								 ? (DateTime?)null : ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).Skip(2).FirstOrDefault()).Date,
						Cycle4 = ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).Skip(3).FirstOrDefault()).Equals(null)
								 ? (DateTime?)null : ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).Skip(3).FirstOrDefault()).Date,
						Cycle5 = ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).Skip(4).FirstOrDefault()).Equals(null)
								 ? (DateTime?)null : ((from sbm in SBMs where sbm.CrewSite.SiteID == site.SiteID select new Cycle { Date = sbm.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).Skip(4).FirstOrDefault()).Date,
						Pruning = ((from prune in Prunings where prune.CrewSite.SiteID == site.SiteID select new Cycle { Date = prune.CrewSite.Crew.CrewDate }).FirstOrDefault()).Equals(null)
								  ? (DateTime?) null : ((from prune in Prunings where prune.CrewSite.SiteID == site.SiteID select new Cycle { Date = prune.CrewSite.Crew.CrewDate }).FirstOrDefault()).Date,
						Mulching = ((from mulch in Mulchings where mulch.CrewSite.SiteID == site.SiteID select new Cycle { Date = mulch.CrewSite.Crew.CrewDate }).FirstOrDefault()).Equals(null)
								  ? (DateTime?)null : ((from mulch in Mulchings where mulch.CrewSite.SiteID == site.SiteID select new Cycle { Date = mulch.CrewSite.Crew.CrewDate }).FirstOrDefault()).Date,
						Planting = ((from plant in Plantings where plant.CrewSite.SiteID == site.SiteID select new { Date = plant.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Equals(null)
								  ? (DateTime?)null : ((from plant in Plantings where plant.CrewSite.SiteID == site.SiteID select new { Date = plant.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Date
					};

	var GrassRoute = from site in Sites
					 where site.Season.SeasonYear == 2019 && site.YardID == 1 && site.Grass > 0
					 orderby site.Community.Name ascending
					 select new GrassStatus
					 {
						 Pin = site.Pin,
						 Community = site.Community.Name,
						 Neighbourhood = site.Neighbourhood,
						 Address = site.StreetAddress,
						 Area = site.Area,
						 Notes = site.Notes,
						 Count = site.Grass,
						 Done = ((from grass in Grasses where grass.CrewSite.SiteID == site.SiteID select new Cycle { Date = grass.CrewSite.Crew.CrewDate }).FirstOrDefault()).Equals(null) ? (DateTime?)null :
						 		((from grass in Grasses where grass.CrewSite.SiteID == site.SiteID select new Cycle { Date = grass.CrewSite.Crew.CrewDate }).FirstOrDefault()).Date
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

	public DateTime? Planting { get; set; }
}

public class GrassStatus
{
	public int Pin { get; set; }

	public string Community { get; set; }

	public string Neighbourhood { get; set; }

	public string Address { get; set; }

	public int Area { get; set; }

	public string Notes { get; set; }
	
	public int? Count{get; set;}

	public DateTime? Done { get; set; }
}
public class Cycle
{
	private DateTime _Date;
	
	public DateTime Date 
	{ 
		get => _Date;
		
		set => _Date = value;
	}
}