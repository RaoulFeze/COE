

using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

#region Additional Namespaces
using COE_Application.Security;
using COESystem.BLL;
using COESystem.BLL.CrewLeaderControllers;
using COESystem.Data.DTOs;
using COESystem.Data.POCOs;
#endregion

namespace COE_Application.Pages.CrewLeader
{
    public partial class Crews : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string crewLeaderRole = ConfigurationManager.AppSettings["crewLeaderRole"];
                if (Request.IsAuthenticated)
                {
                    if (!User.IsInRole(crewLeaderRole))
                    {
                        Response.Redirect("~/Account/Login.aspx");
                    }
                }
                else
                {
                    Response.Redirect("~/Account/Login.aspx");
                }

                MessageUserControl.TryRun(() =>
                {
                    // Retrieve the YardID based on the current userId 
                    // Set the Yard ID as in invisible label on the web page.
                    SecurityController securityManager = new SecurityController();
                    int? employeeId = securityManager.GetCurrentUserId(User.Identity.Name);
                    RouteController routeManager = new RouteController();
                    YardID.Text = routeManager.GetYardId(employeeId).ToString();
                    SiteType.Text = "1";

                    //Populate the current Crews
                    CrewControllers crewManager = new CrewControllers();
                    List<CurrentCrew> currentCrews = crewManager.GetCurrentCrew(int.Parse(YardID.Text));
                    CrewRepeater.DataSource = currentCrews;
                    CrewRepeater.DataBind();
                });
                RouteListView.Visible = false;
            }
        }

        //This method switch on the needed columns and turn off those not needed
        protected void Page_PreRenderComplete(object sender, EventArgs e)
        {
            RouteController routeManager = new RouteController();
            int siteType = int.Parse(SiteType.Text);
            int yardId = int.Parse(YardID.Text);
            switch (siteType)
            {
                //A Routes
                case 1:
                    MessageUserControl.TryRun(() =>
                    {
                        List<RouteStatus> routeStatuses = routeManager.RouteList(yardId, siteType);
                        RouteListView.DataSource = routeStatuses;
                        RouteListView.DataBind();
                    });

                    RouteListView.FindControl("Cycle1").Visible = true;
                    RouteListView.FindControl("Cycle2").Visible = true;
                    RouteListView.FindControl("Cycle3").Visible = true;
                    RouteListView.FindControl("Cycle4").Visible = true;
                    RouteListView.FindControl("Cycle5").Visible = true;
                    RouteListView.FindControl("Planting").Visible = false;
                    RouteListView.FindControl("Uprooting").Visible = false;
                    RouteListView.FindControl("Trimming").Visible = false;
                    Route.Visible = true;

                    foreach (ListViewItem item in RouteListView.Items)
                    {
                        (item.FindControl("HidePlanting")).Visible = false;
                        (item.FindControl("HideUprooting")).Visible = false;
                        (item.FindControl("HideTrimming")).Visible = false;
                    }

                    break;

                //B Routes
                case 2:

                    MessageUserControl.TryRun(() =>
                    {
                        List<RouteStatus> routeStatuses = routeManager.RouteList(yardId, siteType);
                        RouteListView.DataSource = routeStatuses;
                        RouteListView.DataBind();
                    });

                    RouteListView.FindControl("Cycle1").Visible = true;
                    RouteListView.FindControl("Cycle2").Visible = true;
                    RouteListView.FindControl("Cycle3").Visible = false;
                    RouteListView.FindControl("Cycle4").Visible = false;
                    RouteListView.FindControl("Cycle5").Visible = false;
                    RouteListView.FindControl("Planting").Visible = false;
                    RouteListView.FindControl("Uprooting").Visible = false;
                    RouteListView.FindControl("Trimming").Visible = false;
                    Route.Visible = true;

                    foreach (ListViewItem item in RouteListView.Items)
                    {
                        (item.FindControl("HideC3")).Visible = false;
                        (item.FindControl("HideC4")).Visible = false;
                        (item.FindControl("HideC5")).Visible = false;

                        (item.FindControl("HidePlanting")).Visible = false;
                        (item.FindControl("HideUprooting")).Visible = false;
                        (item.FindControl("HideTrimming")).Visible = false;
                    }

                    break;

                //Grass Routes
                case 3:
                    MessageUserControl.TryRun(() =>
                    {
                        List<RouteStatus> GrassList = routeManager.GrassRouteList(yardId);
                        RouteListView.DataSource = GrassList;
                        RouteListView.DataBind();
                    });

                    RouteListView.FindControl("Cycle1").Visible = false;
                    RouteListView.FindControl("Cycle2").Visible = false;
                    RouteListView.FindControl("Cycle3").Visible = false;
                    RouteListView.FindControl("Cycle4").Visible = false;
                    RouteListView.FindControl("Cycle5").Visible = false;
                    RouteListView.FindControl("Planting").Visible = false;
                    RouteListView.FindControl("Uprooting").Visible = false;
                    RouteListView.FindControl("Trimming").Visible = true;
                    Route.Visible = true;

                    foreach (ListViewItem item in RouteListView.Items)
                    {
                        (item.FindControl("HideC1")).Visible = false;
                        (item.FindControl("HideC2")).Visible = false;
                        (item.FindControl("HideC3")).Visible = false;
                        (item.FindControl("HideC4")).Visible = false;
                        (item.FindControl("HideC5")).Visible = false;
                        (item.FindControl("HidePlanting")).Visible = false;
                        (item.FindControl("HideUprooting")).Visible = false;
                    }
                    break;

                //Watering Routes
                case 4:
                    MessageUserControl.TryRun(() =>
                    {
                        List<RouteStatus> wateringList = routeManager.WateringList(yardId);
                        RouteListView.DataSource = wateringList;
                        RouteListView.DataBind();
                    });

                    RouteListView.FindControl("Cycle1").Visible = true;
                    RouteListView.FindControl("Cycle2").Visible = true;
                    RouteListView.FindControl("Cycle3").Visible = true;
                    RouteListView.FindControl("Cycle4").Visible = false;
                    RouteListView.FindControl("Cycle5").Visible = false;
                    RouteListView.FindControl("Planting").Visible = false;
                    RouteListView.FindControl("Uprooting").Visible = false;
                    RouteListView.FindControl("Trimming").Visible = false;
                    Route.Visible = true;

                    foreach (ListViewItem item in RouteListView.Items)
                    {
                        (item.FindControl("HideC1")).Visible = true;
                        (item.FindControl("HideC2")).Visible = true;
                        (item.FindControl("HideC3")).Visible = true;
                        (item.FindControl("HideC4")).Visible = false;
                        (item.FindControl("HideC5")).Visible = false;
                        (item.FindControl("HidePlanting")).Visible = false;
                        (item.FindControl("HideUprooting")).Visible = false;
                        (item.FindControl("HideTrimming")).Visible = false;
                    }
                    break;

                //Planting Routes
                case 5:
                    MessageUserControl.TryRun(() =>
                    {
                        List<RouteStatus> PlantingList = routeManager.PlantingList(yardId);
                        RouteListView.DataSource = PlantingList;
                        RouteListView.DataBind();
                    });


                    RouteListView.FindControl("Cycle1").Visible = false;
                    RouteListView.FindControl("Cycle2").Visible = false;
                    RouteListView.FindControl("Cycle3").Visible = false;
                    RouteListView.FindControl("Cycle4").Visible = false;
                    RouteListView.FindControl("Cycle5").Visible = false;
                    RouteListView.FindControl("Planting").Visible = true;
                    RouteListView.FindControl("Uprooting").Visible = true;
                    RouteListView.FindControl("Trimming").Visible = false;
                    Route.Visible = true;


                    foreach (ListViewItem item in RouteListView.Items)
                    {
                        (item.FindControl("HideC1")).Visible = false;
                        item.FindControl("HideC2").Visible = false;
                        item.FindControl("HideC3").Visible = false;
                        item.FindControl("HideC4").Visible = false;
                        item.FindControl("HideC5").Visible = false;
                        item.FindControl("HideTrimming").Visible = false;
                    }
                    break;
            }
        }

        //Handles Exception
        protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
        {
            MessageUserControl.HandleDataBoundException(e);
        }

        protected void AddCrewLinkButton_Click(object sender, EventArgs e)
        {
            LoadDDLUnits();

        }

        //This method populates the list of emplyees and the different site types
        protected void UnitsDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateEmployeeAndSiteType();
            RouteListView.Visible = false;
            CrewControllers crewManager = new CrewControllers();
            int crewId = crewManager.GetCrewID(int.Parse(UnitsDDL.SelectedValue));
            CrewID.Text = crewId == 0 ? "" : crewId.ToString();
        }

        //This method displays the Current Crews
        protected void RouteCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            MessageUserControl.TryRun(() =>
            {
                CrewControllers crewManager = new CrewControllers();
                List<CurrentCrew> currentCrews = crewManager.GetCurrentCrew(int.Parse(YardID.Text));
                CrewRepeater.DataSource = currentCrews;
                CrewRepeater.DataBind();
                Route.Text = "Crew Members";
            });
            
        }

        //This Methode Creates(respectively Adds) a new crew (repectively crew members)
        protected void EmployeesListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            int employeeId = int.Parse(e.CommandArgument.ToString());
            int unitId = int.Parse(UnitsDDL.SelectedValue);
            int crewId;
            MessageUserControl.TryRun(() =>
            {
                CrewControllers crewManager = new CrewControllers();
                //Add a new Member to a Crew
                crewId = crewManager.Add_To_A_Crew(unitId, employeeId);
                CrewID.Text = crewId.ToString();

                //Refresh the Crew List
                List<CurrentCrew> currentCrews = crewManager.GetCurrentCrew(int.Parse(YardID.Text));
                CrewRepeater.DataSource = currentCrews;
                CrewRepeater.DataBind();
            });
        }

        //This Method all operations on the currents crews (Select crew, Delete Crew, Delete Crew Member, Remove sites from Crews)
        protected void CrewRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            CrewControllers crewManager = new CrewControllers();
            int yardId = int.Parse(YardID.Text);
            switch (e.CommandName)
            {
                case "SelectCrew":
                    LoadDDLUnits();
                    int crewId = int.Parse(e.CommandArgument.ToString());

                    MessageUserControl.TryRun(() =>
                    {
                        UnitsDDL.SelectedValue = crewManager.unitNumber(crewId).ToString();
                        Route.Text = "Crew Members";
                        CrewID.Text = crewId.ToString();
                    });
                    PopulateEmployeeAndSiteType();
                    CrewID.Text = crewId.ToString();

                    if(RouteListView.Visible == true)
                    {
                        RouteListView.Visible = false;
                    }
                    
                    break;

                case "DeleteCrew":
                    MessageUserControl.TryRun(() =>
                    {
                        int CrewId = int.Parse(e.CommandArgument.ToString());
                        crewManager.DeleteCrew(CrewId);

                        //refresh the current Crews
                        List<CurrentCrew> currentCrews = crewManager.GetCurrentCrew(yardId);
                        CrewRepeater.DataSource = currentCrews;
                        CrewRepeater.DataBind();
                    });
                    break;

                case "DeleteMember":
                    int crewMemberId = int.Parse(e.CommandArgument.ToString());
                    MessageUserControl.TryRun(() =>
                    {
                        crewManager.RemoveCrewMember(crewMemberId);

                        //refresh the current Crews
                        List<CurrentCrew> currentCrews = crewManager.GetCurrentCrew(yardId);
                        CrewRepeater.DataSource = currentCrews;
                        CrewRepeater.DataBind();
                    });
                    break;

                case "DeleteSite":
                    int crewSiteId = int.Parse(e.CommandArgument.ToString());
                    MessageUserControl.TryRun(() =>
                    {
                        crewManager.RemoveCrewSite(crewSiteId);

                        //refresh the current Crews
                        List<CurrentCrew> currentCrews = crewManager.GetCurrentCrew(yardId);
                        CrewRepeater.DataSource = currentCrews;
                        CrewRepeater.DataBind();
                    });
                    break;
            }
        }

        //This Methode populates the differents site types
        protected void SelectSiteButton_Click(object sender, EventArgs e)
        {
            int index = int.Parse(RouteCategory.SelectedValue.ToString());
            RouteController routeManager = new RouteController();
            DataPager pager = (DataPager)RouteListView.FindControl("Route_DataPager");
            int yardId = int.Parse(YardID.Text);

            switch (index)
            {
                //Populate A Routes
                case 1:
                    SiteType.Text = "1";
                    RouteListView.DataSource = routeManager.RouteList(yardId, 1);
                    RouteListView.DataBind();
                    RouteListView.Visible = true;
                    EmployeesListView.Visible = false;
                    Route.Text = "A Routes";
                    pager.SetPageProperties(0, pager.PageSize, true);

                    break;
                    //Populates B Routes
                case 2:
                    SiteType.Text = "2";
                    RouteListView.DataSource = routeManager.RouteList(yardId, 2);
                    RouteListView.DataBind();
                    RouteListView.Visible = true;
                    EmployeesListView.Visible = false;
                    Route.Text = "B Routes";
                    pager.SetPageProperties(0, pager.PageSize, true);
                    break;
                case 3:
                    SiteType.Text = "3";
                    RouteListView.DataSource = routeManager.GrassRouteList(yardId);
                    RouteListView.DataBind();
                    RouteListView.Visible = true;
                    EmployeesListView.Visible = false;
                    Route.Text = "Grass Routes";
                    pager.SetPageProperties(0, pager.PageSize, true);
                    break;
                case 4:
                    SiteType.Text = "4";
                    RouteListView.DataSource = routeManager.WateringList(yardId);
                    RouteListView.DataBind();
                    RouteListView.Visible = true;
                    EmployeesListView.Visible = false;
                    Route.Text = "Watering Routes";
                    pager.SetPageProperties(0, pager.PageSize, true);
                    break;
                case 5:
                    SiteType.Text = "5";
                    RouteListView.DataSource = routeManager.PlantingList(yardId);
                    RouteListView.DataBind();
                    RouteListView.Visible = true;
                    EmployeesListView.Visible = false;
                    Route.Text = "Planting Routes";
                    pager.SetPageProperties(0, pager.PageSize, true);
                    break;
            }
        }

        //This Method loads the Unit Drop Down List
        protected void LoadDDLUnits()
        {
            MessageUserControl.TryRun(() =>
            {
                //Populate the Units Dropdown List
                int yardId = int.Parse(YardID.Text);
                UnitControllers unitManager = new UnitControllers();
                List<YardUnits> unit = unitManager.GetUnits(int.Parse(YardID.Text));
                UnitsDDL.DataSource = unit;
                UnitsDDL.DataTextField = nameof(YardUnits.Number);
                UnitsDDL.DataValueField = nameof(YardUnits.UnitID);
                UnitsDDL.DataBind();
                UnitsDDL.Items.Insert(0, "Select a Unit...");
            });

            UnitsDDL.Visible = true;
            UnitLabel.Visible = true;
        }

        //This Method populates the cureent Crews and their assigned job sites
        protected void PopulateEmployeeAndSiteType()
        {
            MessageUserControl.TryRun(() =>
            {
                EmployeeControllers employeeManager = new EmployeeControllers();
                if (UnitsDDL.SelectedIndex == 0)
                {
                    //Validate that a Unit was selected
                    EmployeesListView.DataSource = null;
                    EmployeesListView.DataBind();
                    EmployeesListView.Visible = false;
                    MessageUserControl.ShowInfo("You must select a Unit to proceed");
                    RouteCategory.Visible = false;
                }
                else
                {
                    EmployeesListView.Visible = true;
                    RouteCategory.Visible = true;
                    SelectSiteButton.Visible = true;
                    Route.Text = "Crew Member";
                }
            });
        }

        //This Method adds a site to a Crew
        protected void RouteListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            int siteId = int.Parse(e.CommandArgument.ToString());
            int crewId;
            string message = "";
            if(!int.TryParse(CrewID.Text, out crewId))
            {
                //Verifies that a the selected a crew exists with the selected Unit 
                MessageUserControl.ShowInfo("You must create a crew before assigning job sites. To make a crew select a Unit and Add at leat one (1) employee");
                RouteListView.Visible = false;
                EmployeesListView.Visible = true;
                Route.Text = "Crew Member";
            }
            else
            {
                CrewControllers crewManager = new CrewControllers();
                MessageUserControl.TryRun(() =>
                {
                    message = crewManager.Add_Site_To_Crew(crewId, siteId);
                    //Refresh the List of Crews
                    List<CurrentCrew> currentCrews = crewManager.GetCurrentCrew(int.Parse(YardID.Text));
                    CrewRepeater.DataSource = currentCrews;
                    CrewRepeater.DataBind();
                });

                if (!string.IsNullOrEmpty(message))
                {
                    MessageUserControl.ShowInfo("This site is already assigned to the following crews: " + message);
                };
            }

           
        }
    }
}