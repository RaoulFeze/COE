﻿

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

            // Retrieve the YardID based on the current userId 
            // Set the Yard ID as in invisible label on the web page.
            SecurityController securityManager = new SecurityController();
            int? employeeId = securityManager.GetCurrentUserId(User.Identity.Name);
            RouteController routeManager = new RouteController();
            YardID.Text = routeManager.GetYardId(employeeId).ToString();
           
        }

        protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
        {
            MessageUserControl.HandleDataBoundException(e);
        }
        protected void AddCrewLinkButton_Click(object sender, EventArgs e)
        {
            MessageUserControl.TryRun(() =>
            {
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

        protected void UnitsDDL_SelectedIndexChanged(object sender, EventArgs e)
        {
            MessageUserControl.TryRun(() =>
            {
                EmployeeControllers employeeManager = new EmployeeControllers();
                if (UnitsDDL.SelectedIndex == 0)
                {
                    EmployeesListView.DataSource = null;
                    EmployeesListView.DataBind();
                    EmployeesListView.Visible = false;
                    MessageUserControl.ShowInfo("You must select a Unit to proceed");
                }
                else
                {
                    EmployeesListView.Visible = true;
                }
            });
        }

        protected void RouteCategory_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void EmployeesListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            int employeeId = int.Parse(e.CommandArgument.ToString());
            int unitid = int.Parse(UnitsDDL.SelectedValue);
            MessageUserControl.TryRun(() =>
            {
                //Add a new Member to a Crew

                //Refresh the Crew List
                CrewControllers crewManager = new CrewControllers();
                List<CurrentCrew> currentCrews = crewManager.GetCurrentCrew(int.Parse(YardID.Text));
                CrewRepeater.DataSource = currentCrews;
                CrewRepeater.DataBind();
            });
        }
    }
}