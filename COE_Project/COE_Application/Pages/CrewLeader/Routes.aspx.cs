
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

            int yardId = 589;
            int season = (int)DateTime.Now.Year;

            //Load the Gridview
            MessageUserControl.TryRun(() =>
            {
                RouteController routeManager = new RouteController();
                List<RouteStatus> routes = routeManager.RouteStatus_List(2020, yardId);
                GridView1.DataSource = routes;
                GridView1.DataBind();
            });
        }
    }
}