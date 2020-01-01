
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using COE_Application.Security;

#region Additonal Namespaces
using COESystem.BLL;
using COESystem.Data.DTOs;
#endregion

namespace COE_Application.Pages.CrewLeader
{
    public partial class Routes : System.Web.UI.Page
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
            //RouteController routeManager = new RouteController();
            //YardID.Text = (routeManager.GetYardId(employeeId)).ToString();
            
            //AllRoutes(int.Parse(YardID.Text));
        }

        protected void AllRoutes(int yardId)
        {
            //Load the Gridview
            MessageUserControl.TryRun(() =>
            {
                RouteController routeManager = new RouteController();
                //List<RouteStatus> routes = routeManager.RouteStatus_List(yardId);
                //Yard.Text = routeManager.GetYardName(yardId);
                //Routes_ListView.DataSource = routes;
                //Routes_ListView.DataBind();
            });
        }

        protected void SearchRoutes_Click(object sender, EventArgs e)
        {
            MessageUserControl.TryRun(() =>
            {
                int pin;

                if(int.TryParse(SearchBox.Text, out pin))
                {
                    //RouteController routeManager = new RouteController();
                    //List<RouteStatus> route = routeManager.RouteStatus_Search(pin, int.Parse(YardID.Text));

                    //Routes_ListView.DataSource = route;
                    //Routes_ListView.DataBind();
                }
                else
                {
                    //RouteController routeManager = new RouteController();
                    //List<RouteStatus> route = routeManager.RouteStatus_Search(SearchBox.Text, int.Parse(YardID.Text));

                    //Routes_ListView.DataSource = route;
                    //Routes_ListView.DataBind();
                }
               
               
            });
        }

        protected void RoutesA_Click(object sender, EventArgs e)
        {
            RouteType.Text = "A";
            SearchBox.Text = "";
            MessageUserControl.TryRun(() =>
            {
               
                //RouteController routeManager = new RouteController();
                //List<RouteStatus> route = routeManager.RouteStatus_List(int.Parse(YardID.Text), "A");

                //Routes_ListView.DataSource = route;
                //Routes_ListView.DataBind();
            });
        }

        protected void RoutesB_Click(object sender, EventArgs e)
        {
            RouteType.Text = "B";
            SearchBox.Text = "";
            MessageUserControl.TryRun(() =>
            {
                //RouteController routeManager = new RouteController();
                //List<RouteStatus> route = routeManager.RouteStatus_List(int.Parse(YardID.Text), "B");

                //Routes_ListView.DataSource = route;
                //Routes_ListView.DataBind();
            });
        }

        protected void Grass_Click(object sender, EventArgs e)
        {

        }

        protected void Reset_Click(object sender, EventArgs e)
        {
            RouteType.Text = "";
            SearchBox.Text = "";
           
            AllRoutes(int.Parse(YardID.Text));
        }
    }
}