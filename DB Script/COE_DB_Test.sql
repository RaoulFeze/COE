--CREATE DATABASE COE_DB

--Drop Table SBM

--Drop Table Planting

--Drop Table Uprooting

--Drop Table Watering

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
	Grass int constraint df_GrassOnSite default 0,
	Watering bit constraint df_WateringSite default 0,
	Planting bit constraint df_PlantingSite default 0,
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

create table Planting
(
	PlantingStatusID integer identity(1,1) not null constraint pk_Planting primary key clustered,
	CrewSiteID int not null constraint fk_Planting_To_CrewSite references CrewSite(CrewSiteID)
)

create table Uprooting
(
	UprootingStatusID integer identity(1,1) not null constraint pk_Uprooting primary key clustered,
	CrewSiteID int not null constraint fk_Uprooting_to_CrewSite references CrewSite(CrewSiteID)
)

create table Watering
(
	WateringStatusID integer identity(1,1) not null constraint pk_Watering primary key clustered,
	CrewSiteID int not null constraint fk_Watering_To_CrewSite references CrewSite(CrewSiteID)
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

Insert into Season
Values(2020)


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
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (309333, 'Twin Brooks', '9 Dennis Crossing', 368, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (242103, 'Landcaster', '072 Roxbury Crossing', 184, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (180929, 'Glenridding', '53225 Debs Lane', 187, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (259904, 'Allard', '8 Loeprich Place', 674, 'nulla integer', 59, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (95686, 'Landcaster', '45 Dapin Parkway', 460, 'vestibulum rutrum rutrum', null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (26015, 'Hermitage', '92 Jenifer Junction', 619, 'neque aenean auctor', null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (29946, 'Victoria Hights', '98 Pennsylvania Pass', 228, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (48668, 'South Common', '4 4th Center', 655, null, 23, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (97454, 'Mercedes', '7 7th Park', 615, null, 88, 0, 1, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (283549, 'South Park', '47502 Fuller Court', 176, null, 91, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (156574, 'Glenridding', '37614 Boyd Pass', 437, null, null, 1, 1, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (242743, 'South Park', '33047 Express Pass', 307, 'morbi quis', 56, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (235167, 'South Common', '547 Thierer Court', 614, null, 82, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (45699, 'South Common', '4 Hagan Hill', 432, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (170654, 'Landcaster', '08032 Bunting Crossing', 202, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (118114, 'Glenridding', '54 Rieder Avenue', 34, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (235353, 'Mercedes', '78 Darwin Lane', 34, null, 46, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (71145, 'South Common', '252 Almo Pass', 293, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (263244, 'Mercedes', '3 Hazelcrest Street', 180, null, 45, 0, 1, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (78877, 'Twin Brooks', '7646 Dayton Center', 280, null, 45, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (122716, 'Ndog-Bong', '62 Coleman Terrace', 694, 'suscipit nulla elit ac', 63, 0, 0, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (272757, 'McEwan', '1 Hallows Place', 575, 'gravida sem', null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (89984, 'Glenridding', '62 Little Fleur Street', 228, null, 30, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (79191, 'McEwan', '3 Kropf Road', 657, 'hac habitasse', null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (71617, 'Allard', '819 Rutledge Avenue', 137, null, 55, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (174499, 'Glenridding', '7 Lien Center', 685, null, null, 0, 0, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (44028, 'Buleya', '3 Spohn Way', 30, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (41902, 'Twin Brooks', '70 Reinke Avenue', 3, null, 43, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (226852, 'Southgate Mall', '1 Aberg Crossing', 61, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (252666, 'Glenridding', '370 Rockefeller Road', 657, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (85171, 'River Valley', '1321 Trailsway Plaza', 606, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (254616, 'Twin Towers', '45676 Bunting Court', 157, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (306394, 'Star Wars', '71 Carberry Hill', 603, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (88367, 'Star Wars', '23 Kipling Court', 632, 'platea dictumst', null, 1, 1, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (64541, 'Twin Brooks', '750 Hudson Terrace', 289, null, null, 1, 1, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (144878, 'Allard', '69740 Cottonwood Drive', 449, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (265747, 'Glenridding', '4630 Pleasure Junction', 335, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (105533, 'Landcaster', '272 Laurel Place', 74, null, 23, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (234279, 'Hermitage', '15074 Blaine Park', 202, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (130239, 'O''Keefe', '567 Bartelt Trail', 276, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (82822, 'South Park', '1661 Westend Alley', 464, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (276954, 'Southgate Mall', '2 Eastwood Road', 252, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (215633, 'Victoria Hights', '1105 Hayes Place', 640, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (17931, 'Southgate Mall', '87 Cordelia Hill', 255, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (231741, 'Buleya', '4 Surrey Place', 78, null, 94, 0, 1, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (61238, 'Allard', '61117 Summerview Court', 286, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (170158, 'Twin Towers', '82 Mallory Trail', 44, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (192725, 'Glenridding', '96248 Oakridge Plaza', 54, null, 21, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (147800, 'O''Keefe', '2 Bluestem Center', 694, null, 11, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (198475, 'Twin Brooks', '42631 Northview Drive', 130, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (209929, 'Allard', '25469 Eastlawn Parkway', 317, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (216089, 'Ndog-Bong', '56536 Sachtjen Hill', 107, 'proin at', 10, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (35517, 'Twin Brooks', '2386 Menomonie Point', 84, 'nisl nunc nisl', 12, 0, 1, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (206831, 'Victoria Hights', '66 Northridge Junction', 344, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (215349, 'McEwan', '5 Lien Way', 320, 'pellentesque quisque porta volutpat', null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (124632, 'McEwan', '0113 5th Alley', 93, null, 57, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (35064, 'Buleya', '03229 Loomis Point', 252, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (108568, 'Glenridding', '0165 Eliot Point', 143, null, 25, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (165032, 'O''Keefe', '6 Maryland Park', 61, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (161571, 'Landcaster', '1442 Blue Bill Park Crossing', 154, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (61244, 'Ndog-Bong', '701 Fuller Pass', 508, null, null, 0, 0, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (128419, 'O''Keefe', '3 School Plaza', 594, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (95054, 'Ndog-Bong', '237 Sunbrook Plaza', 118, null, 21, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (168595, 'Glenridding', '464 Meadow Vale Avenue', 599, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (262099, 'Landcaster', '38500 Lakewood Gardens Drive', 427, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (31387, 'Twin Towers', '405 American Center', 514, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (109574, 'Twin Towers', '6 Ohio Road', 683, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (279788, 'River Valley', '41492 Kenwood Road', 511, null, null, 1, 1, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (113955, 'Twin Towers', '24 Monica Terrace', 684, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (281117, 'Allard', '034 Comanche Crossing', 679, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (103822, 'Twin Brooks', '92351 Moose Drive', 543, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (219318, 'Ndog-Bong', '6546 Del Mar Hill', 388, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (171705, 'Southgate Mall', '94570 Tennyson Terrace', 608, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (52050, 'Ndog-Bong', '74 Schlimgen Junction', 489, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (315672, 'Buleya', '9 Russell Center', 625, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (114853, 'Buleya', '72 Stang Street', 132, 'orci nullam molestie', null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (161121, 'Glenridding', '04 Crest Line Point', 303, null, 11, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (273399, 'McEwan', '06481 Crowley Court', 201, 'purus aliquet', null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (305038, 'South Common', '1930 Grasskamp Drive', 584, null, 94, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (22511, 'Southgate Mall', '06 Dawn Park', 213, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (84184, 'O''Keefe', '985 Messerschmidt Alley', 503, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (187390, 'Ndog-Bong', '6524 Hauk Avenue', 425, null, 49, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (41760, 'O''Keefe', '960 La Follette Trail', 207, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (78285, 'South Park', '01451 Shelley Center', 215, null, 98, 1, 1, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (173182, 'Twin Towers', '15973 Schmedeman Point', 502, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (51411, 'Allard', '835 Calypso Way', 343, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (295806, 'Ndog-Bong', '445 Porter Way', 239, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (186950, 'South Park', '3899 Saint Paul Circle', 369, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (210522, 'Star Wars', '96 Jana Junction', 220, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (245140, 'Landcaster', '99 Claremont Way', 39, 'consequat in', null, 1, 1, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (286175, 'Buleya', '23 Fallview Pass', 194, null, null, 1, 0, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (210091, 'Twin Brooks', '27227 Dunning Way', 501, null, 30, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (83477, 'South Park', '577 Welch Road', 560, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (246639, 'South Park', '0670 Schlimgen Drive', 258, null, 15, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (143748, 'River Valley', '3 Transport Crossing', 349, null, null, 0, 1, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (264643, 'Glenridding', '4 Jenifer Crossing', 489, null, null, 0, 0, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (121051, 'Glenridding', '0805 Mendota Drive', 25, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (54727, 'Twin Brooks', '23144 Daystar Parkway', 606, 'condimentum neque', null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (107953, 'Twin Brooks', '1 Annamark Crossing', 379, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (134472, 'Star Wars', '5557 Carey Circle', 264, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (245424, 'Southgate Mall', '684 Knutson Parkway', 285, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (113226, 'Mercedes', '188 4th Drive', 23, 'orci luctus et ultrices', 90, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (239385, 'O''Keefe', '01357 Independence Road', 211, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (155793, 'Star Wars', '6 Clove Parkway', 436, null, null, 0, 0, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (243689, 'Landcaster', '15946 Helena Place', 533, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (127508, 'Twin Brooks', '5 Bunker Hill Court', 205, null, 13, 0, 1, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (189007, 'Star Wars', '936 Troy Terrace', 438, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (192249, 'O''Keefe', '541 Di Loreto Center', 32, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (260279, 'Glenridding', '781 Veith Place', 280, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (128841, 'Twin Brooks', '9090 Oak Center', 220, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (244244, 'Star Wars', '0944 Lukken Road', 161, null, 23, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (89404, 'Glenridding', '5 Packers Road', 527, null, null, 0, 0, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (312360, 'Victoria Hights', '8366 Valley Edge Avenue', 347, null, 78, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (228240, 'Ndog-Bong', '335 Heffernan Plaza', 171, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (91178, 'Southgate Mall', '3 Mayer Street', 260, null, 91, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (234379, 'Buleya', '25 Northfield Pass', 269, null, 45, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (36743, 'South Park', '2202 Hoepker Parkway', 33, 'auctor sed tristique in', null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (275912, 'Buleya', '60060 Stone Corner Court', 358, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (219303, 'Southgate Mall', '6479 Valley Edge Pass', 8, 'convallis morbi odio odio', null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (20059, 'Twin Towers', '0285 Harbort Parkway', 689, null, 58, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (104058, 'Star Wars', '03 Canary Street', 636, null, 19, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (47316, 'Allard', '80523 Oriole Crossing', 466, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (242621, 'Buleya', '4 Caliangt Lane', 570, 'nunc nisl duis bibendum', 51, 0, 0, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (157915, 'Hermitage', '9786 Elgar Avenue', 101, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (66934, 'Landcaster', '421 Graedel Pass', 494, null, null, 0, 0, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (85902, 'Buleya', '743 Crownhardt Court', 535, null, 41, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (210355, 'Glenridding', '2 Pierstorff Center', 379, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (306817, 'South Park', '4 Ryan Hill', 431, null, 27, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (57436, 'Twin Towers', '71 Southridge Road', 685, null, 90, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (212216, 'Southgate Mall', '41 John Wall Lane', 281, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (265767, 'Buleya', '14 Colorado Road', 602, null, 69, 1, 0, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (246904, 'Southgate Mall', '9 Buhler Road', 494, null, 19, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (176022, 'McEwan', '192 Quincy Place', 306, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (74190, 'South Common', '2 Westend Drive', 247, null, 14, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (45651, 'O''Keefe', '3680 Elmside Street', 107, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (44920, 'River Valley', '44490 Corben Center', 352, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (131133, 'South Park', '4 Shoshone Point', 685, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (232152, 'Twin Brooks', '88 Maywood Hill', 665, null, null, 1, 0, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (319736, 'Glenridding', '3 Sugar Road', 85, 'ut rhoncus', 49, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (251562, 'River Valley', '7957 Kensington Terrace', 52, null, 47, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (204354, 'Twin Towers', '8 Sugar Pass', 36, null, 44, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (99970, 'Victoria Hights', '5250 Calypso Place', 462, null, null, 1, 1, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (143340, 'Mercedes', '0374 Arrowood Center', 635, null, 55, 0, 0, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (122783, 'Southgate Mall', '20799 Hansons Junction', 695, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (256241, 'South Park', '03011 Badeau Drive', 623, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (305515, 'McEwan', '2 Spaight Center', 103, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (44814, 'Victoria Hights', '17 Westerfield Road', 319, 'nunc donec quis orci', 75, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (73316, 'Allard', '9983 Hudson Trail', 6, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (31155, 'Glenridding', '225 Melody Terrace', 32, null, null, 0, 1, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (222356, 'Glenridding', '081 Northfield Street', 262, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (193743, 'Twin Towers', '32 Hermina Lane', 569, null, 29, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (223538, 'Glenridding', '8 Mosinee Crossing', 143, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (92560, 'South Common', '0 Hollow Ridge Parkway', 630, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (169713, 'Twin Towers', '32 Canary Drive', 138, 'pede justo eu', 24, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (166014, 'Victoria Hights', '231 Steensland Parkway', 634, null, null, 0, 0, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (174823, 'Star Wars', '7311 Mallory Center', 415, 'sagittis sapien', 97, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (119503, 'McEwan', '017 5th Pass', 597, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (220605, 'Victoria Hights', '57 Sugar Lane', 244, null, 25, 0, 0, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (45895, 'Landcaster', '8838 Moland Center', 350, null, 15, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (126400, 'Landcaster', '69 Dorton Way', 31, null, null, 0, 0, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (111663, 'Glenridding', '26 Bluejay Place', 158, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (170161, 'McEwan', '01 Hintze Park', 559, null, null, 1, 1, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (39274, 'O''Keefe', '01716 Mockingbird Drive', 571, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (241232, 'Allard', '22479 Declaration Way', 474, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (311065, 'Victoria Hights', '3 Jackson Crossing', 541, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (255015, 'Allard', '4 Tomscot Circle', 104, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (110266, 'Ndog-Bong', '9 Novick Crossing', 645, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (89749, 'Southgate Mall', '883 Elgar Center', 221, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (19349, 'Twin Brooks', '9286 Dorton Way', 339, null, 60, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (155458, 'Allard', '4488 Tony Drive', 586, null, null, 0, 1, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (108509, 'Hermitage', '7 Oneill Pass', 403, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (22779, 'Landcaster', '1354 Moland Parkway', 111, null, 50, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (125118, 'South Common', '61 Del Sol Pass', 362, null, 37, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (282584, 'South Common', '32 2nd Alley', 585, null, 55, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (143571, 'River Valley', '314 Farragut Court', 639, null, 30, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (118402, 'Allard', '137 Eastwood Alley', 5, 'et eros vestibulum', null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (272351, 'Hermitage', '8564 Melody Pass', 640, null, null, 1, 0, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (228388, 'Southgate Mall', '34 Lawn Point', 535, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (115064, 'Allard', '67056 High Crossing Road', 620, null, 84, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (202478, 'Victoria Hights', '178 Northfield Junction', 542, null, null, 1, 0, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (160126, 'Star Wars', '37746 Hooker Circle', 661, 'libero non', null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (313774, 'Mercedes', '4328 Haas Court', 185, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (258400, 'Allard', '82 Nobel Circle', 674, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (110721, 'Twin Towers', '1148 Debra Way', 234, null, 57, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (155940, 'Glenridding', '515 Spaight Place', 508, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (72411, 'Victoria Hights', '75 Morrow Hill', 399, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (145966, 'Buleya', '5 Forest Dale Place', 107, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (258635, 'Twin Brooks', '03084 Riverside Trail', 128, null, 30, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (288699, 'Buleya', '5 Kings Lane', 68, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (88474, 'Mercedes', '86 Upham Place', 276, null, null, 1, 0, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (37748, 'Hermitage', '26 Dixon Place', 438, null, 10, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (186070, 'Star Wars', '67 Homewood Alley', 157, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (181110, 'River Valley', '8 Kensington Hill', 17, null, 20, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (229814, 'Buleya', '5090 Talmadge Way', 282, null, 31, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (145441, 'Allard', '41 Kim Alley', 531, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (269710, 'Mercedes', '05928 Oak Valley Road', 367, 'et tempus semper est', null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (167769, 'O''Keefe', '34827 Beilfuss Center', 550, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (309218, 'McEwan', '3 Carpenter Pass', 619, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (247338, 'Victoria Hights', '4 Maple Parkway', 608, null, null, 0, 0, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (42666, 'Buleya', '854 Valley Edge Terrace', 182, null, 36, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (85020, 'South Common', '5 Eastwood Circle', 633, null, 69, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (96926, 'Star Wars', '49076 Hanover Junction', 241, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (33810, 'South Park', '21866 Pearson Drive', 142, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (239137, 'Buleya', '6538 Hoepker Parkway', 636, null, 50, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (236813, 'McEwan', '8893 Mallory Drive', 377, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (156544, 'South Common', '43311 2nd Hill', 61, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (76726, 'McEwan', '1167 Buhler Street', 370, null, 79, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (35885, 'Landcaster', '4060 Vermont Avenue', 244, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (269218, 'Landcaster', '2504 Hintze Alley', 552, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (129915, 'Allard', '48665 Paget Court', 98, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (196567, 'Allard', '8143 Summit Crossing', 654, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (140183, 'Mercedes', '087 Truax Terrace', 613, 'dui luctus', null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (241608, 'O''Keefe', '2 Emmet Point', 436, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (294432, 'Twin Towers', '4184 Park Meadow Court', 584, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (173704, 'Buleya', '684 Luster Hill', 428, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (116420, 'Allard', '571 Prentice Plaza', 164, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (220984, 'Twin Brooks', '363 Hanover Plaza', 554, null, null, 1, 0, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (166009, 'Star Wars', '5573 Donald Street', 537, null, 14, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (275653, 'Glenridding', '812 Fallview Circle', 329, null, 37, 1, 0, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (165080, 'Hermitage', '27403 Holy Cross Plaza', 217, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (269520, 'Victoria Hights', '85 Paget Avenue', 176, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (318942, 'McEwan', '634 Shoshone Circle', 579, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (251406, 'Mercedes', '20272 Brentwood Trail', 448, 'dui proin', 10, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (138621, 'Mercedes', '0 Aberg Plaza', 236, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (172408, 'Allard', '24 Utah Avenue', 507, null, null, 0, 1, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (316494, 'Twin Towers', '314 Bartillon Trail', 441, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (68999, 'Victoria Hights', '1 Russell Circle', 185, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (90438, 'Buleya', '23 Dennis Point', 49, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (227538, 'McEwan', '67859 Gulseth Place', 414, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (81398, 'South Common', '705 Talisman Center', 72, null, 56, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (50746, 'Twin Towers', '3 Barby Terrace', 563, null, 84, 0, 0, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (134012, 'South Common', '71 Emmet Avenue', 363, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (50773, 'South Park', '28 Dapin Road', 369, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (104338, 'River Valley', '642 Nobel Trail', 143, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (173548, 'Twin Brooks', '8327 Sommers Circle', 263, null, null, 1, 1, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (19839, 'Allard', '4 Prairieview Court', 304, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (192839, 'Buleya', '00653 Nova Place', 38, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (49674, 'Landcaster', '8200 Clove Street', 661, null, 47, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (200500, 'River Valley', '368 Hooker Center', 622, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (105718, 'O''Keefe', '7075 Manley Circle', 473, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (54311, 'Twin Brooks', '08634 Armistice Plaza', 25, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (296025, 'Buleya', '9 Manufacturers Way', 410, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (81254, 'Glenridding', '696 Knutson Parkway', 667, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (211504, 'Mercedes', '65 Blue Bill Park Junction', 135, 'justo nec', 69, 0, 0, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (83378, 'Glenridding', '0998 Warrior Junction', 187, null, null, 0, 1, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (48057, 'Ndog-Bong', '8526 Dexter Terrace', 525, null, 21, 1, 0, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (24864, 'Ndog-Bong', '1799 Raven Avenue', 459, null, 57, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (286781, 'Southgate Mall', '7 Logan Street', 324, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (102754, 'River Valley', '7495 8th Crossing', 115, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (231672, 'Buleya', '9637 Browning Alley', 71, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (22504, 'Glenridding', '53544 Dryden Court', 198, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (41727, 'Victoria Hights', '03351 Sycamore Hill', 252, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (187200, 'Allard', '5 Schiller Alley', 355, null, 87, 0, 0, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (44469, 'Star Wars', '83097 1st Hill', 193, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (72477, 'Hermitage', '1 Di Loreto Avenue', 674, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (26120, 'Mercedes', '49 Morrow Point', 516, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (106726, 'Southgate Mall', '95563 Kenwood Road', 246, null, 75, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (95175, 'Twin Brooks', '24 Eggendart Alley', 2, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (199195, 'O''Keefe', '5874 Lunder Plaza', 663, 'ipsum primis', null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (122006, 'O''Keefe', '27 Lillian Avenue', 346, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (39321, 'Victoria Hights', '7258 Garrison Circle', 148, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (183960, 'Twin Brooks', '89 Donald Alley', 31, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (140649, 'McEwan', '43 Summit Plaza', 55, null, null, 1, 0, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (192895, 'O''Keefe', '8411 Warbler Pass', 699, null, 95, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (278375, 'McEwan', '49393 Merchant Crossing', 304, 'quam suspendisse', null, 0, 1, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (247099, 'South Common', '25644 Del Sol Terrace', 320, null, 42, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (295469, 'Twin Brooks', '206 Blue Bill Park Alley', 278, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (185431, 'Allard', '3 Delaware Crossing', 89, null, 41, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (97258, 'Glenridding', '54 Mallard Hill', 556, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (48340, 'Victoria Hights', '979 Melvin Plaza', 571, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (314931, 'O''Keefe', '2551 Sunfield Pass', 255, null, null, 1, 0, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (141700, 'Mercedes', '84573 Birchwood Place', 270, 'mi nulla', null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (228612, 'Twin Brooks', '77635 Buena Vista Junction', 326, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (217538, 'South Park', '9292 Norway Maple Crossing', 143, null, 57, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (301728, 'South Common', '51894 Springview Trail', 561, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (72328, 'River Valley', '2602 Dovetail Pass', 311, null, 74, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (310647, 'South Common', '54 Bartelt Pass', 502, null, 78, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (150477, 'South Park', '87 Main Trail', 327, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (128906, 'Twin Towers', '580 Blue Bill Park Court', 372, null, 20, 0, 0, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (46002, 'River Valley', '047 Bayside Avenue', 505, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (19989, 'South Park', '458 Donald Hill', 635, null, 76, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (310777, 'O''Keefe', '6816 Tennessee Pass', 247, null, 53, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (303561, 'Star Wars', '08254 Valley Edge Avenue', 687, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (124865, 'River Valley', '4150 Nancy Avenue', 146, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (186638, 'River Valley', '739 Merry Trail', 337, null, 14, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (38012, 'Southgate Mall', '38 Vermont Avenue', 293, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (67575, 'Twin Towers', '2087 Lighthouse Bay Crossing', 507, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (101448, 'South Common', '33 Mccormick Center', 441, null, 46, 1, 1, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (16956, 'River Valley', '66147 Forest Alley', 93, null, 16, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (252503, 'Star Wars', '2 Lyons Crossing', 539, null, null, 1, 1, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (181351, 'Ndog-Bong', '8 Mccormick Plaza', 318, null, 65, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (198020, 'Twin Towers', '88 Park Meadow Way', 268, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (167464, 'River Valley', '67833 Towne Hill', 75, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (283552, 'O''Keefe', '42 Acker Circle', 278, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (160763, 'River Valley', '7627 Manley Crossing', 420, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (291709, 'Star Wars', '99 Corry Plaza', 192, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (127440, 'Southgate Mall', '1 Union Road', 669, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (243544, 'South Park', '216 Briar Crest Place', 464, null, 99, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (15413, 'Star Wars', '1783 Roxbury Trail', 83, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (96965, 'Star Wars', '74 Holmberg Court', 478, null, null, 1, 0, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (206187, 'South Park', '90094 Esker Pass', 648, null, 49, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (308136, 'Hermitage', '4 Luster Place', 356, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (22224, 'Southgate Mall', '9 Upham Hill', 642, null, 81, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (218608, 'Landcaster', '3371 Derek Drive', 226, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (122047, 'Hermitage', '213 Claremont Court', 530, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (76345, 'Victoria Hights', '49790 Crest Line Trail', 611, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (22292, 'Glenridding', '9254 2nd Junction', 227, null, null, 1, 0, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (229827, 'Landcaster', '8 Southridge Trail', 304, null, null, 1, 1, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (89582, 'Star Wars', '924 Utah Plaza', 368, null, 97, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (231866, 'South Common', '52192 Logan Street', 380, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (83279, 'Glenridding', '0 Kensington Drive', 462, null, 18, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (58533, 'Mercedes', '621 Hoard Terrace', 392, null, 96, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (258950, 'Glenridding', '13 Summerview Way', 523, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (13464, 'Hermitage', '8 Grayhawk Lane', 266, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (284476, 'Buleya', '8075 1st Street', 533, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (113392, 'Twin Brooks', '420 Warrior Junction', 562, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (44697, 'Star Wars', '42 Gina Trail', 571, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (187810, 'Southgate Mall', '03051 Kings Court', 59, null, null, 0, 1, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (63272, 'Southgate Mall', '6 Londonderry Pass', 279, null, 29, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (265254, 'Southgate Mall', '4243 Orin Crossing', 114, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (48276, 'Allard', '24 Oneill Junction', 74, null, 69, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (13913, 'Hermitage', '3751 Independence Pass', 680, null, null, 1, 0, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (197223, 'South Park', '753 Pine View Plaza', 43, null, null, 1, 0, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (261289, 'O''Keefe', '48 Carberry Way', 433, null, 43, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (15244, 'South Park', '6 Hollow Ridge Junction', 154, 'ipsum praesent blandit lacinia', 63, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (188571, 'Southgate Mall', '739 Melody Crossing', 231, null, 77, 0, 0, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (227970, 'Twin Brooks', '51 Hoepker Road', 19, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (206644, 'Buleya', '1527 Westport Court', 443, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (99654, 'River Valley', '373 Annamark Plaza', 229, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (51303, 'Southgate Mall', '7979 Kensington Lane', 597, null, 73, 1, 1, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (26831, 'McEwan', '9 Esker Park', 52, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (132142, 'Buleya', '862 Helena Drive', 19, null, 30, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (106453, 'Glenridding', '06038 Graceland Way', 274, null, null, 0, 1, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (261333, 'Twin Brooks', '861 Summer Ridge Park', 300, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (185028, 'Mercedes', '91 Shasta Court', 477, null, null, 0, 0, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (189820, 'South Park', '89 Manley Lane', 317, null, null, 1, 0, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (106263, 'South Park', '708 Transport Plaza', 23, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (321068, 'McEwan', '133 Pierstorff Junction', 319, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (249315, 'Buleya', '9 Mockingbird Junction', 397, null, 45, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (121421, 'Victoria Hights', '7 Redwing Place', 216, null, 50, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (116224, 'Mercedes', '9037 Welch Street', 100, 'feugiat non pretium quis', 72, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (256725, 'Hermitage', '97 Lighthouse Bay Pass', 654, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (160169, 'South Common', '86909 Northport Park', 32, null, 67, 0, 1, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (239550, 'Allard', '291 American Court', 2, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (19526, 'Twin Towers', '90 Oxford Avenue', 596, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (312854, 'Hermitage', '93060 Helena Hill', 512, 'duis consequat dui nec', null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (282325, 'O''Keefe', '962 Corscot Parkway', 244, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (296017, 'Mercedes', '37523 International Pass', 350, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (12563, 'Hermitage', '808 Bonner Lane', 532, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (181854, 'Southgate Mall', '5319 Hudson Place', 446, null, 15, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (177402, 'Glenridding', '1 Hermina Point', 46, null, 31, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (310834, 'South Park', '7747 Delladonna Park', 416, null, 21, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (132091, 'Mercedes', '68355 Amoth Court', 474, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (83719, 'South Park', '9317 Service Point', 18, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (173883, 'O''Keefe', '4640 Fieldstone Way', 686, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (211586, 'O''Keefe', '5 Crest Line Junction', 267, 'magnis dis', null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (257816, 'Buleya', '2286 Shopko Road', 257, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (275803, 'Victoria Hights', '72 Rutledge Parkway', 64, null, 15, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (261256, 'O''Keefe', '172 Sycamore Park', 242, 'nulla facilisi', 25, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (78969, 'Allard', '00 Bashford Junction', 693, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (279946, 'Ndog-Bong', '0128 International Park', 439, null, null, 0, 0, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (12769, 'River Valley', '45 Tennyson Way', 273, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (107877, 'McEwan', '913 Oneill Trail', 85, 'in porttitor pede', null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (301581, 'Twin Brooks', '6340 Pankratz Point', 86, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (289303, 'River Valley', '04 Barnett Court', 644, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (256338, 'South Park', '0334 Forest Dale Alley', 345, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (132756, 'Star Wars', '17 Southridge Parkway', 114, null, null, 0, 0, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (229756, 'South Common', '4 Forest Hill', 564, 'parturient montes nascetur', 40, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (155027, 'Hermitage', '92106 Goodland Street', 540, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (235053, 'Landcaster', '27 Dovetail Road', 232, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (270334, 'Allard', '40 Atwood Center', 346, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (31572, 'Mercedes', '9 Graceland Park', 538, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (55369, 'South Park', '91 Eggendart Terrace', 559, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (137241, 'Hermitage', '62664 Lukken Drive', 532, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (311878, 'South Common', '942 Leroy Lane', 664, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (202792, 'Hermitage', '595 Corben Crossing', 160, null, null, 1, 0, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (88903, 'Ndog-Bong', '59 Lawn Crossing', 618, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (269813, 'Landcaster', '4 Bunting Parkway', 459, null, null, 1, 0, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (307610, 'Star Wars', '34 Schiller Street', 360, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (206197, 'Allard', '9 Thompson Point', 84, null, null, 1, 0, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (112642, 'Twin Towers', '64 Nobel Pass', 245, 'hendrerit at vulputate vitae', null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (266050, 'O''Keefe', '3078 Weeping Birch Junction', 465, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (105729, 'Mercedes', '74 Arapahoe Circle', 356, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (258727, 'River Valley', '24 Michigan Park', 625, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (171859, 'Hermitage', '1 Porter Park', 644, 'pede malesuada in', null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (105246, 'Victoria Hights', '10 Sunbrook Way', 320, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (151131, 'Landcaster', '326 Canary Trail', 472, null, 17, 0, 0, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (20314, 'Star Wars', '947 Southridge Parkway', 244, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (120544, 'Glenridding', '0 Blaine Road', 57, 'aliquam augue quam', 27, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (187920, 'Ndog-Bong', '39345 Schiller Court', 567, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (91042, 'River Valley', '1 Kropf Lane', 193, null, 56, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (29325, 'McEwan', '719 Bultman Lane', 263, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (258345, 'Ndog-Bong', '9792 Bluestem Terrace', 522, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (40462, 'Mercedes', '72 Haas Circle', 281, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (193636, 'O''Keefe', '936 Spenser Pass', 526, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (126958, 'Star Wars', '98 Kings Plaza', 10, null, null, 0, 1, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (210502, 'South Common', '808 Nevada Junction', 654, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (142969, 'Twin Towers', '3 Londonderry Parkway', 606, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (211186, 'Southgate Mall', '47781 Vera Junction', 545, null, null, 1, 1, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (118563, 'O''Keefe', '2 Carey Street', 41, null, 97, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (33408, 'Hermitage', '3831 Corben Circle', 640, 'lacus purus aliquet', null, 0, 0, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (272275, 'Allard', '127 Forster Place', 424, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (152572, 'Ndog-Bong', '07 Shopko Parkway', 521, null, 70, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (209846, 'Landcaster', '20 Sutherland Road', 213, null, null, 0, 1, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (259672, 'McEwan', '2816 Randy Street', 548, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (143943, 'Star Wars', '5805 Blackbird Road', 113, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (267799, 'South Park', '3279 Sachtjen Drive', 192, 'nulla ut erat', null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (57542, 'Twin Towers', '66925 Russell Park', 599, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (208632, 'Allard', '8573 Thackeray Circle', 539, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (257712, 'River Valley', '148 Buhler Alley', 42, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (104129, 'Victoria Hights', '92672 1st Way', 168, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (42298, 'South Park', '151 Crest Line Parkway', 69, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (269999, 'River Valley', '26 Bowman Pass', 583, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (264738, 'McEwan', '36 Manitowish Avenue', 463, null, 89, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (190280, 'River Valley', '09 Sloan Park', 564, null, 31, 0, 0, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (315634, 'Buleya', '63342 Sommers Trail', 628, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (109031, 'O''Keefe', '019 Fremont Road', 397, 'lacus at velit', null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (273961, 'McEwan', '2272 Forster Pass', 377, 'porttitor id consequat', null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (119210, 'Star Wars', '2527 Hayes Road', 625, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (161679, 'Mercedes', '0 Blackbird Junction', 46, null, null, 0, 0, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (296276, 'Star Wars', '91 Pawling Place', 665, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (146574, 'Twin Brooks', '23831 Forster Parkway', 395, null, 27, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (39717, 'Star Wars', '9990 Lighthouse Bay Junction', 674, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (319804, 'Twin Brooks', '938 Pankratz Hill', 524, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (127647, 'South Park', '9922 Lakeland Road', 213, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (183024, 'Glenridding', '74117 Randy Drive', 53, null, null, 1, 0, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (121448, 'Twin Brooks', '0348 Dottie Pass', 462, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (102308, 'Mercedes', '628 Ronald Regan Center', 79, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (220587, 'Buleya', '83191 Sage Place', 397, null, null, 0, 1, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (200880, 'Twin Brooks', '459 Vahlen Way', 405, null, null, 1, 1, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (182560, 'Victoria Hights', '788 Garrison Street', 293, null, 86, 1, 0, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (162253, 'Star Wars', '38 Sunnyside Avenue', 541, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (301140, 'Mercedes', '3805 Graceland Avenue', 155, null, 66, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (77996, 'Landcaster', '89940 Ridgeview Hill', 250, null, null, 0, 1, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (302863, 'Buleya', '77 Vermont Lane', 432, null, 51, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (28635, 'Buleya', '4554 Leroy Hill', 279, null, 56, 0, 1, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (69394, 'Star Wars', '59826 Helena Trail', 470, null, 60, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (228803, 'Buleya', '299 Pleasure Trail', 541, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (319331, 'River Valley', '4848 Dahle Street', 520, null, 49, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (267264, 'River Valley', '00043 Veith Street', 176, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (213645, 'South Common', '36422 Morning Lane', 126, null, null, 1, 0, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (296677, 'Buleya', '09 Mosinee Crossing', 19, null, 60, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (19890, 'Glenridding', '56 Oak Valley Court', 143, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (272243, 'McEwan', '3 Emmet Way', 350, null, null, 1, 1, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (280882, 'Mercedes', '87 Orin Lane', 651, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (44047, 'Mercedes', '388 Starling Place', 199, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (184302, 'Hermitage', '4 Sunnyside Parkway', 605, null, 72, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (19200, 'South Park', '40812 Upham Center', 554, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (91870, 'Hermitage', '4387 Spohn Drive', 235, 'mauris non ligula', 93, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (107548, 'Landcaster', '95 Buhler Park', 173, null, 59, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (65643, 'McEwan', '4544 Maple Terrace', 258, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (222746, 'Glenridding', '3363 Merry Alley', 627, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (214484, 'Ndog-Bong', '2 Del Sol Park', 145, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (217909, 'McEwan', '20037 Mandrake Park', 130, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (84715, 'McEwan', '804 Clemons Trail', 323, null, null, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (189141, 'Landcaster', '7761 Montana Plaza', 275, null, 51, null, null, 2, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (126466, 'Southgate Mall', '275 Butternut Place', 422, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (285038, 'Victoria Hights', '0 Doe Crossing Hill', 355, null, 93, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (293662, 'Star Wars', '3673 Welch Plaza', 214, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (188043, 'Twin Brooks', '2157 Maple Wood Road', 444, null, 44, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (249122, 'Southgate Mall', '51 Leroy Plaza', 417, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (73606, 'Twin Brooks', '25 Logan Avenue', 413, null, null, 0, 0, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (275657, 'Allard', '750 Jackson Plaza', 425, null, null, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (97104, 'McEwan', '382 Forster Junction', 491, null, 95, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (189105, 'Ndog-Bong', '3 Wayridge Pass', 637, null, 36, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (150762, 'McEwan', '13 Menomonie Parkway', 312, null, null, 1, 0, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (68284, 'Ndog-Bong', '11666 Tony Drive', 466, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (226951, 'Glenridding', '8 Mayer Lane', 637, null, 71, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (82632, 'Twin Towers', '9700 Kropf Parkway', 259, null, 25, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (44161, 'Hermitage', '620 Memorial Court', 335, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (81153, 'Glenridding', '32402 Briar Crest Trail', 293, null, 52, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (317587, 'McEwan', '03 Hoepker Place', 309, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (175382, 'O''Keefe', '260 Lien Park', 141, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (145896, 'Ndog-Bong', '25972 Moland Park', 408, null, null, 0, 0, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (19055, 'South Common', '60 Independence Place', 47, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (38350, 'Buleya', '21488 Elmside Road', 682, null, 73, null, null, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (101627, 'Ndog-Bong', '20 Gerald Parkway', 585, 'cum sociis', 96, 1, 1, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (87499, 'O''Keefe', '636 Brown Lane', 138, null, 40, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (217043, 'Star Wars', '09 Mcbride Point', 324, null, 45, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (82420, 'River Valley', '70702 Mcguire Alley', 633, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (228151, 'River Valley', '2974 Duke Terrace', 690, null, 97, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (167778, 'Mercedes', '5136 Oakridge Lane', 242, null, 69, 1, 0, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (155704, 'Mercedes', '18381 David Way', 325, null, null, null, null, 1, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (132595, 'Mercedes', '7089 Commercial Court', 371, null, null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (151596, 'Victoria Hights', '81368 Atwood Street', 78, null, null, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (228584, 'Buleya', '36 Hovde Street', 661, null, null, 1, 0, 2, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (51323, 'Twin Brooks', '287 Clove Circle', 653, null, 62, null, null, 2, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (222762, 'Hermitage', '7120 Hanover Crossing', 344, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (13583, 'McEwan', '38738 Delladonna Park', 363, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (203653, 'Landcaster', '32 Forest Dale Pass', 680, null, 80, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (27022, 'Twin Brooks', '197 Arkansas Trail', 694, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (119001, 'Twin Brooks', '135 Vermont Trail', 668, null, null, null, null, 2, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (249461, 'McEwan', '7 Lawn Court', 394, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (98678, 'Twin Brooks', '32368 Sauthoff Avenue', 697, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (144603, 'Southgate Mall', '7008 Sachtjen Avenue', 601, null, null, null, null, 1, 1, 3, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (289525, 'South Common', '30574 Heffernan Terrace', 579, null, null, null, null, 1, 1, 1, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (309222, 'South Park', '11 Lukken Avenue', 370, null, null, null, null, 1, 1, 4, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (176504, 'Buleya', '29286 Meadow Ridge Terrace', 560, null, null, null, null, 2, 1, 2, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (211234, 'Buleya', '97 Hanson Alley', 398, 'et commodo vulputate', null, null, null, 1, 1, 5, 5);
insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, Watering, Planting, SiteTypeID, YardID, CommunityID, SeasonID) values (118206, 'River Valley', '464 Northland Point', 377, null, null, null, null, 2, 1, 3, 5);

--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, SiteTypeID, YardID, CommunityID, SeasonID) values (492282, 'Southgate Mall', '11001 25 Ave', 2584, null, 30, 1, 1, 1, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (589622, 'O"Keefe', '125036 Wlaterdale', 8275, null, 1, 1, 1, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, SiteTypeID, YardID, CommunityID, SeasonID) values (369852, 'Hermitage', '114 Street & 15 Ave', 265, null, 102, 1, 1, 1, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (120589, 'River Valley', '1047 Jasper Ave', 1124, null, 1, 1, 1, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (20583, 'Ndog-Bong', '9 Street & 57 Ave', 2002, null, 1, 1, 1, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (968452, 'Twin Brooks', '10258 23 Street', 4040, null, 1, 1, 1, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, SiteTypeID, YardID, CommunityID, SeasonID) values (895762, 'McEwan', '2682 McAllister Loop', 306, null, 10, 1, 1, 2, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (258964, 'McEwan', '50 Street & 101 Ave', 487, null, 1, 1, 2, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, SiteTypeID, YardID, CommunityID, SeasonID) values (89657, 'Allard', '90 Del Mar Court', 8800, null, 25, 1, 1, 2, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (120588, 'Asteraceae', '10258 127 Street', 2013, null, 1, 1, 2, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (301844, 'Star Wars', '12506 Roper Road', 256, null, 1, 1, 3, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (421256, 'Twin Towers', '36 Street & 128 Ave', 854, null, 1, 1, 3, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (685249, 'South Common', '111 Street & Gateway Boulevard', 8275, null, 1, 1, 3, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (789005, 'South Park', 'Calgary Trail & 25 Ave', 62, null, 1, 1, 3, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass, SiteTypeID, YardID, CommunityID, SeasonID) values (741056, 'Glenridding', '117 Street & 115 Ave', 45, null, 47, 1, 1, 4, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (942039, 'Glenridding', '120 Street & 105 Ave', 2258, null, 1, 1, 4, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (8520, 'Landcaster', '12745 Leger Trail', 115, null, 1, 1, 4, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (10236, 'Victoria Hights', '19 Street & 12 AVe', 20, null, 1, 1, 4, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, SiteTypeID, YardID, CommunityID, SeasonID) values (452289, 'Mercedes', '91 Street & Victoria Trail', 152, null, 1, 1, 5, 4);
--insert into Site (Pin, Neighbourhood, StreetAddress, Area, Notes, Grass,SiteTypeID, YardID, CommunityID, SeasonID) values (3332545, 'Buleya', '11011 29A Ave', 25, null, 73, 1, 1, 5, 4);

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