

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

                    //Populate the current Crews
                    CrewControllers crewManager = new CrewControllers();
                    List<CurrentCrew> currentCrews = crewManager.GetCurrentCrew(int.Parse(YardID.Text));
                    CrewRepeater.DataSource = currentCrews;
                    CrewRepeater.DataBind();
                });
            }
        }

        protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
        {
            MessageUserControl.HandleDataBoundException(e);
        }
        protected void AddCrewLinkButton_Click(object sender, EventArgs e)
        {
            LoadDDLUnits();

        }

        protected void UnitsDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            PopulateEmployeeAndSiteType();
            RouteAListView.Visible = false;
            RouteBListView.Visible = false;
        }

        protected void RouteCategory_SelectedIndexChanged(object sender, EventArgs e)
        {
            Test.Text = RouteCategory.SelectedValue;
            MessageUserControl.TryRun(() =>
            {
                CrewControllers crewManager = new CrewControllers();
                List<CurrentCrew> currentCrews = crewManager.GetCurrentCrew(int.Parse(YardID.Text));
                CrewRepeater.DataSource = currentCrews;
                CrewRepeater.DataBind();
            });
            
        }

        protected void EmployeesListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            int employeeId = int.Parse(e.CommandArgument.ToString());
            int unitId = int.Parse(UnitsDDL.SelectedValue);
            MessageUserControl.TryRun(() =>
            {
                CrewControllers crewManager = new CrewControllers();
                //Add a new Member to a Crew
                crewManager.Add_To_A_Crew(unitId, employeeId);

                //Refresh the Crew List
                List<CurrentCrew> currentCrews = crewManager.GetCurrentCrew(int.Parse(YardID.Text));
                CrewRepeater.DataSource = currentCrews;
                CrewRepeater.DataBind();
            });
        }

        protected void CrewRepeater_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "SelectCrew":
                    LoadDDLUnits();
                    int crewId = int.Parse(e.CommandArgument.ToString());

                    MessageUserControl.TryRun(() =>
                    {
                        CrewControllers crewManager = new CrewControllers();
                        UnitsDDL.SelectedValue = crewManager.unitNumber(crewId).ToString();
                    });
                    PopulateEmployeeAndSiteType();
                    SelectedCrew.Text = crewId.ToString();

                    if(RouteAListView.Visible == true)
                    {
                        RouteAListView.Visible = false;
                    }
                    
                    break;

                case "DeleteCrew":
                    //TODO: Verify that you are not using the UnitID instead of the CrewID
                    
                    MessageUserControl.TryRun(() =>
                    {
                        int CrewId = int.Parse(e.CommandArgument.ToString());
                        CrewControllers crewManager = new CrewControllers();
                        crewManager.DeleteCrew(CrewId);

                        //refresh the current Crews
                        List<CurrentCrew> currentCrews = crewManager.GetCurrentCrew(int.Parse(YardID.Text));
                        CrewRepeater.DataSource = currentCrews;
                        CrewRepeater.DataBind();
                    });
                    break;

                case "DeleteMember":
                    int crewMemberId = int.Parse(e.CommandArgument.ToString());
                    MessageUserControl.TryRun(() =>
                    {
                        CrewControllers crewManager = new CrewControllers();
                        crewManager.RemoveCrewMember(crewMemberId);

                        //refresh the current Crews
                        List<CurrentCrew> currentCrews = crewManager.GetCurrentCrew(int.Parse(YardID.Text));
                        CrewRepeater.DataSource = currentCrews;
                        CrewRepeater.DataBind();
                    });
                    break;

                case "DeleteSite":
                    break;
            }
        }

        protected void SelectSiteButton_Click(object sender, EventArgs e)
        {
            int index = int.Parse(RouteCategory.SelectedValue.ToString());

            switch (index)
            {
                case 1:
                    SiteType.Text = "1";
                    RouteAListView.Visible = true;
                    RouteBListView.Visible = false;
                    EmployeesListView.Visible = false;
                    
                    break;
                case 2:
                    SiteType.Text = "2";
                    RouteAListView.Visible = false;
                    RouteBListView.Visible = true;
                    EmployeesListView.Visible = false;
                    break;
            }
        }
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
                UnitsDDL.DataValueField = nameof(YardUnits.ID);
                UnitsDDL.DataBind();
                UnitsDDL.Items.Insert(0, "Select a Unit...");
            });

            UnitsDDL.Visible = true;
            UnitLabel.Visible = true;
        }

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
                }
            });
        }

        protected void RouteListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            int siteId = int.Parse(e.CommandArgument.ToString());
            int crewId = int.Parse(SelectedCrew.Text);
            string message = "";

            CrewControllers crewManager = new CrewControllers();
            MessageUserControl.TryRun(() =>
            {
                message = crewManager.Add_Site_To_Crew(crewId, siteId);
            });

            if (!string.IsNullOrEmpty(message))
            {
                MessageUserControl.ShowInfo("This site is already assigned to the following crews: " + message);
            }

            //Refresh the Crew List
            List<CurrentCrew> currentCrews = crewManager.GetCurrentCrew(int.Parse(YardID.Text));
            CrewRepeater.DataSource = currentCrews;
            CrewRepeater.DataBind();
        }
    }
}