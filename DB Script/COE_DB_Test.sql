--Create DATABASE COE_DB
Drop Table SBM

Drop Table Pruning

Drop Table Mulching

Drop Table Grass

Drop Table SiteHazard

Drop Table ToolsCheckList

Drop Table CrewSite

Drop Table CrewMember

Drop Table Crew

Drop Table Tool

Drop Table Unit

Drop Table Site 

Drop Table Employee

Drop Table CorrectiveAction

Drop Table Hazard

Drop Table Yard

Drop Table Community

Drop Table HazardCategory

Drop Table SiteType

Drop Table District

Drop Table Season


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
	HazardCategoryName varchar(100) not null
)

create table Community
(
	CommunityID integer identity(1,1) not null constraint pk_Community primary key clustered,
	Name varchar(50) not null
)

create table Season
(
	SeasonID integer identity not null constraint pk_season primary key clustered,
	SeasonYear int not null
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
	HazardDescription varchar(100) not null,
	HazardCategoryID int null constraint fk_Hazard_To_HazardCategory references hazardCategory(HazardCategoryID)
)

------------------------SECOND CHILDREN----------------------------------------
create table CorrectiveAction
(
	CorrectiveActionID integer identity(1,1) not null constraint pk_CorrectiveAction primary key clustered,
	CorrectiveActionDescription varchar(500) not null,
	HazardID int not null constraint fk_CorrectiveAction_To_hazard references Hazard(HazardID)
)

create table Employee
(
	EmployeeID integer identity(1,1) not null constraint pk_Employee primary key clustered,
	FirstName varchar(20) not null,
	LastName varchar(20) not null,
	Phone varchar(13) null constraint ck_phone check (Phone like '([1-9][0-9][0-9]) [0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	YardID int not null constraint fk_Employee_To_Yard references Yard(YardID),
	TeamLeader bit constraint df_NotTeamLeader default null,
	CrewLeader bit constraint df_NotCrewLeader default null,
	Gardener bit constraint df_NotGardener default null,
	Labourer bit 
			     --constraint ck_CrewLeader_is_Gardener check(CrewLeader is not null and Gardener is not null)
)
 create table Site
 (
	SiteID integer identity(1,1) not null constraint pk_Site primary key clustered,
	Pin int not null,
	Neighbourhood varchar(50) not null,
	StreetAddress varchar(35) null,
	Area int not null, 
	Notes varchar(1000) null,
	Grass int constraint df_GrassOnSite default 0,
	SiteTypeID int not null constraint fk_Site_To_SiteType references SiteType(SiteTypeID),
	YardID int not null constraint fk_Site_To_yard references Yard(YardID),
	CommunityID int not null constraint fk_Site_To_Community references Community(CommunityID),
	SeasonID int not null constraint fk_Site_To_Season references Season(SeasonID),
 )

 create table Unit
 (
	UnitID integer identity not null constraint pk_Unit primary key clustered,
	UnitNumber varchar(20) not null,
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

create table Crew
(
	CrewID integer identity(1,1) not null constraint pk_Crew primary key clustered,
	CrewDate datetime not null,
	UnitID int not null constraint fk_Crew_To_Unit references Unit(UnitID),
	KM_Start int null,
	KM_End int null,
	AdditionalComments varchar(100) null,
	constraint ck_KM_End_GreaterThan_KM_Start check (KM_End >= KM_Start)
)

create table CrewMember
(
	CrewMemberID integer identity not null constraint pk_CrewMember primary key clustered,
	EmployeeID int not null constraint fk_CrewMwmber_To_Employee references Employee(EmployeeID),
	Driver  bit constraint df_NotDriver default null, 
	FLHA_CompletedBy  bit constraint df_DidNotCompleteFLHA default null,
	CrewID int not null constraint fk_CrewMember_To_Crew references Crew(CrewID)
)

create table CrewSite
(
	CrewSiteID Integer identity(1,1) not null constraint pk_CrewSite primary key clustered,
	SiteID int null constraint fk_CrewSite_to_Site references Site(SiteID),
	TaskDescription varchar(100) null,
	TimeOnSite time null,
    TimeOffSite time null,
	ActionRequired varchar(100) null,
	CrewID int not null constraint fk_CrewSite_To_Crew references Crew(CrewID)
)


create table ToolsChecklist
(
	ToolCheckListID integer identity(1,1) not null constraint pk_ToolCheckList primary key clustered,
	ToolID int not null constraint fk_ToolsChecklist_To_Tool references Tool(ToolID),
	Quantity int null,
	CrewID int not null constraint fk_ToolsChecklist_To_Crew references Crew(CrewID)
)

create table SiteHazard
(
	SiteHazardID integer identity(1,1) not null constraint pk_SiteHazard primary key clustered,
	HazardID int not null constraint fk_SiteHazard_To_Hazard references hazard(HazardID),
	CrewSiteID int not null constraint fk_SiteHazard_To_Site references CrewSite(CrewSiteID),
	ReviewedBy int null,
	ReviewedDate Datetime null
)

Create table SBM
(
	SBM_StatusID integer identity(1,1) not null  constraint pk_SBM primary key clustered,
	CrewSIteID int not null constraint fk_SBM_To_CrewSiteID references CrewSite(CrewSiteID),
	TaskDescription varchar(50) not null
)

create table Pruning
(
	PruningStatusID integer identity(1,1) not null constraint pk_Pruning primary key clustered,
	CrewSiteID int not null constraint fk_Pruning_To_CrewSite references CrewSite(CrewSiteID)
)

create table Mulching
(
	MulchingStatusID integer identity(1,1) not null constraint pk_Mulching primary key clustered,
	CrewSiteID int not null constraint fk_Mulching_To_CrewSite references CrewSite(CrewSiteID)
)

create table Grass
(
	GrassStatusID integer identity(1,1) not null constraint pk_Grass primary key clustered,
	CrewSiteID int not null constraint fk_Grass_To_CrewSite references CrewSite(CrewSiteID)
)

/*DISTRICT*/
Insert into District (DistrictName)
Values('North-West')

Insert into District (DistrictName)
Values('North-East')

Insert into District (DistrictName)
Values('South-West')

Insert into District (DistrictName)
Values('South-East')

/*SEASON*/
Insert into Season
Values(2016)

Insert into Season
Values(2017)

Insert into Season
Values(2018)

Insert into Season
Values(2019)


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


/*COMMUNITY*/
insert into Community (Name) values ('Blue Quill');
insert into Community (Name) values ('Heritage');
insert into Community (Name) values ('Ambleside');
insert into Community (Name) values ('Steel Hight');
insert into Community (Name) values ('Margrath');
---------------------------------------------------------------------------------------
                                 /*SITETYPE*/
insert into SiteType(SiteTypeDescription, NumberOfCyle)
Values('A', 5)

insert into SiteType(SiteTypeDescription, NumberOfCyle)
Values('B', 2)

----------------------------------------------------------------------------------------------
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, SiteTypeID, YardID, CommunityID, SeasonID) values (492282, 'Southgate Mall', '11001 25 Ave', 2584, null, 30, 1, 1, 1, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (589622, 'O"Keefe', '125036 Wlaterdale', 8275, null, 1, 1, 1, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, SiteTypeID, YardID, CommunityID, SeasonID) values (369852, 'Hermitage', '114 Street & 15 Ave', 265, null, 102, 1, 1, 1, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (120589, 'River Valley', '1047 Jasper Ave', 1124, null, 1, 1, 1, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (20583, 'Ndog-Bong', '9 Street & 57 Ave', 2002, null, 1, 1, 1, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (968452, 'Twin Brooks', '10258 23 Street', 4040, null, 1, 1, 1, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, SiteTypeID, YardID, CommunityID, SeasonID) values (895762, 'McEwan', '2682 McAllister Loop', 306, null, 10, 1, 1, 2, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (258964, 'McEwan', '50 Street & 101 Ave', 487, null, 1, 1, 2, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, SiteTypeID, YardID, CommunityID, SeasonID) values (89657, 'Allard', '90 Del Mar Court', 8800, null, 25, 1, 1, 2, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (120588, 'Asteraceae', '10258 127 Street', 2013, null, 1, 1, 2, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (301844, 'Star Wars', '12506 Roper Road', 256, null, 1, 1, 3, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (421256, 'Twin Towers', '36 Street & 128 Ave', 854, null, 1, 1, 3, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (685249, 'South Common', '111 Street & Gateway Boulevard', 8275, null, 1, 1, 3, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (789005, 'South Park', 'Calgary Trail & 25 Ave', 62, null, 1, 1, 3, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, SiteTypeID, YardID, CommunityID, SeasonID) values (741056, 'Glenridding', '117 Street & 115 Ave', 45, null, 47, 1, 1, 4, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (942039, 'Glenridding', '120 Street & 105 Ave', 2258, null, 1, 1, 4, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (8520, 'Landcaster', '12745 Leger Trail', 115, null, 1, 1, 4, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (10236, 'Victoria Hights', '19 Street & 12 AVe', 20, null, 1, 1, 4, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (452289, 'Mercedes', '91 Street & Victoria Trail', 152, null, 1, 1, 5, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass,SiteTypeID, YardID, CommunityID, SeasonID) values (3332545, 'Buleya', '11011 29A Ave', 25, null, 73, 1, 1, 5, 4);

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

										/*UNIT*/
insert into Unit (UnitNumber, UnitDescription, YardID) values ('WA1CGAFP8EA122491', '2-Ton Truck', 1);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('1G4GC5GR4CF868507', '2-Ton Truck', 1);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('WAUJC68E32A759623', '1-Ton truck', 1);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------




-----------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into Crew (CrewDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/20/2019', 2, 197, 715, null);

insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (1, 'Pruning', '07:15', '09:08', null, 1);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (2, 'Pruning', '10:07', '11:48', null, 1);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (3, 'Pruning', '12:00', '12:45', null, 1);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (4, 'Pruning', '13:10', '13:50', null, 1);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (5, 'Pruning', '14:07', '14:45', null, 1);

insert into SBM (CrewSiteID, TaskDescription) values (1, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (2, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (3, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (4, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (5, 'Grass Pulling');
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into Crew (CrewDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/21/2019', 2, 197, 715, null);

insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (6, 'Pruning', '07:15', '08:08', null, 2);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (7, 'Pruning', '08:15', '09:20', null, 2);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (8, 'Pruning', '09:30', '10:50', null, 2);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (9, 'Pruning', '11:15', '11:45', null, 2);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (10, 'Pruning', '12:15', '13:20', null, 2);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (11, 'Pruning', '13:30', '14:40', null, 2);

insert into SBM (CrewSiteID, TaskDescription) values (6, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (7, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (8, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (9, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (10, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (11, 'Grass Pulling');
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into Crew (CrewDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/22/2019', 2, 197, 715, null);

insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (1, 'Pruning', '07:15', '08:08', null, 3);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (2, 'Pruning', '08:15', '09:20', null, 3);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (3, 'Pruning', '09:30', '10:50', null, 3);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (12, 'Pruning', '11:15', '11:45', null, 3);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (13, 'Pruning', '12:15', '13:20', null, 3);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (14, 'Pruning', '13:30', '14:40', null, 3);

insert into SBM (CrewSiteID, TaskDescription) values (12, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (13, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (14, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (15, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (16, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (17, 'Grass Pulling');
------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into Crew (CrewDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/23/2019', 2, 197, 715, null);

insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (4, 'Pruning', '07:15', '08:08', null, 4);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (5, 'Pruning', '08:15', '09:20', null, 4);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (6, 'Pruning', '09:30', '10:50', null, 4);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (15, 'Pruning', '11:15', '11:45', null, 4);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (16, 'Pruning', '12:15', '13:20', null, 4);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (17, 'Pruning', '13:30', '14:40', null, 4);

insert into SBM (CrewSiteID, TaskDescription) values (18, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (19, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (20, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (21, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (22, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (23, 'Grass Pulling');
----------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into Crew (CrewDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('2/12/2019', 2, 197, 715, null);


insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (1, 'Pruning', '07:15', '08:08', null, 5);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (2, 'Pruning', '08:15', '09:20', null, 5);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (18, 'Pruning', '09:30', '10:50', null, 5);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (12, 'Pruning', '11:15', '11:45', null, 5);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (19, 'Pruning', '12:15', '13:20', null, 5);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (20, 'Pruning', '13:30', '14:40', null, 5);

insert into SBM (CrewSiteID, TaskDescription) values (24, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (25, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (26, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (27, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (28, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (29, 'Grass Pulling');
------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into Crew (CrewDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('2/20/2019', 2, 197, 715, null);


insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (1, 'Pruning', '07:15', '08:08', null, 6);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (2, 'Pruning', '08:15', '09:20', null, 6);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (3, 'Pruning', '09:30', '10:50', null, 6);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (5, 'Pruning', '11:15', '11:45', null, 6);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (6, 'Pruning', '12:15', '13:20', null, 6);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (7, 'Pruning', '13:30', '14:40', null, 6);

insert into SBM (CrewSiteID, TaskDescription) values (30, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (31, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (32, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (33, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (34, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (35, 'Grass Pulling');

------------------------------------------------------------------------------------------------------------------------------------------------------------------
insert into Crew (CrewDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('3/01/2019', 2, 197, 715, null);


insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (1, 'Pruning', '07:15', '08:08', null, 7);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (2, 'Pruning', '08:15', '09:20', null, 7);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (3, 'Pruning', '09:30', '10:50', null, 7);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (10, 'Pruning', '11:15', '11:45', null, 7);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (11, 'Pruning', '12:15', '13:20', null, 7);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (12, 'Pruning', '13:30', '14:40', null, 7);

insert into SBM (CrewSiteID, TaskDescription) values (36, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (37, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (38, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (39, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (40, 'Grass Pulling');
insert into SBM (CrewSiteID, TaskDescription) values (41, 'Grass Pulling');


----------------------------------------------------------------------------------------------------------------------------------------------------
					/*Grass*/
insert into Grass (CrewSiteID) values (8);
insert into Grass (CrewSiteID) values (13);
insert into Grass (CrewSiteID) values (7);
insert into Grass (CrewSiteID) values (16);
insert into Grass (CrewSiteID) values (11);
insert into Grass (CrewSiteID) values (12);
insert into Grass (CrewSiteID) values (2);
insert into Grass (CrewSiteID) values (6);
insert into Grass (CrewSiteID) values (4);
insert into Grass (CrewSiteID) values (20);
------------------------------------------------------------------------------------------------------------------------------

				/* Mulching*/
insert into Mulching (CrewSiteID) values (14);
insert into Mulching (CrewSiteID) values (11);
insert into Mulching (CrewSiteID) values (15);
insert into Mulching (CrewSiteID) values (6);
insert into Mulching (CrewSiteID) values (13);
insert into Mulching (CrewSiteID) values (16);
insert into Mulching (CrewSiteID) values (17);
------------------------------------------------------------------------------------------------------------------------------

						/*Pruning*/
insert into Pruning (CrewSiteID) values (7);
insert into Pruning (CrewSiteID) values (4);
insert into Pruning (CrewSiteID) values (2);
insert into Pruning (CrewSiteID) values (17);
insert into Pruning (CrewSiteID) values (6);
insert into Pruning (CrewSiteID) values (11);
insert into Pruning (CrewSiteID) values (8);
-----------------------------------------------------------------------------------------------------------------------------
									/*Employee*/
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Neely', 'Gaffer', '(458) 6085483', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Nicolis', 'Joist', '(906) 9212728', 3, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Fenelia', 'Spearing', '(568) 5895758', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Audie', 'Shoebrook', '(706) 4043346', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Caresse', 'Codner', '(473) 6177730', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Donna', 'Pascow', '(516) 3806183', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Esra', 'Jerschke', '(871) 4397391', 3, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Rhett', 'Duthie', '(634) 3606008', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Jandy', 'Dunsmuir', '(248) 3191035', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Daryl', 'Matiashvili', '(223) 7646424', 2, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Paolo', 'Cleugher', '(589) 9797442', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Tait', 'Fulmen', '(980) 9503182', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Elana', 'Fishpoole', '(113) 4914910', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Ursa', 'Pittendreigh', '(313) 4801921', 2, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Lucio', 'Bromwich', '(730) 3459495', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Kaitlynn', 'Gethyn', '(959) 2258979', 3, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Rochester', 'Pechan', '(518) 8248236', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Jamison', 'Housaman', '(357) 6150620', 3, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Mara', 'Bodocs', '(505) 5570430', 3, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Kailey', 'Kelf', '(882) 9682880', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Perren', 'Ivens', '(555) 5107445', 2, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Brand', 'Tomankowski', '(564) 9320661', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Nollie', 'Stainer', '(503) 7104129', 2, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Jillane', 'Dunnet', '(317) 1599912', 3, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Dania', 'McWilliam', '(349) 9947732', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Tucky', 'Gait', '(296) 9169502', 2, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Dulcie', 'Carlin', '(839) 7305403', 2, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Susann', 'Brigginshaw', '(489) 2389477', 3, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Clemmie', 'Dudill', '(949) 6863263', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Sheppard', 'Busher', '(574) 3544710', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Vonny', 'Ander', '(758) 7660451', 3, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Felicdad', 'Boc', '(741) 5907613', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Teddi', 'Moulden', '(260) 3302737', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Emmi', 'McKinnon', '(571) 5046184', 3, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Marylynne', 'Jilkes', '(500) 9266608', 2, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Reinhold', 'Chang', '(270) 1288147', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Susann', 'Hindenburg', '(910) 5306583', 3, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Rosamund', 'Vaughan-Hughes', '(144) 7857041', 2, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Darcy', 'Obell', '(919) 6187705', 3, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Shanon', 'Pedrazzi', '(929) 6829365', 3, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Nadean', 'Brimilcome', '(553) 8331021', 2, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Shayla', 'Moulton', '(693) 8923871', 3, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Albrecht', 'Pert', '(540) 9229554', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Maighdiln', 'Biggen', '(914) 3094481', 3, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Sergei', 'Rameaux', '(547) 7934424', 2, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Kimball', 'Galego', '(607) 1982856', 1, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Denice', 'Loosley', '(423) 6706098', 2, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Daffi', 'Gellett', '(968) 2668208', 2, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Patten', 'Borzoni', '(961) 5169338', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Laney', 'Swyne', '(496) 6873622', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Judy', 'Amis', '(167) 1385319', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Lindie', 'Godwyn', '(866) 9937415', 5, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Morey', 'Fay', '(775) 5351652', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Alard', 'Queree', '(830) 8770804', 6, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Gabbie', 'Biner', '(682) 4122539', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Marcela', 'Leeves', '(478) 5182363', 6, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Kat', 'Luetkemeyers', '(928) 4568974', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Victoria', 'Aingel', '(848) 4401641', 6, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Iago', 'Sarfas', '(876) 9946221', 5, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Shaun', 'Lower', '(404) 7168843', 5, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Waylen', 'Sheldrick', '(187) 7816097', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Jackson', 'Klimowski', '(932) 6078113', 5, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Amos', 'Mercy', '(935) 3708790', 5, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Mozelle', 'Packer', '(795) 3221507', 8, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Kally', 'Mold', '(497) 2152905', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Law', 'Robey', '(635) 6780890', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Corri', 'Tindall', '(623) 3790745', 5, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Kingsley', 'Ledingham', '(365) 3696323', 5, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Xylia', 'Surgison', '(792) 9854533', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Desiri', 'Kittoe', '(504) 6643811', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Nesta', 'Rugg', '(102) 3495258', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Dulce', 'Domleo', '(242) 5513069', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Florida', 'Ferrara', '(266) 8318210', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Lanette', 'Aguirrezabala', '(880) 1573798', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Fredra', 'Biggin', '(755) 7616603', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Packston', 'Worcester', '(133) 9128038', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Julianne', 'McClinton', '(565) 7086169', 8, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Kirby', 'Naire', '(668) 6391967', 8, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Jerry', 'Copsey', '(893) 7792602', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Lyon', 'Paddy', '(404) 5029581', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Brandea', 'Gaytor', '(907) 8666658', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Mitchel', 'Godmer', '(774) 2283225', 6, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Wilfred', 'Kerby', '(659) 1973728', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Zabrina', 'Grigoire', '(596) 2445236', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Adi', 'Cesco', '(284) 6188182', 5, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Janeczka', 'Duley', '(516) 7528895', 6, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Caz', 'Sturzaker', '(631) 4238906', 5, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Alexis', 'Hess', '(748) 7378510', 6, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Kaile', 'Boarleyson', '(175) 4305957', 5, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Lotte', 'Milsted', '(146) 9579332', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Stefania', 'Krojn', '(714) 3977011', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Morgan', 'Swinbourne', '(322) 1011322', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Margaretha', 'Bison', '(839) 1017897', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Nikki', 'Fenners', '(385) 2676878', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Cchaddie', 'Sutheran', '(365) 3994595', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Carie', 'Kleinhandler', '(432) 1850520', 5, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Lorenzo', 'Dyshart', '(178) 2000893', 6, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Meier', 'Maisey', '(545) 2364731', 8, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Thorndike', 'Kean', '(258) 7412749', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Nanice', 'Bousfield', '(161) 2309010', 8, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Milly', 'Dasent', '(571) 8440511', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Ford', 'Rawne', '(349) 7126373', 8, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Barry', 'Horbart', '(756) 9591979', 6, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Gratia', 'Hue', '(230) 9405954', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Bill', 'Winspare', '(432) 8473014', 5, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Rex', 'Sandercock', '(824) 9860616', 5, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Rick', 'Cave', '(209) 2124857', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Lira', 'Canas', '(222) 8952089', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Dulcy', 'Urvoy', '(555) 4628997', 5, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Tudor', 'Ellings', '(767) 4609185', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Leland', 'Hayles', '(469) 2786963', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Marcelle', 'Broadbent', '(547) 1631105', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Bobbie', 'Pott', '(508) 2966393', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Baudoin', 'Beneix', '(313) 3048661', 6, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Lockwood', 'Perrins', '(603) 6626107', 8, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Dmitri', 'Extil', '(164) 5128433', 8, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Heddie', 'Bourtoumieux', '(626) 7807972', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Birgitta', 'Rickson', '(115) 7608409', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Margy', 'O''Keeffe', '(189) 6342359', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Lewiss', 'Brangan', '(778) 4762643', 8, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Magdalene', 'Hillock', '(164) 2776885', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Tanya', 'Gostall', '(286) 1881022', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Kalila', 'Coit', '(332) 9521872', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Sheppard', 'Motherwell', '(227) 6056076', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Maryanne', 'Glassard', '(169) 9057969', 6, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Kenyon', 'Nairns', '(645) 2372869', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Deena', 'Harvard', '(251) 2468078', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Luke', 'Teasey', '(284) 4645732', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Meredith', 'Yezafovich', '(442) 9885247', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Jackie', 'Penhale', '(590) 2349663', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Ode', 'Wyllis', '(270) 4566296', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Merell', 'Fance', '(368) 9373515', 6, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Marlin', 'Fladgate', '(106) 4666540', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Irina', 'Kleszinski', '(857) 4659457', 8, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Bert', 'Lower', '(955) 9197914', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Malissa', 'Carr', '(769) 3618701', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Douglass', 'Blader', '(878) 7637511', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Sinclair', 'Alderson', '(777) 6784661', 7, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Guthry', 'Simmens', '(888) 8278862', 8, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Mari', 'Brugger', '(943) 7809991', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Stefano', 'Demeter', '(888) 5313261', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Mandy', 'Sharrard', '(290) 8217592', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Tiphanie', 'Hundell', '(114) 6141157', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Violette', 'Syrad', '(870) 1045364', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Meryl', 'Garmston', '(738) 4478212', 5, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Cynde', 'Dullingham', '(622) 5302317', 6, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Devland', 'Zienkiewicz', '(310) 2837088', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Katina', 'Dosdell', '(290) 1217418', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Weidar', 'Akker', '(462) 2900419', 5, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Cecil', 'Dahlbom', '(258) 5201496', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Briney', 'Fillgate', '(697) 2463657', 5, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Thornie', 'Judron', '(447) 3273743', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Hetty', 'Stive', '(127) 6963928', 9, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Becka', 'MacDunlevy', '(422) 4298565', 4, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Gael', 'Brader', '(942) 6071693', 8, 0, 0, 1);
insert into Employee (FirstName, LastName, Phone, YardID, TeamLeader, CrewLeader, Labourer) values ('Collete', 'Akroyd', '(170) 2761854', 5, 0, 0, 1);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
										/*UNIT*/
insert into Unit (UnitNumber, UnitDescription, YardID) values ('WA1CGAFP8EA122491', '2-Ton Truck', 1);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('1G4GC5GR4CF868507', '2-Ton Truck', 2);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('WAUJC68E32A759623', '1-Ton truck', 6);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('3VW507AT6FM654186', '2-Ton Truck', 3);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('WBADR63412G715143', '3/4-Ton Truck', 1);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('1D4PU5GK2AW827636', '3/4-Ton Truck', 3);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('2HNYD18402H249606', '2-Ton Truck', 1);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('WAUKG98E16A960789', '1-Ton truck', 7);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('1VWAS7A37FC170246', '2-Ton Truck', 7);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('WBAWV53598P719649', '3/4-Ton Truck', 5);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('WAU2GAFC4DN395012', '3/4-Ton Truck', 8);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('2C3CDXEJ6EH806380', '2-Ton Truck', 2);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('5N1AR2MM7DC934384', '2-Ton Truck', 5);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('JN1BV7AP8FM606827', '1-Ton truck', 8);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('WBAVA33598K659459', '3/4-Ton Truck', 6);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('5NPDH4AE5DH411043', '3/4-Ton Truck', 2);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('JN8AZ2KR3CT570860', '2-Ton Truck', 5);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('5TDDCRFH7FS122421', '1-Ton truck', 1);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('3D7JB1EP7AG018153', '1-Ton truck', 4);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('5NMSG3AB5AH620446', '1-Ton truck', 1);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('WBABD53484P371328', '3/4-Ton Truck', 1);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('TRUUT28N931867969', '3/4-Ton Truck', 1);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('1GD311CG6FF371514', '1-Ton truck', 9);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('2C3CCAEG3EH911706', '1-Ton truck', 2);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('1G4GB5GR9FF325550', '1-Ton truck', 7);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('1C3CCBBB8EN682039', '3/4-Ton Truck', 8);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('19UUA65545A427724', '2-Ton Truck', 8);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('KM8JT3AC1AU799640', '3/4-Ton Truck', 3);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('2HNYD18763H734991', '2-Ton Truck', 5);

-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
insert into Crew (CrewDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/21/2020', 1, 197, 715, null);

insert into CrewMember (EmployeeID, Driver, FLHA_CompletedBy, CrewID) values (1, 1, 1, 8);
insert into CrewMember (EmployeeID, Driver, FLHA_CompletedBy, CrewID) values (3, 0, 0, 8);
insert into CrewMember (EmployeeID, Driver, FLHA_CompletedBy, CrewID) values (4, 0, 0, 8);
insert into CrewMember (EmployeeID, Driver, FLHA_CompletedBy, CrewID) values (5, 0, 0, 8);
insert into CrewMember (EmployeeID, Driver, FLHA_CompletedBy, CrewID) values (6, 0, 0, 8);

insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (1, 'Pruning', '07:15', '08:08', null, 8);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (2, 'Pruning', '07:15', '08:08', null, 8);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (3, 'Pruning', '07:15', '08:08', null, 8);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (4, 'Pruning', '07:15', '08:08', null, 8);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (5, 'Pruning', '07:15', '08:08', null, 8);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (6, 'Pruning', '07:15', '08:08', null, 8);
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
insert into Crew (CrewDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/21/2020', 2, 187, 315, null);

insert into CrewMember (EmployeeID, Driver, FLHA_CompletedBy, CrewID) values (8, 1, 0, 9);
insert into CrewMember (EmployeeID, Driver, FLHA_CompletedBy, CrewID) values (9, 0, 0, 9);
insert into CrewMember (EmployeeID, Driver, FLHA_CompletedBy, CrewID) values (11, 0, 1, 9);
insert into CrewMember (EmployeeID, Driver, FLHA_CompletedBy, CrewID) values (12, 0, 0, 9);
insert into CrewMember (EmployeeID, Driver, FLHA_CompletedBy, CrewID) values (13, 0, 0, 9);

insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (7, 'Pruning', '07:15', '08:08', null, 9);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (8, 'Pruning', '07:15', '08:08', null, 9);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (9, 'Pruning', '07:15', '08:08', null, 9);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (10, 'Pruning', '07:15', '08:08', null, 9);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (11, 'Pruning', '07:15', '08:08', null, 9);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (12, 'Pruning', '07:15', '08:08', null, 9);
-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
insert into Crew (CrewDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/21/2020', 3, 187, 315, null);

insert into CrewMember (EmployeeID, Driver, FLHA_CompletedBy, CrewID) values (15, 1, 0, 10);
insert into CrewMember (EmployeeID, Driver, FLHA_CompletedBy, CrewID) values (17, 0, 1, 10);
insert into CrewMember (EmployeeID, Driver, FLHA_CompletedBy, CrewID) values (20, 0, 0, 10);

insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (13, 'Pruning', '07:15', '08:08', null, 10);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (14, 'Pruning', '07:15', '08:08', null, 10);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (15, 'Pruning', '07:15', '08:08', null, 10);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (16, 'Pruning', '07:15', '08:08', null, 10);

-------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------------
insert into Crew (CrewDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/21/2020', 8, 187, 315, null);

insert into CrewMember (EmployeeID, Driver, FLHA_CompletedBy, CrewID) values (22, 1, 0, 11);
insert into CrewMember (EmployeeID, Driver, FLHA_CompletedBy, CrewID) values (25, 0, 0, 11);
insert into CrewMember (EmployeeID, Driver, FLHA_CompletedBy, CrewID) values (29, 0, 0, 11);
insert into CrewMember (EmployeeID, Driver, FLHA_CompletedBy, CrewID) values (30, 0, 1, 11);

insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (17, 'Pruning', '07:15', '08:08', null, 11);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (18, 'Pruning', '07:15', '08:08', null, 11);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (19, 'Pruning', '07:15', '08:08', null, 11);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (20, 'Pruning', '07:15', '08:08', null, 11);

/*select*from YARD	
select*from Community
select*from Season
select*from SiteType
select*from site order by YardID
select*from Unit
Select*from Crew
select*from CrewSite 
select*from SBM order by CrewSIteID
select*from Grass order by CrewSIteID
select*from Mulching order by CrewSIteID
select*from Employee order by EmployeeID
select*from Unit order by YardID
select*from CrewMember where CrewID = 13
*/