<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Crews.aspx.cs" Inherits="COE_Application.Pages.CrewLeader.Crews" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <div class="row">
        <uc1:MessageUserControl runat="server" id="MessageUserControl" />
    </div>
    <div class="routesHeader">
        <h1>Crews Assignment</h1>
        <asp:Label ID="YardID" runat="server" Text="" Visible="false"></asp:Label>
    </div>
 
    <div class="row">
        <div class="col-md-2">
            <asp:Label ID="AddCrewLabel" runat="server" Text=" Add Crew"></asp:Label>
            <asp:LinkButton ID="AddCrewLinkButton" runat="server">
                <span class="glyphicon glyphicon-plus"></span>
            </asp:LinkButton><br /><br />
            <asp:RadioButtonList ID="RadioButtonList1" runat="server"
                                 RepeatDirection="Vertical"
                                 RepeatLayout="Flow"
                                 Visible="false">
                <asp:ListItem Value="1">A Routes</asp:ListItem>
                <asp:ListItem Value="2">B Routes</asp:ListItem>
                <asp:ListItem Value="3">Grass Routes</asp:ListItem>
                <asp:ListItem Value="4">Planting Routes</asp:ListItem>
                <asp:ListItem Value="5">Watering Routes</asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div class="col-md-10">
            <asp:DropDownList ID="UnitsDDL" runat="server" DataSourceID="UnitListODS" DataTextField="UnitNumber" DataValueField="UnitID"></asp:DropDownList>
        </div>
    </div>
    <asp:ObjectDataSource ID="UnitListODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetUnits" TypeName="COESystem.BLL.RouteController">
        <SelectParameters>
            <asp:ControlParameter ControlID="YardID" PropertyName="Text" Name="yardId" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
