
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            //string crewLeaderRole = ConfigurationManager.AppSettings["crewLeaderRole"];
            //if (Request.IsAuthenticated)
            //{
            //    if(!User.IsInRole(crewLeaderRole))
            //    {
            //        Response.Redirect("~/Account/Login.aspx");
            //    }
            //}
            //else
            //{
            //    Response.Redirect("~/Account/Login.aspx");
            //}

            int yardId = 1;
            int season = (int)DateTime.Now.Year;
            AllRoutes(yardId, season);
        }

        protected void AllRoutes(int yardId, int season)
        {
            //Load the Gridview
            MessageUserControl.TryRun(() =>
            {
                RouteController routeManager = new RouteController();
                List<RouteStatus> routes = routeManager.RouteStatus_List(season, yardId);
                Yard.Text = routeManager.YardName(yardId);
                //GridView1.DataSource = routes;
                //GridView1.DataBind();

                //foreach(RouteStatus status in routes)
                //{
                //    GridView2.DataSource = status.JobDone;
                //    GridView2.DataBind();
                //}
            });
        }

        protected void SearchRoutes_Click(object sender, EventArgs e)
        {
            MessageUserControl.TryRun(() =>
            {
                int pin = int.Parse(SearchBox.Text);
                RouteController routeManager = new RouteController();
                List<RouteStatus> route = routeManager.GetRouteStatus(pin);

                Routes_ListView.DataSource = route;
                Routes_ListView.DataBind();
            });
        }

        protected void RoutesA_Click(object sender, EventArgs e)
        {

        }

        protected void RoutesB_Click(object sender, EventArgs e)
        {

        }

        protected void Grass_Click(object sender, EventArgs e)
        {

        }

        protected void Reset_Click(object sender, EventArgs e)
        {

        }
    }
}