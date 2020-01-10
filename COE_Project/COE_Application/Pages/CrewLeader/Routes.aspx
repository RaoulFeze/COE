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
                <asp:MenuItem Text="Route Update" Value="4"></asp:MenuItem>
                <asp:MenuItem Text="History" Value="5"></asp:MenuItem>
                <asp:MenuItem Text="Statistics" Value="6"></asp:MenuItem>
            </Items>
        </asp:Menu>
        <div class="tabContents">
            <asp:MultiView ID="RoutesMultiView" runat="server" ActiveViewIndex="0">
                <asp:View ID="RouteA_View" runat="server">
                    <fieldset class="form-horizontal">
                        <div class="RouteAStyle">
                            <asp:ListView ID="RouteAListView" runat="server">
                                <AlternatingItemTemplate>
                                    <tr style="background-color: #E9E9E9; color: black;" class="cellPad">
                                        <td> <%# Container.DataItemIndex + 1%> </td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Neighbourhood") %>' runat="server" ID="NeighbourhoodLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Cycle1", "{0:MMM-dd}") %>' runat="server" ID="Cycle1Label" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Cycle2", "{0:MMM-dd}") %>' runat="server" ID="Cycle2Label" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Cycle3", "{0:MMM-dd}") %>' runat="server" ID="Cycle3Label" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Cycle4", "{0:MMM-dd}") %>' runat="server" ID="Cycle4Label" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Cycle5", "{0:MMM-dd}") %>' runat="server" ID="Cycle5Label" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Pruning", "{0:MMM-dd}") %>' runat="server" ID="PruningLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Mulching", "{0:MMM-dd}") %>' runat="server" ID="MulchingLabel" CssClass=" routeCell" /></td>
                                    </tr>
                                </AlternatingItemTemplate>

                                <ItemTemplate>
                                    <tr style="background-color: #FFFFFF; color: black;" class="cellPad">
                                        <td> <%# Container.DataItemIndex + 1%> </td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel" CssClass="routePin routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Neighbourhood") %>' runat="server" ID="NeighbourhoodLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel" CssClass="routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Cycle1", "{0:MMM-dd}") %>' runat="server" ID="Cycle1Label" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Cycle2", "{0:MMM-dd}") %>' runat="server" ID="Cycle2Label" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Cycle3", "{0:MMM-dd}") %>' runat="server" ID="Cycle3Label" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Cycle4", "{0:MMM-dd}") %>' runat="server" ID="Cycle4Label" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Cycle5", "{0:MMM-dd}") %>' runat="server" ID="Cycle5Label" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Pruning", "{0:MMM-dd}") %>' runat="server" ID="PruningLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Mulching", "{0:MMM-dd}") %>' runat="server" ID="MulchingLabel" CssClass=" routeCell" /></td>
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
                                                        <th runat="server" class="cycleHeader">Cycle 1</th>
                                                        <th runat="server" class="cycleHeader">Cycle 2</th>
                                                        <th runat="server" class="cycleHeader">Cycle 3</th>
                                                        <th runat="server" class="cycleHeader">Cycle 4</th>
                                                        <th runat="server" class="cycleHeader">Cycle 5</th>
                                                        <th runat="server" style="text-align: center; width: 75px;">Pruning</th>
                                                        <th runat="server" style="text-align: center; width: 80px;">Mulching</th>
                                                    </tr>
                                                    <tr runat="server" id="itemPlaceholder"></tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr runat="server">
                                            <td runat="server" style="text-align: center; background-color: white; font-family: Verdana, Arial, Helvetica, sans-serif; color: black">
                                                <asp:DataPager runat="server" ID="DataPager2" PagedControlID="RouteAListView" PageSize="20">
                                                    <Fields>
                                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                                        <asp:NumericPagerField></asp:NumericPagerField>
                                                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
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
                <asp:View ID="RouteB_View" runat="server">
                   <fieldset class="form-horizontal">
                       <div class="RouteAStyle">
                            <asp:ListView ID="RouteBListView" runat="server">
                                <AlternatingItemTemplate>
                                    <tr style="background-color: #E9E9E9; color: black;" class="cellPad">
                                        <td><%# Container.DataItemIndex + 1%> </td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Neighbourhood") %>' runat="server" ID="NeighbourhoodLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Cycle1", "{0:MMM-dd}") %>' runat="server" ID="Cycle1Label" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Cycle2", "{0:MMM-dd}") %>' runat="server" ID="Cycle2Label" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Pruning", "{0:MMM-dd}") %>' runat="server" ID="PruningLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Mulching", "{0:MMM-dd}") %>' runat="server" ID="MulchingLabel" CssClass=" routeCell" /></td>
                                    </tr>
                                </AlternatingItemTemplate>

                                <ItemTemplate>
                                    <tr style="background-color: #FFFFFF; color: black;" class="cellPad">
                                        <td><%# Container.DataItemIndex + 1%> </td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel" CssClass="routePin routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Neighbourhood") %>' runat="server" ID="NeighbourhoodLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel" CssClass="routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Cycle1", "{0:MMM-dd}") %>' runat="server" ID="Cycle1Label" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Cycle2", "{0:MMM-dd}") %>' runat="server" ID="Cycle2Label" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Pruning", "{0:MMM-dd}") %>' runat="server" ID="PruningLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Mulching", "{0:MMM-dd}") %>' runat="server" ID="MulchingLabel" CssClass=" routeCell" /></td>
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
                                                        <th runat="server" class="cycleHeader">Cycle 1</th>
                                                        <th runat="server" class="cycleHeader">Cycle 2</th>
                                                        <th runat="server" style="text-align: center; width: 75px;">Pruning</th>
                                                        <th runat="server" style="text-align: center; width: 80px;">Mulching</th>
                                                    </tr>
                                                    <tr runat="server" id="itemPlaceholder"></tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr runat="server">
                                            <td runat="server" style="text-align: center; background-color: white; font-family: Verdana, Arial, Helvetica, sans-serif; color: black">
                                                <asp:DataPager runat="server" ID="DataPager2" PagedControlID="RouteAListView" PageSize="20">
                                                    <Fields>
                                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                                        <asp:NumericPagerField></asp:NumericPagerField>
                                                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
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
                <asp:View ID="GrassView" runat="server">
                    <fieldset class="form-horizontal">
                        <div class="RouteAStyle">
                            <asp:ListView ID="GrassListView" runat="server">
                                <AlternatingItemTemplate>
                                    <tr style="background-color: #E9E9E9; color: black;" class="cellPad">
                                        <td><%# Container.DataItemIndex + 1%> </td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Neighbourhood") %>' runat="server" ID="NeighbourhoodLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Count") %>' runat="server" ID="Cycle1Label" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Date", "{0:MMM-dd}") %>' runat="server" ID="Cycle2Label" CssClass=" routeCell" /></td>
                                    </tr>
                                </AlternatingItemTemplate>

                                <ItemTemplate>
                                    <tr style="background-color: #FFFFFF; color: black;" class="cellPad">
                                        <td><%# Container.DataItemIndex + 1%> </td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel" CssClass="routePin routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Neighbourhood") %>' runat="server" ID="NeighbourhoodLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel" CssClass="routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Count") %>' runat="server" ID="Cycle1Label" CssClass=" routeCell" /></td>
                                        <td>
                                            <asp:Label Text='<%# Eval("Date", "{0:MMM-dd}") %>' runat="server" ID="Cycle2Label" CssClass=" routeCell" /></td>
                                    </tr>
                                </ItemTemplate>
                                <LayoutTemplate>
                                    <table runat="server">
                                        <tr runat="server">
                                            <td runat="server">
                                                <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; font-weight: normal; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                                    <tr runat="server" style="background-color: #DCDCDC; color: black;" class="routeListviewHeader">
                                                        <th runat="server" style="width: 5px"></th>
                                                        <th runat="server" style="text-align: center; width: 70px;">Pin</th>
                                                        <th runat="server" style="text-align: center; width: 100px;">Community</th>
                                                        <th runat="server" style="text-align: center; width: 150px;">Neighbourhood</th>
                                                        <th runat="server" style="text-align: center; width: 200px;">Address</th>
                                                        <th runat="server" style="text-align: center; width: 50px;">Area</th>
                                                        <th runat="server" style="text-align: center; width: 300px;">Notes</th>
                                                        <th runat="server" class="cycleHeader">Count</th>
                                                        <th runat="server" class="cycleHeader">Date</th>
                                                    </tr>
                                                    <tr runat="server" id="itemPlaceholder"></tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr runat="server">
                                            <td runat="server" style="text-align: center; background-color: white; font-family: Verdana, Arial, Helvetica, sans-serif; color: black">
                                                <asp:DataPager runat="server" ID="DataPager2" PagedControlID="RouteAListView" PageSize="20">
                                                    <Fields>
                                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
                                                        <asp:NumericPagerField></asp:NumericPagerField>
                                                        <asp:NextPreviousPagerField ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False"></asp:NextPreviousPagerField>
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
                <asp:View ID="View2" runat="server">
                   <fieldset class="form-horizontal">
                       <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource1">
                           <Columns>
                               <asp:BoundField DataField="Pin" HeaderText="Pin" SortExpression="Pin"></asp:BoundField>
                               <asp:BoundField DataField="Community" HeaderText="Community" SortExpression="Community"></asp:BoundField>
                               <asp:BoundField DataField="Neighbourhood" HeaderText="Neighbourhood" SortExpression="Neighbourhood"></asp:BoundField>
                               <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address"></asp:BoundField>
                               <asp:BoundField DataField="Area" HeaderText="Area" SortExpression="Area"></asp:BoundField>
                               <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes"></asp:BoundField>
                               <asp:BoundField DataField="Cycle1" HeaderText="Cycle1" SortExpression="Cycle1"></asp:BoundField>
                               <asp:BoundField DataField="Cycle2" HeaderText="Cycle2" SortExpression="Cycle2"></asp:BoundField>
                               <asp:BoundField DataField="Cycle3" HeaderText="Cycle3" SortExpression="Cycle3"></asp:BoundField>
                               <asp:BoundField DataField="Cycle4" HeaderText="Cycle4" SortExpression="Cycle4"></asp:BoundField>
                               <asp:BoundField DataField="Cycle5" HeaderText="Cycle5" SortExpression="Cycle5"></asp:BoundField>
                               <asp:BoundField DataField="Pruning" HeaderText="Pruning" SortExpression="Pruning"></asp:BoundField>
                               <asp:BoundField DataField="Mulching" HeaderText="Mulching" SortExpression="Mulching"></asp:BoundField>
                           </Columns>
                       </asp:GridView>
                   </fieldset>
                </asp:View>
            </asp:MultiView>
        </div>
    </div>
  </div>
   
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="RouteTest" TypeName="COESystem.BLL.RouteController"></asp:ObjectDataSource>

</asp:Content>
