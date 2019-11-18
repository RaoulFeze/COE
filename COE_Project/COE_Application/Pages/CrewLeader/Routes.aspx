<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Routes.aspx.cs" Inherits="COE_Application.Pages.CrewLeader.Routes" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <uc1:MessageUserControl runat="server" id="MessageUserControl" />
    <div class="routesHeader">
        <asp:Label ID="Yard" runat="server" Text="Label"></asp:Label>
        <asp:Label ID="RouteType" runat="server" Text="Label"></asp:Label>
        <asp:Label ID="Label1" runat="server" Text="Routes Inventory"></asp:Label>
    </div>
    <div>
        <div class="sideControls">

        </div>
        <div class="">

        </div>
    </div>

</asp:Content>
