<Query Kind="Statements">
  <Connection>
    <ID>31702c39-067f-4f10-adee-28efe15fdcab</ID>
    <Persist>true</Persist>
    <Server>.</Server>
    <Database>COE_BD</Database>
    <ShowServer>true</ShowServer>
  </Connection>
</Query>

/* From the 2017 Season, select B routes of the Kennedale Yard (YardID = 1)*/

from s in Sites
where s.Season.SeasonYear == 2018 && s.Yard.YardID == 1 && s.SiteType.SiteTypeDescription == 'B'
group s by s.Community.Name into report
orderby report.Key ascending
select new
{
	Community= report.Key,
	Site = from r in report
			select new 
			{
				Pin = r.Pin,
				Description = r.Neighbourhood,
				Address = r.StreetAddress,
				Area = r.Area,
				Notes = r.Notes,
				Cycle = from cs in CrewSites 
						where cs.SiteID == r.SiteID
						select new 
						{
							CrewSiteID = cs.CrewSiteID,
							Mulch = cs.Mulch == true ? cs.Crew.TodayDate : (DateTime?) null,
							Prune = cs.Prune == true ? cs.Crew.TodayDate : (DateTime?) null
							
						}
			}
	
	
}
 from x in Sites
 where x.Season.SeasonYear == 2018
group x by x.Community.Name into n
select n