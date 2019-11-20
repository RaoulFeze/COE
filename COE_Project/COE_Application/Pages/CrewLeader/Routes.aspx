<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Routes.aspx.cs" Inherits="COE_Application.Pages.CrewLeader.Routes" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <uc1:MessageUserControl runat="server" id="MessageUserControl" />
    </div>
    <div class="row">
         <div class="routesHeader">
        <h1>
            <asp:Label ID="Yard" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="RouteType" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="Label1" runat="server" Text="Routes Inventory"></asp:Label>
        </h1>
    </div>
    </div>
   
    <div>
        <div class="col-md-2">
            <div class="searchBar">
                <asp:TextBox ID="SearchBox" runat="server" CssClass="searchBox"></asp:TextBox>
                <asp:LinkButton ID="SearchButton" runat="server" CssClass="SearchButtom"><span class="glyphicon glyphicon-search "></span></asp:LinkButton><br /><br />
            </div>
            <div class="routeControls">
                <asp:Button ID="RoutesA" runat="server" Text="Routes A" CssClass="button"/><br /><br />
                <asp:Button ID="RoutesB" runat="server" Text="Routes B"  CssClass="button"/><br /><br />
                <asp:Button ID="Grass" runat="server" Text="Grass"  CssClass="button"/><br /><br />
                <asp:Button ID="Reset" runat="server" Text="Reset"  CssClass="button"/>
            </div>
            
        </div>
        <div class="col-md-10">
            <asp:Repeater ID="Repeater1" runat="server" 
                          DataSourceID="RouteListODS"
                          ItemType="COESystem.Data.DTOs.RouteStatus">
                <ItemTemplate>
                    <%# Item.Pin %>
                    <%# Item.Community %>
                    <%# Item.Description %>
                    <%# Item.Address %>
                    <%# Item.Area %>
                    <%# Item.Notes %>
                    <asp:ListView ID="ListView1" runat="server"
                        ItemType="COESystem.Data.POCOs.SiteStatus"
                        DataSource='<%# Item.JobDone %>'>
                    </asp:ListView>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
    <asp:ObjectDataSource ID="RouteListODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="RouteStatus_List" TypeName="COESystem.BLL.RouteController">
        <SelectParameters>
            <asp:Parameter Name="season" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="yardId" Type="Int32"></asp:Parameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
