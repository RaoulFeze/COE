using COE_Application.Security;
using COESystem.BLL;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
            UnitsDDL.Visible = false;
        }

        protected void AddCrewLinkButton_Click(object sender, EventArgs e)
        {
           
                UnitsDDL.Visible = true;
            
           
        }
    }
}