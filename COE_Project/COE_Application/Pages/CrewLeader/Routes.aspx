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
                <asp:Button ID="RoutesA" runat="server" Text="Routes A" CssClass="button" OnClick="RoutesA_Click"/><br /><br />
                <asp:Button ID="RoutesB" runat="server" Text="Routes B"  CssClass="button" OnClick="RoutesB_Click"/><br /><br />
                <asp:Button ID="Grass" runat="server" Text="Grass"  CssClass="button" OnClick="Grass_Click"/><br /><br />
                <asp:Button ID="Reset" runat="server" Text="Reset"  CssClass="button" OnClick="Reset_Click"/>
            </div>
            </div>
           
            
           </div>
        
        <div >
          <asp:ListView ID="RouteAListView" runat="server" DataSourceID="ObjectDataSource1">
        <AlternatingItemTemplate>
            <tr style="background-color: #FFFFFF; color: #284775;">
                <td>
                    <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel" CssClass="routePin"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel" CssClass="routeCommunity"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Neighbourhood") %>' runat="server" ID="NeighbourhoodLabel" CssClass="neighbourhood" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" CssClass="routeAddress"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel" CssClass="routeArea"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel" CssClass="routeNotes"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle1", "{0:MMM-dd}") %>' runat="server" ID="Cycle1Label" CssClass="routeDate" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle2", "{0:MMM-dd}") %>' runat="server" ID="Cycle2Label"  CssClass="routeDate"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle3", "{0:MMM-dd}") %>' runat="server" ID="Cycle3Label" CssClass="routeDate"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle4", "{0:MMM-dd}") %>' runat="server" ID="Cycle4Label" CssClass="routeDate"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle5", "{0:MMM-dd}") %>' runat="server" ID="Cycle5Label" CssClass="routeDate"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Pruning", "{0:MMM-dd}") %>' runat="server" ID="PruningLabel" CssClass="routeDate"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Mulching", "{0:MMM-dd}") %>' runat="server" ID="MulchingLabel" CssClass="routeDate"/></td>
            </tr>
        </AlternatingItemTemplate>
        <EditItemTemplate>
            <tr style="background-color: #999999;">
                <td>
                    <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                    <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                </td>
                <td>
                    <asp:TextBox Text='<%# Bind("Pin") %>' runat="server" ID="PinTextBox" CssClass="routePin"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Community") %>' runat="server" ID="CommunityTextBox" CssClass="routeCommunity"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Neighbourhood") %>' runat="server" ID="NeighbourhoodTextBox" CssClass="routeNeighbourhood"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Address") %>' runat="server" ID="AddressTextBox" CssClass="routeAddress"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Area") %>' runat="server" ID="AreaTextBox" CssClass="routeArea"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Notes", "{0:MMM-dd}") %>' runat="server" ID="NotesTextBox" CssClass="routeNotes"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle1", "{0:MMM-dd}") %>' runat="server" ID="Cycle1TextBox" CssClass="routeDate"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle2", "{0:MMM-dd}") %>' runat="server" ID="Cycle2TextBox" CssClass="routeDate"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle3", "{0:MMM-dd}") %>' runat="server" ID="Cycle3TextBox" CssClass="routeDate"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle4", "{0:MMM-dd}") %>' runat="server" ID="Cycle4TextBox" CssClass="routeDate" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle5", "{0:MMM-dd}") %>' runat="server" ID="Cycle5TextBox" CssClass="routeDate"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Pruning", "{0:MMM-dd}") %>' runat="server" ID="PruningTextBox" CssClass="routeDate"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Mulching", "{0:MMM-dd}") %>' runat="server" ID="MulchingTextBox" CssClass="routeDate"/></td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style="">
                <td>
                    <asp:Button runat="server" CommandName="Insert" Text="Insert" ID="InsertButton" />
                    <asp:Button runat="server" CommandName="Cancel" Text="Clear" ID="CancelButton" />
                </td>
                <td>
                    <asp:TextBox Text='<%# Bind("Pin") %>' runat="server" ID="PinTextBox" CssClass="routePin"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Community") %>' runat="server" ID="CommunityTextBox" CssClass="routeCommunity"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Neighbourhood") %>' runat="server" ID="NeighbourhoodTextBox" CssClass="routeNeighbourhood"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Address") %>' runat="server" ID="AddressTextBox" CssClass="routeAddress"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Area") %>' runat="server" ID="AreaTextBox" CssClass="routeArea"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Notes") %>' runat="server" ID="NotesTextBox" CssClass="routeNotes"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle1", "{0:MMM-dd}") %>' runat="server" ID="Cycle1TextBox" CssClass="routeDate"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle2", "{0:MMM-dd}") %>' runat="server" ID="Cycle2TextBox" CssClass="routeDate"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle3", "{0:MMM-dd}") %>' runat="server" ID="Cycle3TextBox" CssClass="routeDate"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle4", "{0:MMM-dd}") %>' runat="server" ID="Cycle4TextBox" CssClass="routeDate"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle5", "{0:MMM-dd}") %>' runat="server" ID="Cycle5TextBox" CssClass="routeDate"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Pruning", "{0:MMM-dd}") %>' runat="server" ID="PruningTextBox" CssClass="routeDate"/></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Mulching", "{0:MMM-dd}") %>' runat="server" ID="MulchingTextBox" CssClass="routeDate"/></td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="background-color: #E0FFFF; color: #333333;">
                <td>
                    <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel" CssClass="routePin"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel" CssClass="routeCommunity"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Neighbourhood") %>' runat="server" ID="NeighbourhoodLabel" CssClass="routeNeighbourhood"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" CssClass="routeAddress"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel" CssClass="routeArea"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel" CssClass="routeNotes"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle1", "{0:MMM-dd}") %>' runat="server" ID="Cycle1Label" CssClass="routeDate"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle2", "{0:MMM-dd}") %>' runat="server" ID="Cycle2Label" CssClass="routeDate"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle3", "{0:MMM-dd}") %>' runat="server" ID="Cycle3Label" CssClass="routeDate"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle4", "{0:MMM-dd}") %>' runat="server" ID="Cycle4Label" CssClass="routeDate"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle5", "{0:MMM-dd}") %>' runat="server" ID="Cycle5Label" CssClass="routeDate"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Pruning", "{0:MMM-dd}") %>' runat="server" ID="PruningLabel" CssClass="routeDate"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Mulching", "{0:MMM-dd}") %>' runat="server" ID="MulchingLabel" CssClass="routeDate"/></td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                            <tr runat="server" style="background-color: #E0FFFF; color: #333333;" class="routeListviewHeader">
                                <th runat="server" style="text-align:center; width:70px;">Pin</th>
                                <th runat="server" style="text-align:center; width:100px;">Community</th>
                                <th runat="server" style="text-align:center; width:150px;">Neighbourhood</th>
                                <th runat="server" style="text-align:center;">Address</th>
                                <th runat="server" style="text-align:center; width:50px;">Area</th>
                                <th runat="server" style="text-align:center; width:200px;">Notes</th>
                                <th runat="server" class="cycleHeader">Cycle 1</th>
                                <th runat="server" class="cycleHeader">Cycle 2</th>
                                <th runat="server" class="cycleHeader">Cycle 3</th>
                                <th runat="server" class="cycleHeader">Cycle 4</th>
                                <th runat="server" class="cycleHeader">Cycle 5</th>
                                <th runat="server">Pruning</th>
                                <th runat="server">Mulching</th>
                            </tr>
                            <tr runat="server" id="itemPlaceholder"></tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF">
                        <asp:DataPager runat="server" ID="DataPager2">
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
        <SelectedItemTemplate>
            <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                <td>
                    <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel" CssClass="routePin"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel" CssClass="routeCommunity" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Neighbourhood") %>' runat="server" ID="NeighbourhoodLabel" CssClass="routeNeighbourhood"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" CssClass="routeAddress"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel" CssClass="routeArea"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel" CssClass="routeNotes"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle1", "{0:MMM-dd}") %>' runat="server" ID="Cycle1Label" CssClass="routeDate"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle2", "{0:MMM-dd}") %>' runat="server" ID="Cycle2Label" CssClass="routeDate"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle3", "{0:MMM-dd}") %>' runat="server" ID="Cycle3Label" CssClass="routeDate"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle4", "{0:MMM-dd}") %>' runat="server" ID="Cycle4Label" CssClass="routeDate"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle5", "{0:MMM-dd}") %>' runat="server" ID="Cycle5Label" CssClass="routeDate"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Pruning", "{0:MMM-dd}") %>' runat="server" ID="PruningLabel" CssClass="routeDate"/></td>
                <td>
                    <asp:Label Text='<%# Eval("Mulching", "{0:MMM-dd}") %>' runat="server" ID="MulchingLabel" CssClass="routeDate"/></td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>
        </div>
    </div>
     <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="RouteTest" TypeName="COESystem.BLL.RouteController"></asp:ObjectDataSource>
   
</asp:Content>
