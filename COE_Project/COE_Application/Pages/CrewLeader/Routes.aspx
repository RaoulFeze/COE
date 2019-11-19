<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Routes.aspx.cs" Inherits="COE_Application.Pages.CrewLeader.Routes" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <uc1:MessageUserControl runat="server" id="MessageUserControl" />
    </div>
    
    <div class="routesHeader">
        <h1>
            <asp:Label ID="Yard" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="RouteType" runat="server" Text="Label"></asp:Label>
            <asp:Label ID="Label1" runat="server" Text="Routes Inventory"></asp:Label>
        </h1>
    </div>
    <div>
        <div class="col-md-2">
            <div class="searchBar">
                <asp:TextBox ID="SearchBox" runat="server" CssClass="searchBox"></asp:TextBox>
                <asp:LinkButton ID="SearchButton" runat="server" CssClass="SearchButtom"><span class="glyphicon glyphicon-search SearchButtom"></span></asp:LinkButton><br />
            </div>
            <div class="routeControls">
                <asp:Button ID="RoutesA" runat="server" Text="Routes A" /><br /><br />
                <asp:Button ID="RoutesB" runat="server" Text="Routes B" /><br /><br />
                <asp:Button ID="Grass" runat="server" Text="Grass" /><br /><br />
                <asp:Button ID="Reset" runat="server" Text="Reset" />
            </div>
            
        </div>
        <div class="col-md-10">

        </div>
    </div>

</asp:Content>
