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
	var CurrentCrews = from x in Crews
					   where x.Unit.YardID == 1 && x.CrewDate == System.DateTime.Parse("2020-01-20 ") //DateTime.Now 

					   select new CurrentCrew
					   {
					   		Unit = x.Unit.UnitNumber,
							Crew = (from cr in CrewMembers
								   where cr.CrewID == x.CrewID
								   orderby cr.Employee.FirstName
								   select new Member
								   {
								   		EmployeeID = cr.EmployeeID,
								   		Name = cr.Employee.FirstName +' '+ cr.Employee.LastName,
										Driver = cr.Driver
								   }).ToList(),
							Sites = (from y in CrewSites
									 where y.CrewID == x.CrewID
									 orderby y.SiteID ascending
									 select new WorkSite
									 {
									 	SiteID = y.SiteID.Equals(null)?0:y.SiteID,
									 	Pin = y.Site.Pin.Equals(null)?0:y.Site.Pin
									 }).ToList()
						
					   };
		CurrentCrews.Dump();
}

// Define other methods and classes here

public class CurrentCrew
{
	public string Unit{get; set;}
	public List<Member> Crew{get; set;}
	public List<WorkSite> Sites{get; set;}
}

public class Member
{
	public int EmployeeID{get;set;}
	public string Name {get; set;}
	public bool? Driver{get;set;}
}

public class WorkSite
{
	public int SiteID {get; set;}
	public int Pin{get;set;}
}