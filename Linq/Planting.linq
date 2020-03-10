<Query Kind="Expression">
  <Connection>
    <ID>5dd87163-ed4d-4990-8a0d-caaeee022c7a</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>COE_DB</Database>
  </Connection>
</Query>

from site in Sites
where site.YardID == 1 && site.Planting == true && site.Season.SeasonYear == DateTime.Now.Year
orderby site.Pin
select new 
{
	Pin = site.Pin,
	Community = site.Community.Name,
	Neighbourhood = site.Neighbourhood,
	Address = site.StreetAddress,
	Area = site.Area,
	Notes = site.Notes,
	Date = ((from plant in Plantings where plant.CrewSite.SiteID == site.SiteID select new  { Date = plant.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Equals(null)
			? (DateTime?)null : ((from plant in Plantings where plant.CrewSite.SiteID == site.SiteID select new  { Date = plant.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Date
}