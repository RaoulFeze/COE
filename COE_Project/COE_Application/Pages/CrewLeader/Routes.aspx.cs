
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
                    RouteType.Text = "A";

                    List<RouteStatus> routeStatuses = routeManager.RouteList(int.Parse(YardID.Text), 1);
                    RouteListView.DataSource = routeStatuses;
                    RouteListView.DataBind();

                });
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
                    RouteListView.FindControl("Pruning").Visible = true;
                    RouteListView.FindControl("Mulching").Visible = true;
                    RouteListView.FindControl("Planting").Visible = false;
                    RouteListView.FindControl("Uprooting").Visible = false;
                    RouteListView.FindControl("Trimming").Visible = false;

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
                    RouteListView.FindControl("Pruning").Visible = true;
                    RouteListView.FindControl("Mulching").Visible = true;
                    RouteListView.FindControl("Planting").Visible = false;
                    RouteListView.FindControl("Uprooting").Visible = false;
                    RouteListView.FindControl("Trimming").Visible = false;

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
                    RouteListView.FindControl("Pruning").Visible = false;
                    RouteListView.FindControl("Mulching").Visible = false;
                    RouteListView.FindControl("Planting").Visible = false;
                    RouteListView.FindControl("Uprooting").Visible = false;
                    RouteListView.FindControl("Trimming").Visible = true;

                    foreach (ListViewItem item in RouteListView.Items)
                    {
                        (item.FindControl("HideC1")).Visible = false;
                        (item.FindControl("HideC2")).Visible = false;
                        (item.FindControl("HideC3")).Visible = false;
                        (item.FindControl("HideC4")).Visible = false;
                        (item.FindControl("HideC5")).Visible = false;
                        item.FindControl("HidePruning").Visible = false;
                        item.FindControl("HideMulching").Visible = false;
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
                    RouteListView.FindControl("Pruning").Visible = false;
                    RouteListView.FindControl("Mulching").Visible = false;
                    RouteListView.FindControl("Planting").Visible = false;
                    RouteListView.FindControl("Uprooting").Visible = false;
                    RouteListView.FindControl("Trimming").Visible = false;

                    foreach (ListViewItem item in RouteListView.Items)
                    {
                        (item.FindControl("HideC1")).Visible = true;
                        (item.FindControl("HideC2")).Visible = true;
                        (item.FindControl("HideC3")).Visible = true;
                        (item.FindControl("HideC4")).Visible = false;
                        (item.FindControl("HideC5")).Visible = false;
                        item.FindControl("HidePruning").Visible = false;
                        item.FindControl("HideMulching").Visible = false;
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
                    RouteListView.FindControl("Pruning").Visible = false;
                    RouteListView.FindControl("Mulching").Visible = false;
                    RouteListView.FindControl("Planting").Visible = true;
                    RouteListView.FindControl("Uprooting").Visible = true;
                    RouteListView.FindControl("Trimming").Visible = false;


                    foreach (ListViewItem item in RouteListView.Items)
                    {
                        (item.FindControl("HideC1")).Visible = false;
                        item.FindControl("HideC2").Visible = false;
                        item.FindControl("HideC3").Visible = false;
                        item.FindControl("HideC4").Visible = false;
                        item.FindControl("HideC5").Visible = false;
                        item.FindControl("HidePruning").Visible = false;
                        item.FindControl("HideMulching").Visible = false;
                        item.FindControl("HideTrimming").Visible = false;
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
            DataPager pager = (DataPager)RouteListView.FindControl("Route_DataPager");


            switch (index)
            {
                case 0:
                    SiteType.Text = "1";
                    RouteType.Text = "A";
                    pager.SetPageProperties(0, pager.PageSize, true);

                    break;
                case 1:
                    SiteType.Text = "2";
                    RouteType.Text = "B";
                    pager.SetPageProperties(0, pager.PageSize, true);

                    break;
                case 2:
                    SiteType.Text = "3";
                    RouteType.Text = "Grass";
                    pager.SetPageProperties(0, pager.PageSize, true);

                    break;
                case 3:
                    SiteType.Text = "4";

                    break;
                case 4:
                    SiteType.Text = "5";
                    RouteType.Text = "Planting";
                    pager.SetPageProperties(0, pager.PageSize, true);

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