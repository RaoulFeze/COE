<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Crews.aspx.cs" Inherits="COE_Application.Pages.CrewLeader.Crews" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:ListView ID="ListView1" runat="server" DataSourceID="ObjectDataSource1">
        <AlternatingItemTemplate>
            <tr style="">
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
                    <asp:Label Text='<%# Eval("Cycle1") %>' runat="server" ID="Cycle1Label" />
                </td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle2") %>' runat="server" ID="Cycle2Label" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle3") %>' runat="server" ID="Cycle3Label" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle4") %>' runat="server" ID="Cycle4Label" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle5") %>' runat="server" ID="Cycle5Label" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Pruning") %>' runat="server" ID="PruningLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Mulching") %>' runat="server" ID="MulchingLabel" /></td>
            </tr>
        </AlternatingItemTemplate>
        <EditItemTemplate>
            <tr style="">
                <td>
                    <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                    <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                </td>
                <td>
                    <asp:TextBox Text='<%# Bind("Pin") %>' runat="server" ID="PinTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Community") %>' runat="server" ID="CommunityTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Neighbourhood") %>' runat="server" ID="NeighbourhoodTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Address") %>' runat="server" ID="AddressTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Area") %>' runat="server" ID="AreaTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Notes") %>' runat="server" ID="NotesTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle1") %>' runat="server" ID="Cycle1TextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle2") %>' runat="server" ID="Cycle2TextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle3") %>' runat="server" ID="Cycle3TextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle4") %>' runat="server" ID="Cycle4TextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle5") %>' runat="server" ID="Cycle5TextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Pruning") %>' runat="server" ID="PruningTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Mulching") %>' runat="server" ID="MulchingTextBox" /></td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" style="">
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
                    <asp:TextBox Text='<%# Bind("Pin") %>' runat="server" ID="PinTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Community") %>' runat="server" ID="CommunityTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Neighbourhood") %>' runat="server" ID="NeighbourhoodTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Address") %>' runat="server" ID="AddressTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Area") %>' runat="server" ID="AreaTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Notes") %>' runat="server" ID="NotesTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle1") %>' runat="server" ID="Cycle1TextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle2") %>' runat="server" ID="Cycle2TextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle3") %>' runat="server" ID="Cycle3TextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle4") %>' runat="server" ID="Cycle4TextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Cycle5") %>' runat="server" ID="Cycle5TextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Pruning") %>' runat="server" ID="PruningTextBox" /></td>
                <td>
                    <asp:TextBox Text='<%# Bind("Mulching") %>' runat="server" ID="MulchingTextBox" /></td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="">
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
                    <asp:Label Text='<%# Eval("Cycle1") %>' runat="server" ID="Cycle1Label" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle2") %>' runat="server" ID="Cycle2Label" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle3") %>' runat="server" ID="Cycle3Label" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle4") %>' runat="server" ID="Cycle4Label" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle5") %>' runat="server" ID="Cycle5Label" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Pruning") %>' runat="server" ID="PruningLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Mulching") %>' runat="server" ID="MulchingLabel" /></td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table runat="server" id="itemPlaceholderContainer" style="" border="0">
                            <tr runat="server" style="">
                                <th runat="server">Pin</th>
                                <th runat="server">Community</th>
                                <th runat="server">Neighbourhood</th>
                                <th runat="server">Address</th>
                                <th runat="server">Area</th>
                                <th runat="server">Notes</th>
                                <th runat="server">Cycle1</th>
                                <th runat="server">Cycle2</th>
                                <th runat="server">Cycle3</th>
                                <th runat="server">Cycle4</th>
                                <th runat="server">Cycle5</th>
                                <th runat="server">Pruning</th>
                                <th runat="server">Mulching</th>
                            </tr>
                            <tr runat="server" id="itemPlaceholder"></tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style="">
                        <asp:DataPager runat="server" ID="DataPager1">
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
            <tr style="">
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
                    <asp:Label Text='<%# Eval("Cycle1") %>' runat="server" ID="Cycle1Label" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle2") %>' runat="server" ID="Cycle2Label" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle3") %>' runat="server" ID="Cycle3Label" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle4") %>' runat="server" ID="Cycle4Label" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Cycle5") %>' runat="server" ID="Cycle5Label" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Pruning") %>' runat="server" ID="PruningLabel" /></td>
                <td>
                    <asp:Label Text='<%# Eval("Mulching") %>' runat="server" ID="MulchingLabel" /></td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>
   
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="RouteTest" TypeName="COESystem.BLL.RouteController"></asp:ObjectDataSource>
</asp:Content>
