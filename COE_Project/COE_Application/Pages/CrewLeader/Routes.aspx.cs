
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Web.UI.WebControls;
using COE_Application.Security;

#region Additonal Namespaces
using COESystem.BLL;
using COESystem.Data.POCOs;
#endregion

namespace COE_Application.Pages.CrewLeader
{
    public partial class Routes : System.Web.UI.Page
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

                // Retrieve the YardID based on the current userId 
                // Set the Yard ID as in invisible label on the web page.
                MessageUserControl.TryRun(() =>
                {
                    SecurityController securityManager = new SecurityController();
                    int? employeeId = securityManager.GetCurrentUserId(User.Identity.Name);

                    RouteController routeManager = new RouteController();
                    Season.Text = DateTime.Now.Year.ToString();
                    Yard.Text = routeManager.GetYardName(employeeId);
                    YardID.Text = routeManager.GetYardId(employeeId).ToString();
                    SiteType.Text = "1";

                });
            }
           
        }
        //This method switch on the needed columns and turn off those not needed
        protected void Page_PreRenderComplete(object sender, EventArgs e)
        {


            int site = int.Parse(SiteType.Text);
            switch (site)
            {
                case 1:
                    foreach (ListViewItem item in RouteAListView.Items)
                    {

                        RouteAListView.FindControl("Cycle3").Visible = true;
                        RouteAListView.FindControl("Cycle4").Visible = true;
                        RouteAListView.FindControl("Cycle5").Visible = true;


                    }
                    break;
                case 2:
                    RouteAListView.FindControl("Cycle3").Visible = false;
                    RouteAListView.FindControl("Cycle4").Visible = false;
                    RouteAListView.FindControl("Cycle5").Visible = false;
                    foreach (ListViewItem item in RouteAListView.Items)
                    {

                        (item.FindControl("HideMe")).Visible = false;
                        (item.FindControl("HideMe4")).Visible = false;
                        (item.FindControl("HideMe5")).Visible = false;

                    }
                    break;
                case 3:
                    foreach (ListViewItem item in RouteAListView.Items)
                    {
                        RouteAListView.FindControl("Cycle2Label").Visible = false;
                        RouteAListView.FindControl("Cycle3Label").Visible = false;
                        RouteAListView.FindControl("Cycle4Label").Visible = false;
                        RouteAListView.FindControl("Cycle5Label").Visible = false;
                        RouteAListView.FindControl("PruningLabel").Visible = false;
                        RouteAListView.FindControl("MulchingLabel").Visible = false;
                    }
                    break;
            }


        }

        protected void CheckForException(object sender, ObjectDataSourceStatusEventArgs e)
        {
            MessageUserControl.HandleDataBoundException(e);
        }

        //This method switches views on the MultiView
        protected void RouteMenu_MenuItemClick(object sender, MenuEventArgs e)
        {
            int index = Int32.Parse(e.Item.Value);
            //RoutesMultiView.ActiveViewIndex = index;
           
            RouteController routeManager = new RouteController();

            //Gets hold of the Pager to reset it when user changes route type
            DataPager pager = (DataPager)RouteAListView.FindControl("RouteA_DataPager");


            switch (index)
            {
                case 0:
                        SiteType.Text = "1";
                    pager.SetPageProperties(0, pager.PageSize, true);

                    break;
                case 1:
                        SiteType.Text = "2";
                    pager.SetPageProperties(0, pager.PageSize, true);
                    break;
                case 2:
                        SiteType.Text = "3";
                    pager.SetPageProperties(0, pager.PageSize, true);
                    int yardId = int.Parse(YardID.Text);
                        MessageUserControl.TryRun(() =>
                        {
                            List<GrassStatus> GrassRoute = routeManager.GrassList(yardId);
                            RouteAListView.DataSource = GrassRoute;
                            RouteAListView.DataBind();
                        });
                        break;
            }
        }

      

        //protected void SearchRoutes_Click(object sender, EventArgs e)
        //{
        //    MessageUserControl.TryRun(() =>
        //    {
        //        int pin;

        //        if(int.TryParse(SearchBox.Text, out pin))
        //        {
        //            RouteController routeManager = new RouteController();
        //            List<RouteStatus> route = routeManager.RouteStatus_Search(pin, int.Parse(YardID.Text));

        //            Routes_ListView.DataSource = route;
        //            Routes_ListView.DataBind();
        //        }
        //        else
        //        {
        //            RouteController routeManager = new RouteController();
        //            List<RouteStatus> route = routeManager.RouteStatus_Search(SearchBox.Text, int.Parse(YardID.Text));

        //            Routes_ListView.DataSource = route;
        //            Routes_ListView.DataBind();
        //        }
               
               
        //    });
        //}

        //protected void RoutesA_Click(object sender, EventArgs e)
        //{
        //    RouteType.Text = "A";
        //    SearchBox.Text = "";
        //    MessageUserControl.TryRun(() =>
        //    {

        //        RouteController routeManager = new RouteController();
        //        List<RouteStatus> route = routeManager.RouteStatus_List(int.Parse(YardID.Text), "A");

        //        Routes_ListView.DataSource = route;
        //        Routes_ListView.DataBind();
        //    });
        //}

        //protected void RoutesB_Click(object sender, EventArgs e)
        //{
        //    RouteType.Text = "B";
        //    SearchBox.Text = "";
        //    MessageUserControl.TryRun(() =>
        //    {
        //        RouteController routeManager = new RouteController();
        //        List<RouteStatus> route = routeManager.RouteStatus_List(int.Parse(YardID.Text), "B");

        //        Routes_ListView.DataSource = route;
        //        Routes_ListView.DataBind();
        //    });
        //}

        protected void Grass_Click(object sender, EventArgs e)
        {

        }

        //protected void Reset_Click(object sender, EventArgs e)
        //{
        //    RouteType.Text = "";
        //    SearchBox.Text = "";
           
        //    AllRoutes(int.Parse(YardID.Text));
        //}
    }
}