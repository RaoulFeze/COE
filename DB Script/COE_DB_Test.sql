--Create DATABASE COE_DB_TEST
--Drop Table SBM

--Drop Table Pruning

--Drop Table Mulching

--Drop Table Grass


--Drop Table SiteHazard

--Drop Table ToolsCheckList

--Drop Table CrewSite

--Drop Table CrewMember

--Drop Table Crew

--Drop Table Tool

--Drop Table Unit

--Drop Table Site 

--Drop Table Employee

--Drop Table CorrectiveAction

--Drop Table Hazard

--Drop Table Yard

--Drop Table Community

--Drop Table HazardCategory

--Drop Table SiteType

--Drop Table District

--Drop Table Season


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
	Grass bit constraint df_GrassOnSite default null,
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
	TodayDate datetime not null,
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
	SiteID int not null constraint fk_CrewSite_to_Site references Site(SiteID),
	TaskDescription varchar(100) not null,
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
	TaskDescription varchar(50) not null,
	Completed bit null
)

create table Pruning
(
	PruningStatusID integer identity(1,1) not null constraint pk_Pruning primary key clustered,
	CrewSiteID int not null constraint fk_Pruning_To_CrewSite references CrewSite(CrewSiteID),
	Completed bit null
)

create table Mulching
(
	MulchingStatusID integer identity(1,1) not null constraint pk_Mulching primary key clustered,
	CrewSiteID int not null constraint fk_Mulching_To_CrewSite references CrewSite(CrewSiteID),
	Completed bit null
)

create table Grass
(
	GrassStatusID integer identity(1,1) not null constraint pk_Grass primary key clustered,
	CrewSiteID int not null constraint fk_Grass_To_CrewSite references CrewSite(CrewSiteID),
	GrassCount int not null,
	Completed bit null
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
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (492282, 'Southgate Mall', '11001 25 Ave', 2584, null, 1, 1, 1, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (589622, 'O"Keefe', '125036 Wlaterdale', 8275, null, 1, 1, 1, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (369852, 'Hermitage', '114 Street & 15 Ave', 265, null, 1, 1, 1, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (120589, 'River Valley', '1047 Jasper Ave', 1124, null, 1, 1, 1, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (20583, 'Ndog-Bong', '9 Street & 57 Ave', 2002, null, 1, 1, 1, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (968452, 'Twin Brooks', '10258 23 Street', 4040, null, 1, 1, 1, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (895762, 'McEwan', '2682 McAllister Loop', 306, null, 1, 1, 2, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (258964, 'McEwan', '50 Street & 101 Ave', 487, null, 1, 1, 2, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (89657, 'Allard', '90 Del Mar Court', 8800, null, 1, 1, 2, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (120588, 'Asteraceae', '10258 127 Street', 2013, null, 1, 1, 2, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (301844, 'Star Wars', '12506 Roper Road', 256, null, 1, 1, 3, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (421256, 'Twin Towers', '36 Street & 128 Ave', 854, null, 1, 1, 3, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (685249, 'South Common', '111 Street & Gateway Boulevard', 8275, null, 1, 1, 3, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (789005, 'South Park', 'Calgary Trail & 25 Ave', 62, null, 1, 1, 3, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (741056, 'Glenridding', '117 Street & 115 Ave', 45, null, 1, 1, 4, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (942039, 'Glenridding', '120 Street & 105 Ave', 2258, null, 1, 1, 4, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (8520, 'Landcaster', '12745 Leger Trail', 115, null, 1, 1, 4, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (10236, 'Victoria Hights', '19 Street & 12 AVe', 20, null, 1, 1, 4, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (452289, 'Mercedes', '91 Street & Victoria Trail', 152, null, 1, 1, 5, 4);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (3332545, 'Buleya', '11011 29A Ave', 25, null, 1, 1, 5, 4);

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

										/*UNIT*/
insert into Unit (UnitNumber, UnitDescription, YardID) values ('WA1CGAFP8EA122491', '2-Ton Truck', 1);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('1G4GC5GR4CF868507', '2-Ton Truck', 1);
insert into Unit (UnitNumber, UnitDescription, YardID) values ('WAUJC68E32A759623', '1-Ton truck', 1);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

											/*Crew*/
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/4/2019', 5, 197, 715, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/1/2019', 4, 138, 673, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/27/2019', 4, 320, 855, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/9/2019', 4, 179, 861, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/16/2019', 6, 127, 724, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/16/2019', 6, 216, 723, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/17/2019', 6, 365, 580, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/21/2019', 4, 212, 674, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/18/2019', 4, 149, 684, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/5/2019', 5, 132, 870, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/23/2019', 4, 257, 767, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/8/2019', 5, 207, 865, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/30/2019', 5, 388, 755, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/18/2019', 6, 125, 500, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/18/2019', 4, 345, 755, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/21/2019', 5, 348, 542, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/5/2019', 5, 447, 760, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/30/2019', 6, 474, 710, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/20/2019', 6, 307, 840, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/7/2019', 4, 435, 801, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/18/2019', 5, 335, 873, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/12/2019', 5, 237, 848, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/23/2019', 6, 354, 821, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/6/2019', 4, 145, 746, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/30/2019', 5, 208, 599, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/12/2019', 6, 439, 852, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/4/2019', 4, 261, 563, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/2/2019', 4, 309, 808, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/18/2019', 4, 164, 615, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/5/2019', 5, 322, 744, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/23/2019', 5, 274, 610, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/22/2019', 4, 349, 838, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/18/2019', 4, 255, 516, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/17/2019', 5, 219, 562, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/22/2019', 6, 203, 849, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/30/2019', 4, 290, 638, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/21/2019', 6, 400, 779, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/21/2019', 6, 243, 843, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/27/2019', 5, 237, 584, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/27/2019', 4, 158, 613, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/9/2019', 5, 263, 625, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/2/2019', 5, 235, 879, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/7/2019', 4, 151, 542, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/15/2019', 4, 218, 770, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/13/2019', 4, 428, 632, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/8/2019', 4, 103, 588, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/28/2019', 5, 248, 716, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/2/2019', 5, 418, 766, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/20/2019', 4, 322, 721, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/28/2019', 6, 120, 765, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/26/2019', 4, 125, 835, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/24/2019', 6, 387, 588, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/27/2019', 5, 421, 891, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/18/2019', 5, 483, 678, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/19/2019', 5, 291, 762, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/23/2019', 4, 299, 672, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/2/2019', 4, 149, 806, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/23/2019', 4, 419, 774, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/9/2019', 4, 290, 790, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/25/2019', 5, 243, 856, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/6/2019', 5, 231, 508, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/14/2019', 4, 421, 896, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/19/2019', 5, 441, 790, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/12/2019', 4, 372, 581, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/27/2019', 4, 313, 859, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/5/2019', 4, 301, 748, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/3/2019', 4, 200, 772, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/26/2019', 5, 462, 661, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/17/2019', 4, 315, 814, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/11/2019', 4, 399, 704, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/17/2019', 6, 312, 605, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/1/2019', 5, 227, 846, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/8/2019', 6, 481, 521, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/24/2019', 6, 423, 832, null);
insert into Crew (TodayDate, UnitID, KM_Start, KM_End, AdditionalComments) values ('1/6/2019', 4, 454, 898, null);
--------------------------------------------------------------------------------------------------------------------------------------------------

									/*CrewSite*/
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (11, 'Pruning', '2:07', '14:08', null, 4);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (12, 'Grass Pulling', '3:19', '9:44', 'non mauris morbi non', 4);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (2, 'Pruning', '4:41', '12:07', null, 1);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (1, 'Mulching', '1:09', '13:52', null, 2);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (19, 'Grass Pulling', '3:30', '9:48', null, 4);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (4, 'Spray', '5:25', '9:44', null, 2);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (20, 'Pruning', '6:56', '8:42', null, 1);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (18, 'Fertilizing', '3:09', '14:33', null, 2);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (6, 'Spray', '2:44', '10:06', null, 1);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (5, 'Fertilizing', '6:34', '9:08', null, 3);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (15, 'Weeding', '2:55', '12:38', null, 3);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (10, 'Spray', '1:24', '9:19', null, 4);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (13, 'Weeding', '2:31', '10:32', null, 1);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (19, 'Grass Pulling', '2:50', '14:09', null, 2);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (16, 'Weeding', '5:20', '8:08', null, 2);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (10, 'Mulching', '2:32', '9:26', 'lacinia nisi venenatis tristique', 4);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (8, 'Mulching', '6:38', '9:15', null, 3);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (14, 'Grass Pulling', '5:49', '9:42', null, 3);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (14, 'Spray', '4:25', '12:50', null, 1);
insert into CrewSite (SiteID, TaskDescription, TimeOnSite, TimeOffSite, ActionRequired, CrewID) values (14, 'Mulching', '1:07', '13:31', null, 2);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
								/*SBM*/

insert into SBM (CrewSiteID, TaskDescription, Completed) values (2, 'Grass Pulling', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (4, 'Fertilizing', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (17, 'Grass Pulling', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (14, 'Mulching', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (15, 'Fertilizing', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (13, 'Spray', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (12, 'Spray', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (20, 'Weeding', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (16, 'Mulching', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (1, 'Grass Pulling', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (8, 'Grass Pulling', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (18, 'Weeding', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (13, 'Pruning', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (9, 'Grass Pulling', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (8, 'Spray', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (17, 'Fertilizing', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (9, 'Grass Pulling', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (20, 'Grass Pulling', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (8, 'Mulching', 1);
insert into SBM (CrewSiteID, TaskDescription, Completed) values (15, 'Pruning', 1);
----------------------------------------------------------------------------------------------------------------------------------------------------
					/*Grass*/
insert into Grass (CrewSiteID, GrassCount, Completed) values (8, 15, 1);
insert into Grass (CrewSiteID, GrassCount, Completed) values (13, 18, 1);
insert into Grass (CrewSiteID, GrassCount, Completed) values (7, 95, 1);
insert into Grass (CrewSiteID, GrassCount, Completed) values (16, 8, 1);
insert into Grass (CrewSiteID, GrassCount, Completed) values (11, 82, 1);
insert into Grass (CrewSiteID, GrassCount, Completed) values (12, 15, 1);
insert into Grass (CrewSiteID, GrassCount, Completed) values (2, 50, 1);
insert into Grass (CrewSiteID, GrassCount, Completed) values (6, 37, 1);
insert into Grass (CrewSiteID, GrassCount, Completed) values (4, 58, 1);
insert into Grass (CrewSiteID, GrassCount, Completed) values (20, 38, 1);
------------------------------------------------------------------------------------------------------------------------------

				/* Mulching*/
insert into Mulching (CrewSiteID, Completed) values (14, 1);
insert into Mulching (CrewSiteID, Completed) values (11, 1);
insert into Mulching (CrewSiteID, Completed) values (15, 1);
insert into Mulching (CrewSiteID, Completed) values (5, 1);
insert into Mulching (CrewSiteID, Completed) values (6, 1);
insert into Mulching (CrewSiteID, Completed) values (20, 1);
insert into Mulching (CrewSiteID, Completed) values (11, 1);
insert into Mulching (CrewSiteID, Completed) values (18, 1);
insert into Mulching (CrewSiteID, Completed) values (6, 1);
insert into Mulching (CrewSiteID, Completed) values (17, 1);



select*from YARD	
select*from Community
select*from Season
select*from site
select*from Unit
Select*from Crew
select*from CrewSite
select*from SBM order by CrewSIteID
select*from Grass order by CrewSIteID
select*from Mulching order by CrewSIteID