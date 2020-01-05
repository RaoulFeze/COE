﻿<%@ Page Title="Routes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Routes.aspx.cs" Inherits="COE_Application.Pages.CrewLeader.Routes" %>

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
        <div class="col-md-2">
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
        </div>

        <div class="col-md-10">
            <asp:ListView ID="RouteAListView" runat="server" DataSourceID="ObjectDataSource1">
                <AlternatingItemTemplate>
                    <tr style="background-color: #E9E9E9; color: black;" class="cellPad">
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
                                <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; font-weight:normal; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                    <tr runat="server" style="background-color: #DCDCDC; color: black;" class="routeListviewHeader">
                                        <th runat="server" style="text-align: center; width: 70px;">Pin</th>
                                        <th runat="server" style="text-align: center; width: 100px;">Community</th>
                                        <th runat="server" style="text-align: center; width: 150px;">Neighbourhood</th>
                                        <th runat="server" style="text-align: center; width: 300px;">Address</th>
                                        <th runat="server" style="text-align: center; width: 50px;">Area</th>
                                        <th runat="server" style="text-align: center; width: 200px;">Notes</th>
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
    </div>
     <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="RouteTest" TypeName="COESystem.BLL.RouteController"></asp:ObjectDataSource>
   
</asp:Content>
