<%@ Page Title="Routes" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Routes.aspx.cs" Inherits="COE_Application.Pages.CrewLeader.Routes" %>

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
           <div class="input-group">
               <asp:TextBox ID="SearchBox" runat="server" CssClass="SearchBox" PlaceHolder="Enter Pin/Community"></asp:TextBox>
               <asp:LinkButton ID="LinkButton1" runat="server" CssClass="input-group-append input-group-addon">
                   <span class="glyphicon glyphicon-search "></span>
               </asp:LinkButton>
            </div>
               <br />
            <div class="routeControls">
                <asp:Button ID="RoutesA" runat="server" Text="Routes A" CssClass="button"/><br /><br />
                <asp:Button ID="RoutesB" runat="server" Text="Routes B"  CssClass="button"/><br /><br />
                <asp:Button ID="Grass" runat="server" Text="Grass"  CssClass="button"/><br /><br />
                <asp:Button ID="Reset" runat="server" Text="Reset"  CssClass="button"/>
            </div>
            
           </div>
        
        <div class="col-md-10">
           <asp:ListView ID="ListView1" runat="server" DataSourceID="RouteListODS">
                       <AlternatingItemTemplate>
                           <tr style="background-color: #FFFFFF; color: #284775;">
                               <td>
                                   <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel" /></td>
                               <td>
                                   <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel" /></td>
                               <td>
                                   <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                               <td>
                                   <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" /></td>
                               <td>
                                   <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel" /></td>
                               <td>
                                   <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel" /></td>
                               <td>
                                  
                                   <asp:GridView ID="GridView1" runat="server"
                                       DataSource='<%# Eval("JobDone") %>'></asp:GridView>
                                   
                               </td>
                               
                           </tr>
                       </AlternatingItemTemplate>
                       <EditItemTemplate>
                           <tr style="background-color: #999999;">
                               <td>
                                   <asp:Button runat="server" CommandName="Update" Text="Update" ID="UpdateButton" />
                                   <asp:Button runat="server" CommandName="Cancel" Text="Cancel" ID="CancelButton" />
                               </td>
                               <td>
                                   <asp:TextBox Text='<%# Bind("Pin") %>' runat="server" ID="PinTextBox" /></td>
                               <td>
                                   <asp:TextBox Text='<%# Bind("Community") %>' runat="server" ID="CommunityTextBox" /></td>
                               <td>
                                   <asp:TextBox Text='<%# Bind("Description") %>' runat="server" ID="DescriptionTextBox" /></td>
                               <td>
                                   <asp:TextBox Text='<%# Bind("Address") %>' runat="server" ID="AddressTextBox" /></td>
                               <td>
                                   <asp:TextBox Text='<%# Bind("Area") %>' runat="server" ID="AreaTextBox" /></td>
                               <td>
                                   <asp:TextBox Text='<%# Bind("Notes") %>' runat="server" ID="NotesTextBox" /></td>
                               <td>
                                  
                                   <asp:GridView ID="GridView1" runat="server"
                                       DataSource='<%# Eval("JobDone") %>'></asp:GridView></td>
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
                                   <asp:TextBox Text='<%# Bind("Pin") %>' runat="server" ID="PinTextBox" /></td>
                               <td>
                                   <asp:TextBox Text='<%# Bind("Community") %>' runat="server" ID="CommunityTextBox" /></td>
                               <td>
                                   <asp:TextBox Text='<%# Bind("Description") %>' runat="server" ID="DescriptionTextBox" /></td>
                               <td>
                                   <asp:TextBox Text='<%# Bind("Address") %>' runat="server" ID="AddressTextBox" /></td>
                               <td>
                                   <asp:TextBox Text='<%# Bind("Area") %>' runat="server" ID="AreaTextBox" /></td>
                               <td>
                                   <asp:TextBox Text='<%# Bind("Notes") %>' runat="server" ID="NotesTextBox" /></td>
                               <td>
                              
                                   <asp:GridView ID="GridView1" runat="server"
                                       DataSource='<%# Eval("JobDone") %>'></asp:GridView></td>
                           </tr>
                       </InsertItemTemplate>
                       <ItemTemplate>
                           <tr style="background-color: #E0FFFF; color: #333333;">
                               <td>
                                   <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel" /></td>
                               <td>
                                   <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel" /></td>
                               <td>
                                   <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                               <td>
                                   <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" /></td>
                               <td>
                                   <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel" /></td>
                               <td>
                                   <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel" /></td>
                               <td>
                                
                                   <asp:GridView ID="GridView1" runat="server"
                                       DataSource='<%# Eval("JobDone") %>'></asp:GridView>
                               </td>
                           </tr>
                       </ItemTemplate>
                       <LayoutTemplate>
                           <table runat="server">
                               <tr runat="server">
                                   <td runat="server">
                                       <table runat="server" id="itemPlaceholderContainer" style="background-color: #FFFFFF; border-collapse: collapse; border-color: #999999; border-style: none; border-width: 1px; font-family: Verdana, Arial, Helvetica, sans-serif;" border="1">
                                           <tr runat="server" style="background-color: #E0FFFF; color: #333333;">
                                               <th runat="server">Pin</th>
                                               <th runat="server">Community</th>
                                               <th runat="server">Description</th>
                                               <th runat="server">Address</th>
                                               <th runat="server">Area</th>
                                               <th runat="server">Notes</th>
                                               <th runat="server">JobDone</th>
                                           </tr>
                                           <tr runat="server" id="itemPlaceholder"></tr>
                                       </table>
                                   </td>
                               </tr>
                               <tr runat="server">
                                   <td runat="server" style="text-align: center; background-color: #5D7B9D; font-family: Verdana, Arial, Helvetica, sans-serif; color: #FFFFFF">
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
                           <tr style="background-color: #E2DED6; font-weight: bold; color: #333333;">
                               <td>
                                   <asp:Label Text='<%# Eval("Pin") %>' runat="server" ID="PinLabel" /></td>
                               <td>
                                   <asp:Label Text='<%# Eval("Community") %>' runat="server" ID="CommunityLabel" /></td>
                               <td>
                                   <asp:Label Text='<%# Eval("Description") %>' runat="server" ID="DescriptionLabel" /></td>
                               <td>
                                   <asp:Label Text='<%# Eval("Address") %>' runat="server" ID="AddressLabel" /></td>
                               <td>
                                   <asp:Label Text='<%# Eval("Area") %>' runat="server" ID="AreaLabel" /></td>
                               <td>
                                   <asp:Label Text='<%# Eval("Notes") %>' runat="server" ID="NotesLabel" /></td>
                               <td>
                                 
                                   <asp:GridView ID="GridView1" runat="server"
                                       DataSource='<%# Eval("JobDone") %>'></asp:GridView>
                               </td>
                           </tr>
                       </SelectedItemTemplate>
                   </asp:ListView>
            <%--<asp:ListView ID="ListView1" runat="server"></asp:ListView>
            <asp:GridView ID="GridView1" runat="server"></asp:GridView>
            <asp:GridView ID="GridView2" runat="server"></asp:GridView>--%>
        </div>
    </div>
    <asp:ObjectDataSource ID="RouteListODS" runat="server" OldValuesParameterFormatString="original_{0}" SelectMethod="RouteStatus_List" TypeName="COESystem.BLL.RouteController">
        <SelectParameters>
            <asp:Parameter Name="season" Type="Int32"></asp:Parameter>
            <asp:Parameter Name="yardId" Type="Int32"></asp:Parameter>
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>
