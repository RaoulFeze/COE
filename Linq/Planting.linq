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
	Plant = ((from plant in Plantings where plant.CrewSite.SiteID == site.SiteID select new { Date = plant.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Equals(null)
			? (DateTime?)null : ((from plant in Plantings where plant.CrewSite.SiteID == site.SiteID select new { Date = plant.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Date,
	Uproot = ((from uproot in Uprootings where uproot.CrewSite.SiteID == site.SiteID select new { Date = uproot.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Equals(null)
			? (DateTime?)null : ((from uproot in Uprootings where uproot.CrewSite.SiteID == site.SiteID select new { Date = uproot.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Date
}