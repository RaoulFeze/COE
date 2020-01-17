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
					   where x.Unit.YardID == 1 && x.Date == System.DateTime.Parse("2020-01-17 12:00:00 AM") //DateTime.Now 

					   select new CurrentCrew
					   {
					   		Unit = x.Unit.UnitNumber,
							Crew = (from cr in CrewMembers
								   where cr.CrewID == x.CrewID
								   orderby cr.Employee.FirstName
								   select new Member
								   {
								   		EmployeeID = cr.EmployeeID,
								   		Name = cr.Employee.FirstName +' '+ cr.Employee.LastName
								   }).ToList()
						
					   };
		CurrentCrews.Dump();
}

// Define other methods and classes here

public class CurrentCrew
{
	public string Unit{get; set;}
	public List<Member> Crew{get; set;}
}

public class Member
{
	public int EmployeeID{get;set;}
	public string Name {get; set;}
}