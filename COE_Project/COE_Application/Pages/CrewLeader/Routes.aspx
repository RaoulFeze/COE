<%@ Page Title="Routes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Routes.aspx.cs" Inherits="COE_Application.Pages.CrewLeader.Routes" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>



<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <uc1:MessageUserControl runat="server" id="MessageUserControl" />
    </div>
    <div class="row">
        <div class="routesHeader">
            <h1>
                <asp:Label ID="Yard" runat="server" Text=""></asp:Label>
                <asp:Label ID="RouteType" runat="server" Text=""></asp:Label>
                <asp:Label ID="Label1" runat="server" Text="Routes Inventory"></asp:Label>
                <asp:Label ID="YardID" runat="server" Text="" Visible="false"></asp:Label>
                <asp:Label ID="Season" runat="server" Text=""></asp:Label>
                <asp:Label ID="SiteType" runat="server" Text="" Visible="false"></asp:Label>
            </h1>
        </div>
    </div>
   
    <div class="row">
        <%--<div class="col-md-2">
            <div class="sideControls">
                <div class="input-group">
                    <asp:TextBox ID="SearchBox" runat="server" CssClass="SearchBox" PlaceHolder="Enter Pin/Community"></asp:TextBox>
                    <asp:LinkButton ID="SearchRoutes" runat="server" CssClass="input-group-append input-group-addon" OnClick="SearchRoutes_Click">
                   <span class="glyphicon glyphicon-search "></span>
                    </asp:LinkButton>
                </div>
                <br />
                <div class="routeControls">
                    <asp:Button ID="RoutesA" runat="server" Text="Routes A" CssClass="button" OnClick="RoutesA_Click" /><br />
                    <br />
                    <asp:Button ID="RoutesB" runat="server" Text="Routes B" CssClass="button" OnClick="RoutesB_Click" /><br />
                    <br />
                    <asp:Button ID="Grass" runat="server" Text="Grass" CssClass="button" OnClick="Grass_Click" /><br />
                    <br />
                    <asp:Button ID="Reset" runat="server" Text="Reset" CssClass="button" OnClick="Reset_Click" />
                </div>
            </div>
        </div>--%>

        <div class="">
        <asp:Menu ID="RouteMenu" runat="server"
            Orientation="Horizontal"
            StaticMenuItemStyle-CssClass="tab"
            StaticMenuItemStyle-HorizontalPadding="50px"
            StaticSelectedStyle-CssClass="selectedTab"
            StaticSelectedStyle-BackColor="ForestGreen"
            StaticSelectedStyle-ForeColor="Black"
            CssClass="tabs"
            Font-Size="Large"
            ForeColor="Black" 
            OnMenuItemClick="RouteMenu_MenuItemClick">
            <Items>
                <asp:MenuItem Text="A Routes" Selected="true" Value="0"></asp:MenuItem>
                <asp:MenuItem Text="B Routes" Value="1"></asp:MenuItem>
                <asp:MenuItem Text="Grass Routes" Value="2"></asp:MenuItem>
                <asp:MenuItem Text="Watering Routes" Value="3"></asp:MenuItem>
                <asp:MenuItem Text="Planting Route" Value="4"></asp:MenuItem>
                <asp:MenuItem Text="Route Update" Value="5"></asp:MenuItem>
<%--                <asp:MenuItem Text="History" Value="5"></asp:MenuItem>--%>
                <asp:MenuItem Text="Statistics" Value="6"></asp:MenuItem>
            </Items>
        </asp:Menu>
        <div class="tabContents">
            <asp:MultiView ID="RoutesMultiView" runat="server" ActiveViewIndex="0">
                <asp:View ID="Route_View" runat="server">
                    <fieldset class="form-horizontal">
                        <div class="RouteStyle">
                            <asp:ListView ID="RouteListView" runat="server">
                                <AlternatingItemTemplate>
                                    <tr style="background-color: #E9E9E9; color: black;" class="cellPad">
                                        <td> <%# Container.DataItemIndex + 1%> </td>
                                        <td id="pin">
                                            <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel"/></td>
                                        <td id="commumity">
                                            <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel"/></td>
                                        <td id="neigh">
                                            <asp:Label Text='<%# Eval("Neighbourhood") %>' runat="server" ID="NeighbourhoodLabel"/></td>
                                        <td id="add">
                                            <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" Width="250px"/></td>
                                        <td id="area">
                                            <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel"/></td>
                                        <td id="notes">
                                            <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel"/></td>
                                        <td id="HideC1" runat="server">
                                            <asp:Label Text='<%# Eval("Cycle1", "{0:MMM-dd}") %>' runat="server" ID="Cycle1Label"/></td>
                                        <td id="HideC2" runat="server">
                                            <asp:Label Text='<%# Eval("Cycle2", "{0:MMM-dd}") %>' runat="server" ID="Cycle2Label"/></td>
                                        <td id="HideC3" runat="server" >
                                            <asp:Label Text='<%# Eval("Cycle3", "{0:MMM-dd}") %>' runat="server" ID="Cycle3Label"/></td>
                                        <td id="HideC4" runat="server" >
                                            <asp:Label Text='<%# Eval("Cycle4", "{0:MMM-dd}") %>' runat="server" ID="Cycle4Label"/></td>
                                        <td id="HideC5" runat="server" >
                                            <asp:Label Text='<%# Eval("Cycle5", "{0:MMM-dd}") %>' runat="server" ID="Cycle5Label"/></td>
                                        <td id="HidePruning" runat="server">
                                            <asp:Label Text='<%# Eval("Pruning", "{0:MMM-dd}") %>' runat="server" ID="PruningLabel"/></td>
                                        <td id="HideMulching" runat="server">
                                            <asp:Label Text='<%# Eval("Mulching", "{0:MMM-dd}") %>' runat="server" ID="MulchingLabel"/></td>
                                        <td id="HidePlanting" runat="server">
                                            <asp:Label Text='<%# Eval("Planting", "{0:MMM-dd}") %>' runat="server" ID="PlantingLabel"/></td>
                                        <td id="HideUprooting" runat="server">
                                            <asp:Label Text='<%# Eval("Uprooting", "{0:MMM-dd}") %>' runat="server" ID="UprootingLabel"/></td>
                                        <td id="HideTrimming" runat="server">
                                            <asp:Label Text='<%# Eval("Trimming", "{0:MMM-dd}") %>' runat="server" ID="TrimmingLabel"/></td>
                                    </tr>
                                </AlternatingItemTemplate>

                                <ItemTemplate>
                                    <tr style="background-color: #FFFFFF; color: black;" class="cellPad">
                                        <td> <%# Container.DataItemIndex + 1%> </td>
                                        <td id="pin">
                                            <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel"/></td>
                                        <td id="comm">
                                            <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel"/></td>
                                        <td id="neigh">
                                            <asp:Label Text='<%# Eval("Neighbourhood") %>' runat="server" ID="NeighbourhoodLabel"/></td>
                                        <td id="add">
                                            <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" Width="250px"/></td>
                                        <td id="area">
                                            <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel"/></td>
                                        <td id="notes">
                                            <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel"/></td>
                                        <td id="HideC1" runat="server">
                                            <asp:Label Text='<%# Eval("Cycle1", "{0:MMM-dd}") %>' runat="server" ID="Cycle1Label"/></td>
                                        <td id="HideC2" runat="server">
                                            <asp:Label Text='<%# Eval("Cycle2", "{0:MMM-dd}") %>' runat="server" ID="Cycle2Label"/></td>
                                        <td id="HideC3" runat="server" >
                                            <asp:Label Text='<%# Eval("Cycle3", "{0:MMM-dd}") %>' runat="server" ID="Cycle3Label"/></td>
                                        <td id="HideC4" runat="server" >
                                            <asp:Label Text='<%# Eval("Cycle4", "{0:MMM-dd}") %>' runat="server" ID="Cycle4Label"/></td>
                                        <td id="HideC5" runat="server" >
                                            <asp:Label Text='<%# Eval("Cycle5", "{0:MMM-dd}") %>' runat="server" ID="Cycle5Label"/></td>
                                        <td id="HidePruning" runat="server">
                                            <asp:Label Text='<%# Eval("Pruning", "{0:MMM-dd}") %>' runat="server" ID="PruningLabel"/></td>
                                        <td id="HideMulching" runat="server">
                                            <asp:Label Text='<%# Eval("Mulching", "{0:MMM-dd}") %>' runat="server" ID="MulchingLabel"/></td>
                                        <td id="HidePlanting" runat="server">
                                            <asp:Label Text='<%# Eval("Planting", "{0:MMM-dd}") %>' runat="server" ID="PlantingLabel"/></td>
                                        <td id="HideUprooting" runat="server">
                                            <asp:Label Text='<%# Eval("Uprooting", "{0:MMM-dd}") %>' runat="server" ID="UprootingLabel"/></td>
                                        <td id="HideTrimming" runat="server">
                                            <asp:Label Text='<%# Eval("Trimming", "{0:MMM-dd}") %>' runat="server" ID="TrimmingLabel"/></td>
                                    </tr>
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <table runat="server">
                                        <tr runat="server">
                                            <td runat="server">
                                                <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; font-weight: normal; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                                    <tr runat="server" style="background-color: #DCDCDC; color: black;" class="routeListviewHeader">
                                                        <th runat="server" style="width:5px"></th>
                                                        <th runat="server" style="text-align: center; width: 70px;">Pin</th>
                                                        <th runat="server" style="text-align: center; width: 100px;">Community</th>
                                                        <th runat="server" style="text-align: center; width: 150px;">Neighbourhood</th>
                                                        <th runat="server" style="text-align: center; width: 200px;">Address</th>
                                                        <th runat="server" style="text-align: center; width: 50px;">Area</th>
                                                        <th runat="server" style="text-align: center; width: 300px;">Notes</th>
                                                        <th runat="server" class="cycleHeader" id="Cycle1">Cycle 1</th>
                                                        <th runat="server" class="cycleHeader" id="Cycle2">Cycle 2</th>
                                                        <th runat="server" class="cycleHeader" id="Cycle3">Cycle 3</th>
                                                        <th runat="server" class="cycleHeader" id="Cycle4">Cycle 4</th>
                                                        <th runat="server" class="cycleHeader" id="Cycle5">Cycle 5</th>
                                                        <th runat="server" style="text-align: center; width: 75px;" id="Pruning">Pruning</th>
                                                        <th runat="server" style="text-align: center; width: 80px;" id="Mulching">Mulching</th>
                                                        <th runat="server" style="text-align: center; width: 75px;" id="Planting">Planting</th>
                                                        <th runat="server" style="text-align: center; width: 80px;" id="Uprooting">Uprooting</th>
                                                        <th runat="server" style="text-align: center; width: 80px;" id="Trimming">Trimming</th>
                                                    </tr>
                                                    <tr runat="server" id="itemPlaceholder"></tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr runat="server">
                                            <td runat="server" style="text-align: center; background-color: white; font-family: Verdana, Arial, Helvetica, sans-serif; color: black">
                                                <asp:DataPager runat="server" ID="Route_DataPager" PageSize="20" PagedControlID="RouteListView" >
                                                    <Fields>
                                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                                    </Fields>
                                                </asp:DataPager>
                                            </td>
                                        </tr>
                                    </table>
                                </LayoutTemplate>
                            </asp:ListView>
                        </div>
                    </fieldset>
                </asp:View>
            </asp:MultiView>
        </div>
    </div>
  </div>

</asp:Content>
