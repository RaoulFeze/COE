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
        <asp:Label ID="SiteType" runat="server" Text="" Visible="false" ></asp:Label>
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
            <br /><br />
            <asp:Button ID="SelectSiteButton" runat="server" Text="Select Sites" Visible="false" OnClick="SelectSiteButton_Click" />
            <asp:Label ID="Test" runat="server" Text=""></asp:Label>
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
                                <asp:DataPager runat="server" ID="EmployeeDataPager" PagedControlID="EmployeesListView" >
                                    <Fields>
                                        <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True"></asp:NextPreviousPagerField>
                                    </Fields>
                                </asp:DataPager>
                            </td>
                        </tr>
                    </table>
                </LayoutTemplate>
            </asp:ListView>
            <asp:ListView ID="RouteAListView" runat="server" DataSourceID="RouteODS" Visible="true">
                <AlternatingItemTemplate>
                    <tr style="background-color: #E9E9E9; color: black;" class="cellPad">
                        <td><%# Container.DataItemIndex + 1%> </td>
                        <td>
                            <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Neighbourhood") %>' runat="server" ID="NeighbourhoodLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Cycle1", "{0:MMM-dd}") %>' runat="server" ID="Cycle1Label" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Cycle2", "{0:MMM-dd}") %>' runat="server" ID="Cycle2Label" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Cycle3", "{0:MMM-dd}") %>' runat="server" ID="Cycle3Label" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Cycle4", "{0:MMM-dd}") %>' runat="server" ID="Cycle4Label" /></td>
                        <td>
                        <td style="text-align: center">
                            <asp:LinkButton runat="server" ID="LinkButton1">
                                <span aria-hidden="true" class="glyphicon glyphicon-plus"></span>
                            </asp:LinkButton>
                        </td>
                    </tr>
                </AlternatingItemTemplate>

                <ItemTemplate>
                    <tr style="background-color: #FFFFFF; color: black;" class="cellPad">
                        <td><%# Container.DataItemIndex + 1%> </td>
                        <td>
                            <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Neighbourhood") %>' runat="server" ID="NeighbourhoodLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Cycle1", "{0:MMM-dd}") %>' runat="server" ID="Cycle1Label" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Cycle2", "{0:MMM-dd}") %>' runat="server" ID="Cycle2Label" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Cycle3", "{0:MMM-dd}") %>' runat="server" ID="Cycle3Label" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Cycle4", "{0:MMM-dd}") %>' runat="server" ID="Cycle4Label" /></td>
                        <td>
                            <asp:Label Text='<%# Eval("Cycle5", "{0:MMM-dd}") %>' runat="server" ID="Cycle5Label" /></td>
                        <td style="text-align: center">
                            <asp:LinkButton runat="server" ID="LinkButton1">
                                <span aria-hidden="true" class="glyphicon glyphicon-plus"></span>
                            </asp:LinkButton>
                        </td>
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
                                        <th runat="server" class="cycleHeader">Cycle 1</th>
                                        <th runat="server" class="cycleHeader">Cycle 2</th>
                                        <th runat="server" class="cycleHeader">Cycle 3</th>
                                        <th runat="server" class="cycleHeader">Cycle 4</th>
                                        <th runat="server" class="cycleHeader">Cycle 5</th>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style="text-align: center; background-color: white; font-family: Verdana, Arial, Helvetica, sans-serif; color: black">
                                <asp:DataPager runat="server" ID="RouteA_DataPager" PageSize="10" PagedControlID="RouteAListView">
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
                    <h5>
                        <strong>Unit:<asp:LinkButton ID="SelectCrewLinkButton" runat="server" CommandArgument='<%# Item.UnitID %>' CommandName="SelectCrew"> <%# Item.Unit %></asp:LinkButton></strong>
                        &nbsp;&nbsp;
                        <asp:LinkButton ID="RemoveCrew" runat="server" CommandArgument='<%# Item.UnitID %>' CommandName="DeleteCrew">
                        <span aria-hidden="true" class="glyphicon glyphicon-remove" ></span> 
                        </asp:LinkButton>
                    </h5>
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
                                            <asp:LinkButton ID="RemoveEmployee" runat="server" CommandArgument='<%# Eval("CrewMemberID") %>' CommandName="DeleteMember" >
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
                                            <asp:LinkButton ID="RemoveEmployee" runat="server" CommandArgument='<%# Eval("SiteID") %>'  CommandName="DeleteSite">
                                                <span aria-hidden="true" class="glyphicon glyphicon-remove" ></span>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
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
    <asp:ObjectDataSource ID="RouteODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="RouteList" TypeName="COESystem.BLL.RouteController">
        <SelectParameters>
            <asp:ControlParameter ControlID="YardID" PropertyName="Text" Name="yardId" Type="Int32"></asp:ControlParameter>
            <asp:ControlParameter ControlID="SiteType" PropertyName="Text" Name="siteTypeId" Type="Int32"></asp:ControlParameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
