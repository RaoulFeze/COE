<Query Kind="Expression">
  <Connection>
    <ID>31702c39-067f-4f10-adee-28efe15fdcab</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>COE_DB</Database>
    <ShowServer>true</ShowServer>
  </Connection>
</Query>

 from site in Sites
where site.YardID == 1 && site.Watering == true && site.Season.SeasonYear == DateTime.Now.Year
orderby site.Pin
select new 
{
	Pin = site.Pin,
	Community = site.Community.Name,
	Neighbourhood = site.Neighbourhood,
	Address = site.StreetAddress,
	Area = site.Area,
	Notes = site.Notes,
	Cycle1 = ((from water in Waterings where water.CrewSite.SiteID == site.SiteID select new { Date = water.CrewSite.Crew.CrewDate }).OrderByDescending(x => x.Date).FirstOrDefault()).Equals(null)
			? (DateTime?)null : ((from water in Waterings where water.CrewSite.SiteID == site.SiteID select new { Date = water.CrewSite.Crew.CrewDate }).OrderByDescending(x => x.Date).FirstOrDefault()).Date,







	Cycle2 = ((from water in Waterings where water.CrewSite.SiteID == site.SiteID select new { Date = water.CrewSite.Crew.CrewDate }).OrderByDescending(x => x.Date).Skip(1).FirstOrDefault()).Equals(null)
			? (DateTime?)null : ((from water in Waterings where water.CrewSite.SiteID == site.SiteID select new { Date = water.CrewSite.Crew.CrewDate }).OrderByDescending(x => x.Date).Skip(1).FirstOrDefault()).Date,
	Cycle3 = ((from water in Waterings where water.CrewSite.SiteID == site.SiteID select new { Date = water.CrewSite.Crew.CrewDate }).OrderByDescending(x => x.Date).Skip(2).FirstOrDefault()).Equals(null)
			? (DateTime?)null : ((from water in Waterings where water.CrewSite.SiteID == site.SiteID select new { Date = water.CrewSite.Crew.CrewDate }).OrderByDescending(x => x.Date).Skip(2).FirstOrDefault()).Date,

}
