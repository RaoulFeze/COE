/*CREATE DATABASE COE_BD*/

Drop Table SiteHazard

Drop Table ToolsCheckList

Drop Table CrewSite

Drop Table CrewMember

Drop Table Crew

--Drop Table SiteStatus

Drop Table Tool

Drop Table Unit

Drop Table Site 

Drop Table Employee

Drop Table CorrectiveAction

Drop Table Hazard

Drop Table Yard

Drop Table HazardCategory

Drop Table SiteType

Drop Table District


---------------PARENTS------------------------------------------------------------------
create table District
(
	DistrictID integer identity(1,1) not null constraint pk_District primary key clustered,
	DistrictName varchar(20) not null
)

create table SiteType
(
	SiteTypeID integer identity(1,1) not null constraint pk_SiteType primary key clustered,
	SiteTypeDescription char(1) not null,
	NumberOfCyle int not null
)

create table HazardCategory
(
	HazardCategoryID integer identity(1,1) not null constraint pk_HazardCategory primary key clustered,
	HazardCategoryName varchar(10) not null
)

---------------------FIRST CHILDREN------------------------------------
create table Yard
(
	YardID integer identity(1,1) not null constraint pk_Yard primary key clustered,
	YardName varchar(20) not null,
	DistrictID int not null constraint fk_Yard_To_District references District(DistrictID)
)

create table Hazard
(
	HazardID integer identity(1,1) not null constraint pk_Hazard primary key clustered,
	HazardDescription varchar(50) not null,
	HazardCategoryID int null constraint fk_Hazard_To_HazardCategory references hazardCategory(HazardCategoryID)
)

------------------------SECOND CHILDREN----------------------------------------
create table CorrectiveAction
(
	CorrectiveActionID integer identity(1,1) not null constraint pk_CorrectiveAction primary key clustered,
	CorrectiveActionDescription varchar(100) not null,
	HazardID int not null constraint fk_CorrectiveAction_To_hazard references Hazard(HazardID)
)

create table Employee
(
	EmployeeID integer identity(1,1) not null constraint pk_Employee primary key clustered,
	FirstName varchar(20) not null,
	LastName varchar(20) not null,
	YardID int not null constraint fk_Employee_To_Yard references Yard(YardID),
	CrewLeader bit constraint df_NotCrewLeader default null,
	Gardener bit constraint df_NotGardener default null 
			     --constraint ck_CrewLeader_is_Gardener check(CrewLeader is not null and Gardener is not null)
)
 create table Site
 (
	SiteID integer identity(1,1) not null constraint pk_Site primary key clustered,
	PinNumber int not null,
	Neighbourhood varchar(50) not null,
	StreetAddress varchar(35) null,
	Area int not null, 
	Notes varchar(1000) null,
	Grass bit constraint df_GrassOnSite default null,
	SiteTypeID int not null constraint fk_Site_To_SiteType references SiteType(SiteTypeID),
	YardID int not null constraint fk_Site_To_yard references Yard(YardID)
 )

 create table Unit
 (
	UnitID integer identity not null constraint pk_Unit primary key clustered,
	UnitNumber int not null,
	UnitDescription varchar(20) not null,
	YardID int not null constraint fk_Unit_To_Yard references Yard(YardID)
 )

 create table Tool
 ( 
	ToolID integer identity(1,1) not null constraint pk_Tool primary key clustered,
	ToolDescription varchar(30) not null,
	YardID int not null constraint fk_Tool_To_Yard references Yard(YardID)
 )

 -----------------THIRD CHILDREN------------------------------------------
/*create table SiteStatus
(
	SiteStatusID integer identity(1,1) not null constraint pk_SiteStatus primary key clustered,
	CycleDate datetime not null,
	Mulch datetime null,
	Prune datetime null,
	SiteID int not null constraint fk_SiteStatus_To_Site references Site(SiteID) 
)
*/
create table Crew
(
	CrewID integer identity(1,1) not null constraint pk_Crew primary key clustered,
	TodayDate datetime not null,
	UnitID int not null constraint fk_Crew_To_Unit references Unit(UnitID),
	KM_Start int not null,
	KM_End int not null
	--constraint pk_Crew primary key clustered(Todaydate, UnitID)
)

create table CrewMember
(
	CrewMemberID integer identity not null constraint pk_CrewMember primary key clustered,
	EmployeeID int not null constraint fk_CrewMwmber_To_Employee references Employee(EmployeeID),
	Driver  bit constraint df_NotDriver default null, 
	FLHA_CompletedBy  bit constraint df_DidNotCompleteFLHA default null,
	CrewID int not null constraint fk_CrewMember_To_Crew references Crew(CrewID)
	/*constraint fk_CrewMember_To_Crew foreign key (Todaydate, UnitID) references Crew(Todaydate, UnitID),
	Constraint pk_CrewMember primary key clustered(TodayDate, UnitID, EmployeeID)*/
)

create table CrewSite
(
	CrewSiteID Integer identity(1,1) not null constraint pk_CrewSite primary key clustered,
	SiteID int not null constraint fk_CrewSite_to_Site references Site(SiteID),
	TaskDescription varchar(100) not null,
	TimeOnSite time null,
    TimeOffSite time null,
	Mulch datetime null,
	Prune datetime null,
	Actionrequired varchar(100) null,
	AdditionalComments varchar(100) null,
	CrewID int not null constraint fk_CrewSite_To_Crew references Crew(CrewID)
	/*constraint fk_CrewSite_To_Crew foreign key (Todaydate, UnitID) references Crew(Todaydate, UnitID),
	constraint pk_crewSite primary Key clustered(TodayDate, UnitID, SiteID)*/
)

create table ToolsChecklist
(
	ToolCheckListID integer identity(1,1) not null constraint pk_ToolCheckList primary key clustered,
	ToolID int not null constraint fk_ToolsChecklist_To_Tool references Tool(ToolID),
	Quantity int null,
	CrewID int not null constraint fk_ToolsChecklist_To_Crew references Crew(CrewID)
	/*constraint fk_ToolsChecklist_To_Crew foreign key (Todaydate, UnitID) references Crew(Todaydate, UnitID),
	constraint pk_ToolsChecklist primary Key clustered(TodayDate, UnitID, ToolID)*/
)

create table SiteHazard
(
	SiteHazardID integer identity(1,1) not null constraint pk_SiteHazard primary key clustered,
	HazardID int not null constraint fk_SiteHazard_To_Hazard references hazard(HazardID),
	CrewSiteID int not null constraint fk_SiteHazard_To_Site references CrewSite(CrewSiteID),
	ReviewedBy int null,
	ReviewedDate Datetime null
	--constraint pk_SiteHazard primary key clustered(TodayDate, UnitID, SiteID, hazardID)
)

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

/*DISTRICT*/
Insert into District (DistrictName)
Values('North-West')

Insert into District (DistrictName)
Values('North-East')

Insert into District (DistrictName)
Values('South-West')

Insert into District (DistrictName)
Values('South-East')


/*YARD*/
Insert Into Yard (YardName, DistrictID)
Values('Kennedale', 2)

Insert Into Yard (YardName, DistrictID)
Values('Westwood', 2)

Insert Into Yard (YardName, DistrictID)
Values('Borden', 2)

Insert Into Yard (YardName, DistrictID)
Values('Lamba', 1)

Insert Into Yard (YardName, DistrictID)
Values('Veneto', 1)

Insert Into Yard (YardName, DistrictID)
Values('Lombardia', 1)

Insert Into Yard (YardName, DistrictID)
Values('Vermont', 3)

Insert Into Yard (YardName, DistrictID)
Values('Atacama', 3)

Insert Into Yard (YardName, DistrictID)
Values('Essex', 3)

Insert Into Yard (YardName, DistrictID)
Values('Minas Gerais', 4)

Insert Into Yard (YardName, DistrictID)
Values('"Warmińsko-mazurskie', 4)

Insert Into Yard (YardName, DistrictID)
Values('Roxburghshire', 4)

---------------------------------------------------------------------\
/*EMPLOYEE*/
insert into Employee (FirstName, LastName, YardID) values ('Jean', 'Larcher', 8);
insert into Employee (FirstName, LastName, YardID) values ('Noami', 'Gaunter', 11);
insert into Employee (FirstName, LastName, YardID) values ('Gerard', 'Thaim', 1);
insert into Employee (FirstName, LastName, YardID) values ('Benny', 'Symcoxe', 9);
insert into Employee (FirstName, LastName, YardID) values ('Cherin', 'Elflain', 6);
insert into Employee (FirstName, LastName, YardID) values ('Patrizia', 'Blackstock', 5);
insert into Employee (FirstName, LastName, YardID) values ('Valencia', 'Boddy', 9);
insert into Employee (FirstName, LastName, YardID) values ('Natty', 'Lamerton', 2);
insert into Employee (FirstName, LastName, YardID) values ('Baryram', 'Wharby', 9);
insert into Employee (FirstName, LastName, YardID) values ('Jeromy', 'Bann', 12);
insert into Employee (FirstName, LastName, YardID) values ('Don', 'Garland', 12);
insert into Employee (FirstName, LastName, YardID) values ('Alistair', 'Ramm', 8);
insert into Employee (FirstName, LastName, YardID) values ('Kathleen', 'Worcester', 12);
insert into Employee (FirstName, LastName, YardID) values ('Ingemar', 'Ager', 8);
insert into Employee (FirstName, LastName, YardID) values ('Gorden', 'Jirusek', 12);
insert into Employee (FirstName, LastName, YardID) values ('Bryn', 'Lomasna', 9);
insert into Employee (FirstName, LastName, YardID) values ('Gael', 'Rustan', 10);
insert into Employee (FirstName, LastName, YardID) values ('Frederico', 'MacCahee', 11);
insert into Employee (FirstName, LastName, YardID) values ('Roderick', 'Pischel', 7);
insert into Employee (FirstName, LastName, YardID) values ('Carolee', 'Ludlem', 6);
insert into Employee (FirstName, LastName, YardID) values ('Janelle', 'Balassa', 12);
insert into Employee (FirstName, LastName, YardID) values ('Ronna', 'Baudou', 10);
insert into Employee (FirstName, LastName, YardID) values ('Leisha', 'Fellini', 3);
insert into Employee (FirstName, LastName, YardID) values ('Alvera', 'Townsend', 10);
insert into Employee (FirstName, LastName, YardID) values ('Janifer', 'Sponer', 7);
insert into Employee (FirstName, LastName, YardID) values ('Anitra', 'Shoesmith', 11);
insert into Employee (FirstName, LastName, YardID) values ('Kim', 'Dunlop', 12);
insert into Employee (FirstName, LastName, YardID) values ('Daryn', 'Lum', 5);
insert into Employee (FirstName, LastName, YardID) values ('Giustino', 'Randell', 3);
insert into Employee (FirstName, LastName, YardID) values ('Annadiane', 'De Avenell', 11);
insert into Employee (FirstName, LastName, YardID) values ('Shayla', 'Gordon', 2);
insert into Employee (FirstName, LastName, YardID) values ('Carlene', 'Beddie', 9);
insert into Employee (FirstName, LastName, YardID) values ('Odette', 'Bartelet', 8);
insert into Employee (FirstName, LastName, YardID) values ('Lenette', 'Tarpey', 11);
insert into Employee (FirstName, LastName, YardID) values ('Jobye', 'Loade', 9);
insert into Employee (FirstName, LastName, YardID) values ('Lonnard', 'Adamiak', 4);
insert into Employee (FirstName, LastName, YardID) values ('Alayne', 'Werndly', 10);
insert into Employee (FirstName, LastName, YardID) values ('Wanda', 'Biggen', 4);
insert into Employee (FirstName, LastName, YardID) values ('Esther', 'Arundell', 4);
insert into Employee (FirstName, LastName, YardID) values ('Amelia', 'Bitcheno', 6);
insert into Employee (FirstName, LastName, YardID) values ('Myrtle', 'Stockau', 11);
insert into Employee (FirstName, LastName, YardID) values ('James', 'McReath', 6);
insert into Employee (FirstName, LastName, YardID) values ('Ilysa', 'Foxen', 1);
insert into Employee (FirstName, LastName, YardID) values ('Fannie', 'Chazelle', 11);
insert into Employee (FirstName, LastName, YardID) values ('Michaella', 'Grelka', 9);
insert into Employee (FirstName, LastName, YardID) values ('Corinna', 'Caldicott', 3);
insert into Employee (FirstName, LastName, YardID) values ('Shae', 'Mose', 9);
insert into Employee (FirstName, LastName, YardID) values ('Mitch', 'Gall', 10);
insert into Employee (FirstName, LastName, YardID) values ('Kelci', 'Gomersall', 3);
insert into Employee (FirstName, LastName, YardID) values ('Carrissa', 'Dashwood', 9);
insert into Employee (FirstName, LastName, YardID) values ('Tommy', 'Eate', 9);
insert into Employee (FirstName, LastName, YardID) values ('Pooh', 'Fusedale', 7);
insert into Employee (FirstName, LastName, YardID) values ('Earle', 'Montes', 3);
insert into Employee (FirstName, LastName, YardID) values ('Merwyn', 'Albany', 8);
insert into Employee (FirstName, LastName, YardID) values ('Carree', 'Melson', 2);
insert into Employee (FirstName, LastName, YardID) values ('Kelila', 'Saffran', 11);
insert into Employee (FirstName, LastName, YardID) values ('Herby', 'Phette', 6);
insert into Employee (FirstName, LastName, YardID) values ('Rodolfo', 'Fyfe', 4);
insert into Employee (FirstName, LastName, YardID) values ('Thea', 'Winterbotham', 1);
insert into Employee (FirstName, LastName, YardID) values ('Muriel', 'Trencher', 6);
insert into Employee (FirstName, LastName, YardID) values ('Eleonora', 'Pena', 6);
insert into Employee (FirstName, LastName, YardID) values ('Regen', 'Woonton', 11);
insert into Employee (FirstName, LastName, YardID) values ('Catharina', 'Beckwith', 12);
insert into Employee (FirstName, LastName, YardID) values ('Roger', 'Barthelme', 5);
insert into Employee (FirstName, LastName, YardID) values ('Arther', 'Gavan', 8);
insert into Employee (FirstName, LastName, YardID) values ('Inglis', 'Coker', 11);
insert into Employee (FirstName, LastName, YardID) values ('Mac', 'Lafontaine', 6);
insert into Employee (FirstName, LastName, YardID) values ('Maire', 'Rudall', 8);
insert into Employee (FirstName, LastName, YardID) values ('Isadora', 'Trehearn', 6);
insert into Employee (FirstName, LastName, YardID) values ('Udell', 'Burleigh', 11);
insert into Employee (FirstName, LastName, YardID) values ('Dita', 'Payne', 2);
insert into Employee (FirstName, LastName, YardID) values ('Bobbye', 'Maillard', 6);
insert into Employee (FirstName, LastName, YardID) values ('Bail', 'Ailmer', 6);
insert into Employee (FirstName, LastName, YardID) values ('Ilka', 'Bowmer', 12);
insert into Employee (FirstName, LastName, YardID) values ('Somerset', 'Stockoe', 3);
insert into Employee (FirstName, LastName, YardID) values ('Frederica', 'Moorrud', 2);
insert into Employee (FirstName, LastName, YardID) values ('Franciskus', 'Carbry', 9);
insert into Employee (FirstName, LastName, YardID) values ('Johnna', 'Dacres', 9);
insert into Employee (FirstName, LastName, YardID) values ('Concettina', 'Arnet', 6);
insert into Employee (FirstName, LastName, YardID) values ('Sarita', 'Robey', 6);
insert into Employee (FirstName, LastName, YardID) values ('Marlin', 'Wadley', 7);
insert into Employee (FirstName, LastName, YardID) values ('Grover', 'McVicar', 4);
insert into Employee (FirstName, LastName, YardID) values ('Helga', 'Dahl', 2);
insert into Employee (FirstName, LastName, YardID) values ('Tally', 'Bygreaves', 5);
insert into Employee (FirstName, LastName, YardID) values ('Brion', 'Sheed', 4);
insert into Employee (FirstName, LastName, YardID) values ('Katrinka', 'Proudlock', 11);
insert into Employee (FirstName, LastName, YardID) values ('Sianna', 'Rollason', 5);
insert into Employee (FirstName, LastName, YardID) values ('Jamesy', 'Lewing', 9);
insert into Employee (FirstName, LastName, YardID) values ('Gage', 'Peach', 3);
insert into Employee (FirstName, LastName, YardID) values ('Mariel', 'Chritchlow', 8);
insert into Employee (FirstName, LastName, YardID) values ('Lelah', 'Dyhouse', 4);
insert into Employee (FirstName, LastName, YardID) values ('Anneliese', 'Arnaudet', 6);
insert into Employee (FirstName, LastName, YardID) values ('Perkin', 'Groarty', 5);
insert into Employee (FirstName, LastName, YardID) values ('Savina', 'Ondrousek', 2);
insert into Employee (FirstName, LastName, YardID) values ('Nicol', 'Cochern', 10);
insert into Employee (FirstName, LastName, YardID) values ('Rena', 'Lamartine', 7);
insert into Employee (FirstName, LastName, YardID) values ('Isa', 'Sarath', 8);
insert into Employee (FirstName, LastName, YardID) values ('Berte', 'Chaffe', 8);
insert into Employee (FirstName, LastName, YardID) values ('Alie', 'Meas', 11);
insert into Employee (FirstName, LastName, YardID) values ('Dick', 'Needs', 9);
insert into Employee (FirstName, LastName, YardID) values ('Elden', 'Elcy', 11);
insert into Employee (FirstName, LastName, YardID) values ('Kevin', 'Speechley', 7);
insert into Employee (FirstName, LastName, YardID) values ('Nathalia', 'Ouldred', 6);
insert into Employee (FirstName, LastName, YardID) values ('Hershel', 'Ionnisian', 11);
insert into Employee (FirstName, LastName, YardID) values ('Kathlin', 'Benez', 12);
insert into Employee (FirstName, LastName, YardID) values ('Isahella', 'Braz', 12);
insert into Employee (FirstName, LastName, YardID) values ('Wait', 'Kilbee', 1);
insert into Employee (FirstName, LastName, YardID) values ('Jorey', 'Wasselin', 11);
insert into Employee (FirstName, LastName, YardID) values ('Cointon', 'Raulston', 12);
insert into Employee (FirstName, LastName, YardID) values ('Karlie', 'Wadly', 7);
insert into Employee (FirstName, LastName, YardID) values ('Debora', 'Haly', 9);
insert into Employee (FirstName, LastName, YardID) values ('Powell', 'Hele', 6);
insert into Employee (FirstName, LastName, YardID) values ('Julianna', 'Feeney', 6);
insert into Employee (FirstName, LastName, YardID) values ('Francois', 'Pindell', 1);
insert into Employee (FirstName, LastName, YardID) values ('Brena', 'Downage', 8);
insert into Employee (FirstName, LastName, YardID) values ('Jae', 'Adanez', 2);
insert into Employee (FirstName, LastName, YardID) values ('Crista', 'Boulter', 3);
insert into Employee (FirstName, LastName, YardID) values ('Betty', 'Halm', 4);
insert into Employee (FirstName, LastName, YardID) values ('Ediva', 'Lanfere', 10);
insert into Employee (FirstName, LastName, YardID) values ('Vivie', 'Leyre', 4);
insert into Employee (FirstName, LastName, YardID) values ('Lanni', 'Bundey', 9);
insert into Employee (FirstName, LastName, YardID) values ('Ricky', 'Orrum', 5);
insert into Employee (FirstName, LastName, YardID) values ('Thurstan', 'O''Sheeryne', 4);
insert into Employee (FirstName, LastName, YardID) values ('Merissa', 'Odd', 5);
insert into Employee (FirstName, LastName, YardID) values ('Lyndel', 'Howgill', 4);
insert into Employee (FirstName, LastName, YardID) values ('Melisenda', 'Lumbley', 6);
insert into Employee (FirstName, LastName, YardID) values ('Tiphanie', 'Lamdin', 7);
insert into Employee (FirstName, LastName, YardID) values ('Claiborn', 'Goodswen', 8);
insert into Employee (FirstName, LastName, YardID) values ('Steve', 'Colerick', 7);
insert into Employee (FirstName, LastName, YardID) values ('Micheline', 'Polding', 10);
insert into Employee (FirstName, LastName, YardID) values ('Vincenz', 'Congdon', 7);
insert into Employee (FirstName, LastName, YardID) values ('Cooper', 'Kach', 12);
insert into Employee (FirstName, LastName, YardID) values ('Sheena', 'Vuitton', 1);
insert into Employee (FirstName, LastName, YardID) values ('Brant', 'Thornthwaite', 7);
insert into Employee (FirstName, LastName, YardID) values ('Lisetta', 'Krier', 9);
insert into Employee (FirstName, LastName, YardID) values ('Giuditta', 'Dumbrill', 10);
insert into Employee (FirstName, LastName, YardID) values ('Arthur', 'Tamblingson', 8);
insert into Employee (FirstName, LastName, YardID) values ('Ashely', 'Seedull', 7);
insert into Employee (FirstName, LastName, YardID) values ('Verile', 'Lenz', 5);
insert into Employee (FirstName, LastName, YardID) values ('Jenda', 'Robrose', 4);
insert into Employee (FirstName, LastName, YardID) values ('Dael', 'Pennycook', 9);
insert into Employee (FirstName, LastName, YardID) values ('Ashlee', 'Denisard', 6);
insert into Employee (FirstName, LastName, YardID) values ('Kevyn', 'Pether', 11);
insert into Employee (FirstName, LastName, YardID) values ('Urbain', 'Allicock', 10);
insert into Employee (FirstName, LastName, YardID) values ('Karia', 'Colebourne', 10);
insert into Employee (FirstName, LastName, YardID) values ('Sheri', 'Davenall', 9);
insert into Employee (FirstName, LastName, YardID) values ('Mort', 'Greatbach', 12);
insert into Employee (FirstName, LastName, YardID) values ('Marylinda', 'Dun', 12);
insert into Employee (FirstName, LastName, YardID) values ('Thea', 'Leve', 9);
insert into Employee (FirstName, LastName, YardID) values ('Trent', 'Kydd', 3);
insert into Employee (FirstName, LastName, YardID) values ('Ludvig', 'Wallsam', 9);
insert into Employee (FirstName, LastName, YardID) values ('Gerhardt', 'Barwise', 5);
insert into Employee (FirstName, LastName, YardID) values ('Dylan', 'Fernez', 2);
insert into Employee (FirstName, LastName, YardID) values ('Sheree', 'Garnsworth', 11);
insert into Employee (FirstName, LastName, YardID) values ('Brenda', 'Diggle', 3);
insert into Employee (FirstName, LastName, YardID) values ('Dorrie', 'Cox', 3);
insert into Employee (FirstName, LastName, YardID) values ('Cobby', 'Geard', 8);
insert into Employee (FirstName, LastName, YardID) values ('Shir', 'Imm', 2);
insert into Employee (FirstName, LastName, YardID) values ('Allyn', 'Rentalll', 12);
insert into Employee (FirstName, LastName, YardID) values ('Maisie', 'Clemencet', 6);
insert into Employee (FirstName, LastName, YardID) values ('Ivan', 'Bick', 1);
insert into Employee (FirstName, LastName, YardID) values ('Joan', 'Petracco', 10);
insert into Employee (FirstName, LastName, YardID) values ('Natalya', 'Loche', 12);
insert into Employee (FirstName, LastName, YardID) values ('Tomaso', 'Davidowsky', 12);
insert into Employee (FirstName, LastName, YardID) values ('Nike', 'Perris', 7);
insert into Employee (FirstName, LastName, YardID) values ('Hermina', 'Westmorland', 2);
insert into Employee (FirstName, LastName, YardID) values ('Sara', 'Aiston', 7);
insert into Employee (FirstName, LastName, YardID) values ('Liva', 'Herreros', 10);
insert into Employee (FirstName, LastName, YardID) values ('Gertrudis', 'Curryer', 8);
insert into Employee (FirstName, LastName, YardID) values ('Dolly', 'Juan', 6);
insert into Employee (FirstName, LastName, YardID) values ('Penelopa', 'Jessup', 2);
insert into Employee (FirstName, LastName, YardID) values ('Klaus', 'Brookes', 8);
insert into Employee (FirstName, LastName, YardID) values ('Herbert', 'Grishanov', 5);
insert into Employee (FirstName, LastName, YardID) values ('Gratia', 'Sweett', 5);
insert into Employee (FirstName, LastName, YardID) values ('Barney', 'Sikorsky', 5);
insert into Employee (FirstName, LastName, YardID) values ('Ab', 'Sadd', 6);
insert into Employee (FirstName, LastName, YardID) values ('Kelcey', 'Dewen', 12);
insert into Employee (FirstName, LastName, YardID) values ('Nicol', 'Dolling', 6);
insert into Employee (FirstName, LastName, YardID) values ('Martie', 'Spencer', 8);
insert into Employee (FirstName, LastName, YardID) values ('Herta', 'Nelius', 8);
insert into Employee (FirstName, LastName, YardID) values ('Herc', 'Cremin', 5);
insert into Employee (FirstName, LastName, YardID) values ('Krissie', 'McNaughton', 5);
insert into Employee (FirstName, LastName, YardID) values ('Quinn', 'Davern', 11);
insert into Employee (FirstName, LastName, YardID) values ('Pierette', 'Snepp', 7);
insert into Employee (FirstName, LastName, YardID) values ('Luisa', 'Lemmers', 5);
insert into Employee (FirstName, LastName, YardID) values ('Boigie', 'Insoll', 11);
insert into Employee (FirstName, LastName, YardID) values ('Mariejeanne', 'Keems', 4);
insert into Employee (FirstName, LastName, YardID) values ('Clerc', 'Chaldecott', 9);
insert into Employee (FirstName, LastName, YardID) values ('Ludwig', 'Berrisford', 6);
insert into Employee (FirstName, LastName, YardID) values ('Brett', 'Rigglesford', 9);
insert into Employee (FirstName, LastName, YardID) values ('Norri', 'Phillipp', 4);
insert into Employee (FirstName, LastName, YardID) values ('Lewes', 'Tiesman', 2);
insert into Employee (FirstName, LastName, YardID) values ('Elisabetta', 'Rubberts', 10);
insert into Employee (FirstName, LastName, YardID) values ('Von', 'Bondar', 11);
insert into Employee (FirstName, LastName, YardID) values ('Michele', 'Wistance', 6);
insert into Employee (FirstName, LastName, YardID) values ('Seamus', 'Wroe', 9);
insert into Employee (FirstName, LastName, YardID) values ('Eustacia', 'O''Crevy', 8);
insert into Employee (FirstName, LastName, YardID) values ('Remus', 'Kaysor', 8);
insert into Employee (FirstName, LastName, YardID) values ('Randolf', 'Mates', 5);
insert into Employee (FirstName, LastName, YardID) values ('Dorena', 'Millis', 7);
insert into Employee (FirstName, LastName, YardID) values ('Octavius', 'Danforth', 1);
insert into Employee (FirstName, LastName, YardID) values ('Aprilette', 'Lenaghen', 4);
insert into Employee (FirstName, LastName, YardID) values ('Chelsea', 'Kauscher', 11);
insert into Employee (FirstName, LastName, YardID) values ('Storm', 'Scully', 8);
insert into Employee (FirstName, LastName, YardID) values ('Giovanna', 'Slot', 8);
insert into Employee (FirstName, LastName, YardID) values ('Nico', 'Lanchester', 11);
insert into Employee (FirstName, LastName, YardID) values ('Cletis', 'Muff', 5);
insert into Employee (FirstName, LastName, YardID) values ('Adel', 'Sabater', 1);
insert into Employee (FirstName, LastName, YardID) values ('Pearla', 'Hovell', 4);
insert into Employee (FirstName, LastName, YardID) values ('Rosette', 'Chessor', 8);
insert into Employee (FirstName, LastName, YardID) values ('Reggie', 'Fawdrey', 6);
insert into Employee (FirstName, LastName, YardID) values ('Katheryn', 'Dy', 9);
insert into Employee (FirstName, LastName, YardID) values ('Gloria', 'Amos', 1);
insert into Employee (FirstName, LastName, YardID) values ('Adeline', 'Fraczak', 10);
insert into Employee (FirstName, LastName, YardID) values ('Pren', 'Popescu', 8);
insert into Employee (FirstName, LastName, YardID) values ('Jodie', 'Braidford', 8);
insert into Employee (FirstName, LastName, YardID) values ('Maia', 'Qusklay', 5);
insert into Employee (FirstName, LastName, YardID) values ('Kerwin', 'Caplan', 1);
insert into Employee (FirstName, LastName, YardID) values ('Channa', 'Hume', 9);
insert into Employee (FirstName, LastName, YardID) values ('Perle', 'Renny', 7);
insert into Employee (FirstName, LastName, YardID) values ('Patience', 'Eykelhof', 6);
insert into Employee (FirstName, LastName, YardID) values ('Robenia', 'Tappington', 6);
insert into Employee (FirstName, LastName, YardID) values ('Golda', 'Shipman', 9);
insert into Employee (FirstName, LastName, YardID) values ('Neille', 'Huddart', 2);
insert into Employee (FirstName, LastName, YardID) values ('Farah', 'Paike', 4);
insert into Employee (FirstName, LastName, YardID) values ('Lodovico', 'Symcox', 3);
insert into Employee (FirstName, LastName, YardID) values ('Clair', 'Kynsey', 12);
insert into Employee (FirstName, LastName, YardID) values ('Wendi', 'GiacobbiniJacob', 1);
insert into Employee (FirstName, LastName, YardID) values ('Adey', 'Ulyat', 3);
insert into Employee (FirstName, LastName, YardID) values ('Ignace', 'Roback', 8);
insert into Employee (FirstName, LastName, YardID) values ('Adriaens', 'Plank', 7);
insert into Employee (FirstName, LastName, YardID) values ('Mohandis', 'Massenhove', 5);
insert into Employee (FirstName, LastName, YardID) values ('Kristina', 'Gasnell', 5);
insert into Employee (FirstName, LastName, YardID) values ('Ives', 'Tremblay', 2);
insert into Employee (FirstName, LastName, YardID) values ('Abraham', 'Rachuig', 11);
insert into Employee (FirstName, LastName, YardID) values ('Olly', 'Dalgleish', 8);
insert into Employee (FirstName, LastName, YardID) values ('Keelby', 'Gaenor', 6);
insert into Employee (FirstName, LastName, YardID) values ('Collen', 'Ricciardelli', 6);
insert into Employee (FirstName, LastName, YardID) values ('Curr', 'Bromidge', 3);
insert into Employee (FirstName, LastName, YardID) values ('Melisandra', 'Rodolf', 3);

