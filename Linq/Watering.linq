<Query Kind="Program">
  <Connection>
    <ID>31702c39-067f-4f10-adee-28efe15fdcab</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>COE_DB</Database>
    <ShowServer>true</ShowServer>
  </Connection>
</Query>

void Main()
{
	var test = from site in Sites
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
	Cycle1 = ((from water in Waterings where water.CrewSite.SiteID == site.SiteID select new  { Date = water.CrewSite.Crew.CrewDate }).OrderByDescending(x => x.Date).Skip(2).FirstOrDefault()).Equals(null)
			? (DateTime?)null : ((from water in Waterings where water.CrewSite.SiteID == site.SiteID select new  { Date = water.CrewSite.Crew.CrewDate }).OrderByDescending(x => x.Date).Skip(2).FirstOrDefault()).Date,
			
			
			
			
			
			
			
			
	Cycle2 = ((from water in Waterings where water.CrewSite.SiteID == site.SiteID select new  { Date = water.CrewSite.Crew.CrewDate }).OrderByDescending(x => x.Date).Skip(1).FirstOrDefault()).Equals(null)
			? (DateTime?)null : ((from water in Waterings where water.CrewSite.SiteID == site.SiteID select new  { Date = water.CrewSite.Crew.CrewDate }).OrderByDescending(x => x.Date).Skip(1).FirstOrDefault()).Date,
	Cycle3 = ((from water in Waterings where water.CrewSite.SiteID == site.SiteID select new { Date = water.CrewSite.Crew.CrewDate }).OrderByDescending(x => x.Date).FirstOrDefault()).Equals(null)
			? (DateTime?)null : ((from water in Waterings where water.CrewSite.SiteID == site.SiteID select new { Date = water.CrewSite.Crew.CrewDate }).OrderByDescending(x => x.Date).FirstOrDefault()).Date

}




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

	public DateTime? Date { get; set; }
}