<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Crews.aspx.cs" Inherits="COE_Application.Pages.CrewLeader.Crews" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../../Style/StyleSheet.css" rel="stylesheet" />
     <div class="row">
        <uc1:MessageUserControl runat="server" id="MessageUserControl" />
    </div>
    <div class="routesHeader">
        <h1>Crews Assignment</h1>
        <asp:Label ID="YardID" runat="server" Text="" Visible="false"></asp:Label>
    </div>
 
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="AddCrewLabel" runat="server" Text="New Crew"></asp:Label>
            <asp:LinkButton ID="AddCrewLinkButton" runat="server" OnClick="AddCrewLinkButton_Click">
                <span class="glyphicon glyphicon-plus"></span>
            </asp:LinkButton><br /><br />
            <asp:Label ID="UnitLabel" runat="server" Text="Unit" Visible="false"></asp:Label>&nbsp;
            <asp:DropDownList ID="UnitsDDL" runat="server" 
                              OnSelectedIndexChanged ="UnitsDDL_SelectedIndexChanged"
                              AutoPostBack="true"
                              Visible="false"></asp:DropDownList>
            <br /><br />
            <asp:RadioButtonList ID="RouteCategory" runat="server"
                                 RepeatDirection="Vertical"
                                 RepeatLayout="Flow"
                                 Visible="false" 
                                 OnSelectedIndexChanged="RouteCategory_SelectedIndexChanged">
                <asp:ListItem Value="1">A Routes</asp:ListItem>
                <asp:ListItem Value="2">B Routes</asp:ListItem>
                <asp:ListItem Value="3">Grass Routes</asp:ListItem>
                <asp:ListItem Value="4">Planting Routes</asp:ListItem>
                <asp:ListItem Value="5">Watering Routes</asp:ListItem>
            </asp:RadioButtonList>
        </div>
        <div class="col-md-9">

            <asp:ListView ID="EmployeesListView" runat="server" 
                DataSourceID="EmployeeListODS" 
                Visible="false"
                OnItemCommand="EmployeesListView_ItemCommand">
                <AlternatingItemTemplate>
                    <tr style="background-color: #E9E9E9; color:black" class="crewRow">
                        <td><%# Container.DataItemIndex + 1%> </td>
                        <td>
                            <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Phone") %>' runat="server" ID="PhoneLabel" /></td>
                        <td style="text-align: center">
                            <asp:LinkButton CommandArgument='<%# Eval("EmployeeID") %>' runat="server" ID="LinkButton1">
                                <span aria-hidden="true" class="glyphicon glyphicon-plus"></span>
                            </asp:LinkButton></td>
                    </tr>
                </AlternatingItemTemplate>
                <EmptyDataTemplate>
                    <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                        <tr>
                            <td><span style="color:firebrick;">A Unit must be selected before proceeding...</span></td>
                        </tr>
                    </table>
                </EmptyDataTemplate>
                
                <ItemTemplate>
                    <tr style="background-color: #FFFFFF; color: black;"class="crewRow">

                        <td><%# Container.DataItemIndex + 1%> </td>
                        <td>
                            <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="LastNameLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Phone") %>' runat="server" ID="PhoneLabel" /></td>
                        <td style="text-align: center">
                            <asp:LinkButton CommandArgument='<%# Eval("EmployeeID") %>' runat="server" ID="EmployeeIDLabel">
                                <span aria-hidden="true" class="glyphicon glyphicon-plus"></span>
                            </asp:LinkButton></td>
                    </tr>
                </ItemTemplate>
                <LayoutTemplate>
                    <table runat="server">
                        <tr runat="server">
                            <td runat="server">
                                <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none;  font-weight: normal; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                    <tr runat="server" style="background-color: #DCDCDC; color: #000000;" class="crewRow">
                                        <th runat="server"></th>
                                        <th runat="server">Name</th>
                                        <th runat="server">Phone</th>
                                        <th runat="server">Add to Crew</th>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style="text-align: center; background-color: #FFFFFF;  padding-top:5px; font-family: Verdana, Arial, Helvetica, sans-serif; color: #000000;">
                                <asp:DataPager runat="server" ID="DataPager1">
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
    </div>
    <br />
    <div class="row">
        <asp:Repeater ID="CrewRepeater" runat="server"
            ItemType="COESystem.Data.DTOs.CurrentCrew" 
            OnItemCommand="CrewRepeater_ItemCommand">
            <ItemTemplate>
                <div class="repeater col-sm-3">
                    <h5><strong>Unit: <%# Item.Unit %></strong></h5>
                    <div class="CrewGridContainer">
                        <div class="CrewContainer">
                            <asp:GridView ID="CrewMemberGridView" runat="server"
                                AutoGenerateColumns="false"
                                CssClass="table"
                                BorderWidth="0"
                                GridLines="None"
                                DataSource="<%# Item.Crew %>">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Name">
                                        <ItemTemplate>
                                            <asp:Label ID="Name" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Driver" ControlStyle-CssClass="CrewMemberCell">
                                        <ItemTemplate>
                                            <%--<asp:RadioButton ID="SelectedDriver" runat="server" Checked='<%# Eval("Driver") %>' Enabled="false" />--%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="RemoveEmployee" runat="server" CommandArgument='<%# Eval("CrewMemberID") %>'>
                                                <span aria-hidden="true" class="glyphicon glyphicon-remove" ></span>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                        <div class="SiteContainer">
                            <asp:GridView ID="WorkSiteGridView" runat="server"
                                AutoGenerateColumns="false"
                                CssClass="table"
                                BorderWidth="0"
                                GridLines="None"
                                DataSource="<%# Item.Sites %>">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <%# Container.DataItemIndex + 1%>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Sites (Pin)">
                                        <ItemTemplate>
                                            <asp:Label ID="Name" runat="server" Text='<%# Eval("Pin") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="RemoveEmployee" runat="server" CommandArgument='<%# Eval("SiteID") %>'>
                                                <span aria-hidden="true" class="glyphicon glyphicon-remove" ></span>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                             <asp:Button ID="UpdateSiteButton" runat="server" Text="Update" />
                        </div>
                    </div>


                    &nbsp;&nbsp;&nbsp;&nbsp;
                </div>
            </ItemTemplate>
        </asp:Repeater>

        
    </div>
    <asp:ObjectDataSource ID="EmployeeListODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="GetEmployees" TypeName="COESystem.BLL.CrewLeaderControllers.EmployeeControllers">
        <SelectParameters>
            <asp:ControlParameter ControlID="YardID" PropertyName="Text" Name="yardId" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
