<Query Kind="Expression">
  <Connection>
    <ID>0b3dd9bd-9c7e-4914-83ae-fa229ddd2231</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>COE_DB</Database>
    <ShowServer>true</ShowServer>
  </Connection>
</Query>

from site in Sites
where site.YardID == 1 && site.Grass > 0 && site.Season.SeasonYear == DateTime.Now.Year
orderby site.Community.Name, site.Neighbourhood
select new 
{
	Pin = site.Pin,
	Community = site.Community.Name,
	Neighbourhood = site.Neighbourhood,
	Address = site.StreetAddress,
	Area = site.Area,
	Notes = site.Notes,
	Date = ((from grass in Grasses where grass.CrewSite.SiteID == site.SiteID select new  { Date = grass.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Equals(null)
			? (DateTime?)null : ((from grass in Grasses where grass.CrewSite.SiteID == site.SiteID select new  { Date = grass.CrewSite.Crew.CrewDate }).OrderBy(x => x.Date).FirstOrDefault()).Date
}