<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Crews.aspx.cs" Inherits="COE_Application.Pages.CrewLeader.Crews" %>

<%@ Register Src="~/UserControls/MessageUserControl.ascx" TagPrefix="uc1" TagName="MessageUserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link href="../../Style/StyleSheet.css" rel="stylesheet" />
     <div class="row">
        <uc1:MessageUserControl runat="server" id="MessageUserControl" />
    </div>
    <div class="routesHeader">
        <asp:Label ID="YardID" runat="server" Text="" Visible="false"></asp:Label>
        <asp:Label ID="SiteType" runat="server" Text="" Visible="false" ></asp:Label>
        <asp:Label ID="CrewID" runat="server" Text="" Visible="false" ></asp:Label>
        
    </div>
 
    <div class="row">
        <div class="col-md-3">
            <asp:Label ID="AddCrewLabel" runat="server" Text="New Crew"></asp:Label>
            <asp:LinkButton ID="AddCrewLinkButton" runat="server" OnClick="AddCrewLinkButton_Click">
                <span class="glyphicon glyphicon-plus"></span>
            </asp:LinkButton><br />
            <br />
            <asp:Label ID="UnitLabel" runat="server" Text="Unit" Visible="false"></asp:Label>&nbsp;
            <asp:DropDownList ID="UnitsDDL" runat="server"
                OnSelectedIndexChanged="UnitsDDL_SelectedIndexChanged"
                AutoPostBack="true"
                Visible="false">
            </asp:DropDownList>
            <br />
            <br />
            <asp:RadioButtonList ID="RouteCategory" runat="server"
                RepeatDirection="Vertical"
                RepeatLayout="Flow"
                Visible="false"
                OnSelectedIndexChanged="RouteCategory_SelectedIndexChanged">
                <asp:ListItem Value="1">A Routes</asp:ListItem>
                <asp:ListItem Value="2">B Routes</asp:ListItem>
                <asp:ListItem Value="3">Grass Routes</asp:ListItem>
                <asp:ListItem Value="4">Watering Routes</asp:ListItem>
                <asp:ListItem Value="5">Planting Routes</asp:ListItem>
            </asp:RadioButtonList>
            <br />
            <br />
            <asp:Button ID="SelectSiteButton" runat="server" Text="Select Sites" Visible="false" OnClick="SelectSiteButton_Click" />
        </div>
        <div class="col-md-9">
            <%-- -------------------------------------------------------------EMPLOYEE LISTVIEW---------------------------------------------------------------- --%>
        <h1 style="text-align:center;"><asp:Label ID="Route" runat="server" Text="" Visible="false"></asp:Label></h1>
            <div >
                <asp:ListView ID="EmployeesListView" runat="server"
                    DataSourceID="EmployeeListODS"
                    Visible="false"
                    OnItemCommand="EmployeesListView_ItemCommand">
                    <AlternatingItemTemplate>
                        <tr style="background-color: #E9E9E9; color: black" class="crewRow">
                            <td><%# Container.DataItemIndex + 1%> </td>
                            <td>
                                <asp:Label Text='<%# Eval("Name") %>' runat="server" ID="NameLabel" /></td>
                            <td>
                                <asp:Label Text='<%# Eval("Phone") %>' runat="server" ID="PhoneLabel" /></td>
                            <td style="text-align: center">
                                <asp:LinkButton CommandArgument='<%# Eval("EmployeeID") %>' runat="server" ID="LinkButton1">
                                <span aria-hidden="true" class="glyphicon glyphicon-plus"></span>
                                </asp:LinkButton>
                            </td>
                        </tr>
                    </AlternatingItemTemplate>
                    <EmptyDataTemplate>
                        <table runat="server" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px;">
                            <tr>
                                <td><span style="color: firebrick;">A Unit must be selected before proceeding...</span></td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>

                    <ItemTemplate>
                        <tr style="background-color: #FFFFFF; color: black;" class="crewRow">

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
                                    <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; font-weight: normal; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
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
                                <td runat="server" style="text-align: center; background-color: #FFFFFF; padding-top: 5px; font-family: Verdana, Arial, Helvetica, sans-serif; color: #000000;">
                                    <asp:DataPager runat="server" ID="EmployeeDataPager" PagedControlID="EmployeesListView">
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
            <%-- ----------------------------------------------------------------ROUTE LISTVIEW-------------------------------------------------------------------------- --%>
            <asp:ListView ID="RouteListView" runat="server"
                Visible="true"
                OnItemCommand="RouteListView_ItemCommand">
                <AlternatingItemTemplate>
                    <tr style="background-color: #E9E9E9; color: black;" class="crewRow">
                        <td><%# Container.DataItemIndex + 1%> </td>
                        <td id="pin">
                            <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel" /></td>
                        <td id="comm">
                            <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel" /></td>
                        <td id="neigh">
                            <asp:Label Text='<%# Eval("Neighbourhood") %>' runat="server" ID="NeighbourhoodLabel" /></td>
                        <td id="add">
                            <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" Width="250px" /></td>
                        <td id="area">
                            <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel" /></td>
                        <td id="notes">
                            <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel" /></td>
                        <td id="HideC1" runat="server">
                            <asp:Label Text='<%# Eval("Cycle1", "{0:MMM-dd}") %>' runat="server" ID="Cycle1Label" /></td>
                        <td id="HideC2" runat="server">
                            <asp:Label Text='<%# Eval("Cycle2", "{0:MMM-dd}") %>' runat="server" ID="Cycle2Label" /></td>
                        <td id="HideC3" runat="server">
                            <asp:Label Text='<%# Eval("Cycle3", "{0:MMM-dd}") %>' runat="server" ID="Cycle3Label" /></td>
                        <td id="HideC4" runat="server">
                            <asp:Label Text='<%# Eval("Cycle4", "{0:MMM-dd}") %>' runat="server" ID="Cycle4Label" /></td>
                        <td id="HideC5" runat="server">
                            <asp:Label Text='<%# Eval("Cycle5", "{0:MMM-dd}") %>' runat="server" ID="Cycle5Label" /></td>
                        <td id="HidePlanting" runat="server">
                            <asp:Label Text='<%# Eval("Planting", "{0:MMM-dd}") %>' runat="server" ID="PlantingLabel" /></td>
                        <td id="HideUprooting" runat="server">
                            <asp:Label Text='<%# Eval("Uprooting", "{0:MMM-dd}") %>' runat="server" ID="UprootingLabel" /></td>
                        <td id="HideTrimming" runat="server">
                            <asp:Label Text='<%# Eval("Trimming", "{0:MMM-dd}") %>' runat="server" ID="TrimmingLabel" /></td>
                        <td style="text-align: center">
                            <asp:LinkButton runat="server" ID="LinkButton1" CommandArgument='<%# Eval("SiteID") %>'>
                                <span aria-hidden="true" class="glyphicon glyphicon-plus"></span>
                            </asp:LinkButton>
                        </td>
                    </tr>
                </AlternatingItemTemplate>

                <ItemTemplate>
                    <tr style="background-color: #FFFFFF; color: black;" class="crewRow">
                        <td><%# Container.DataItemIndex + 1%> </td>
                        <td id="pin">
                            <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel" /></td>
                        <td id="comm">
                            <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel" /></td>
                        <td id="neigh">
                            <asp:Label Text='<%# Eval("Neighbourhood") %>' runat="server" ID="NeighbourhoodLabel" /></td>
                        <td id="add">
                            <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" Width="250px" /></td>
                        <td id="area">
                            <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel" /></td>
                        <td id="notes">
                            <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel" /></td>
                        <td id="HideC1" runat="server">
                            <asp:Label Text='<%# Eval("Cycle1", "{0:MMM-dd}") %>' runat="server" ID="Cycle1Label" /></td>
                        <td id="HideC2" runat="server">
                            <asp:Label Text='<%# Eval("Cycle2", "{0:MMM-dd}") %>' runat="server" ID="Cycle2Label" /></td>
                        <td id="HideC3" runat="server">
                            <asp:Label Text='<%# Eval("Cycle3", "{0:MMM-dd}") %>' runat="server" ID="Cycle3Label" /></td>
                        <td id="HideC4" runat="server">
                            <asp:Label Text='<%# Eval("Cycle4", "{0:MMM-dd}") %>' runat="server" ID="Cycle4Label" /></td>
                        <td id="HideC5" runat="server">
                            <asp:Label Text='<%# Eval("Cycle5", "{0:MMM-dd}") %>' runat="server" ID="Cycle5Label" /></td>

                        <td id="HidePlanting" runat="server">
                            <asp:Label Text='<%# Eval("Planting", "{0:MMM-dd}") %>' runat="server" ID="PlantingLabel" /></td>
                        <td id="HideUprooting" runat="server">
                            <asp:Label Text='<%# Eval("Uprooting", "{0:MMM-dd}") %>' runat="server" ID="UprootingLabel" /></td>
                        <td id="HideTrimming" runat="server">
                            <asp:Label Text='<%# Eval("Trimming", "{0:MMM-dd}") %>' runat="server" ID="TrimmingLabel" /></td>
                        <td style="text-align: center">
                            <asp:LinkButton runat="server" ID="LinkButton1" CommandArgument='<%# Eval("SiteID") %>'>
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
                                        <th runat="server" class="cycleHeader" id="Cycle1">Cycle 1</th>
                                        <th runat="server" class="cycleHeader" id="Cycle2">Cycle 2</th>
                                        <th runat="server" class="cycleHeader" id="Cycle3">Cycle 3</th>
                                        <th runat="server" class="cycleHeader" id="Cycle4">Cycle 4</th>
                                        <th runat="server" class="cycleHeader" id="Cycle5">Cycle 5</th>
                                        <th runat="server" style="text-align: center; width: 75px;" id="Planting">Planting</th>
                                        <th runat="server" style="text-align: center; width: 80px;" id="Uprooting">Uprooting</th>
                                        <th runat="server" style="text-align: center; width: 80px;" id="Trimming">Trimming</th>
                                        <th runat="server" style="text-align: center; width: 80px;">Add</th>
                                    </tr>
                                    <tr runat="server" id="itemPlaceholder"></tr>
                                </table>
                            </td>
                        </tr>
                        <tr runat="server">
                            <td runat="server" style="text-align: center; background-color: white; font-family: Verdana, Arial, Helvetica, sans-serif; color: black">
                                <asp:DataPager runat="server" ID="Route_DataPager" PageSize="10" PagedControlID="RouteListView">
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
    <div class="row">
        <%-- -----------------------------------------------------------------------------CREW & SITES---------------------------------------------------------------------------- --%>
        <asp:Repeater ID="CrewRepeater" runat="server"
            ItemType="COESystem.Data.DTOs.CurrentCrew" 
            OnItemCommand="CrewRepeater_ItemCommand">
            <ItemTemplate>
                <div class="repeater col-sm-3">
                    <h5>
                        <strong>Unit:
                            <asp:LinkButton ID="SelectCrewLinkButton" runat="server" CommandArgument='<%# Item.CrewID %>' CommandName="SelectCrew"> 
                                    <%# Item.Unit %> 
                             </asp:LinkButton>
                        </strong>
                        &nbsp;&nbsp;
                        <asp:LinkButton ID="RemoveCrew" runat="server" CommandArgument='<%# Item.CrewID %>' CommandName="DeleteCrew" OnClientClick="return ConfirmRemoveCrew()">
                        <span aria-hidden="true" class="glyphicon glyphicon-remove" ></span> 
                        </asp:LinkButton>
                    </h5>
                    <div class="CrewGridContainer">
                        <div class="CrewContainer">
    <%-- --------------------------------------------------------------------------------CREW MEMBERS--------------------------------------------------------------------------- --%>
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
                                            <asp:LinkButton ID="RemoveEmployee" runat="server" CommandArgument='<%# Eval("CrewMemberID") %>' CommandName="DeleteMember" OnClientClick="return ConfirmRemoveEmployee()">
                                                <span aria-hidden="true" class="glyphicon glyphicon-remove" ></span>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                        <div class="SiteContainer">
        <%-- --------------------------------------------------------------SITES----------------------------------------------------------------------------------------------- --%>
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
                                            <asp:LinkButton ID="RemoveSite" runat="server" CommandArgument='<%# Eval("SiteID") %>'  CommandName="DeleteSite" OnClientClick="return ConfirmRemoveSite()">
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
    <script>
        function ConfirmRemoveEmployee() {
            return confirm("Please confirm you want to remove the selected employee from the current crew");
        }
        function ConfirmRemoveSite() {
            return confirm("Do you want to remove the selected site from the current crew?");
        }
        function ConfirmRemoveCrew() {
            return confirm("You are about to delete the selected Crew including which includes crew members and the assigned job sites. Please confirm.");
        }
    </script>
</asp:Content>
