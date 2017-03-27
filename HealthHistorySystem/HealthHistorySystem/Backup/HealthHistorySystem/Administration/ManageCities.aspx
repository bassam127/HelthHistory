<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManageCities.aspx.cs" Inherits="HealthHistorySystem.WebForm2" %>

<%@ Register Assembly="Telerik.Web.UI, Version=2013.1.403.40, Culture=neutral, PublicKeyToken=121fae78165ba3d4"
    Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="hor_menu" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="slider_area" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="left_column_area" runat="server">
    <div id="left_column">
        <ul id="left_nav">
            <li><a id="centers" runat="server" href="ManageCenters.aspx">Manage Centers</a></li>
            <li><a id="cities" runat="server" href="ManageCities.aspx">Manage Cities</a></li>
            <li><a id="nationalities" runat="server" href="ManageNationality.aspx">Manage Nationalities</a></li>
            <li><a id="patients" runat="server" href="ManagePatients.aspx">Manage Patients</a></li>
            <li><a id="process" runat="server" href="ManageProcessTypes.aspx">Manage Process Types</a></li>
            <li><a id="doctor" runat="server" href="ManageDoctors.aspx">Manage Doctors</a></li>
            <li><a id="A1" runat="server" href=" ManageOrganizationTypes.aspx">Manage Organization
                Types</a></li>
            <li><a id="A2" runat="server" href=" ManageProcessCategories.aspx">Manage Process Categories</a></li>
        </ul>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="content_area" runat="server">
    <div id="right_column">
        <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="WebBlue">
        </telerik:RadWindowManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server" Skin="WebBlue"
            MinDisplayTime="30" InitialDelayTime="0" ZIndex="2000">
        </telerik:RadAjaxLoadingPanel>
        <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" EnablePageHeadUpdate="False"
            DefaultLoadingPanelID="RadAjaxLoadingPanel">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="CitiesRadGrid">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="CitiesRadGrid" LoadingPanelID="RadAjaxLoadingPanel"
                            UpdatePanelHeight="100%" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadGrid ID="CitiesRadGrid" runat="server" AutoGenerateColumns="false" OnNeedDataSource="CitiesRadGrid_NeedDataSource"
            AllowPaging="true" PageSize="15" Skin="WebBlue" OnInsertCommand="CitiesRadGrid_InsertCommand"
            OnUpdateCommand="CitiesRadGrid_UpdateCommand" OnDeleteCommand="CitiesRadGrid_DeleteCommand">
            <ClientSettings>
                <ClientEvents OnPopUpShowing="PopUpShowing" />
            </ClientSettings>
            <MasterTableView EditMode="PopUp" CommandItemDisplay="TopAndBottom" DataKeyNames="cityId">
                <EditFormSettings EditFormType="Template">
                    <PopUpSettings Modal="true" Height="350" Width="800" />
                    <FormTemplate>
                        <asp:Panel ID="CityForm" runat="server" DefaultButton="btnForm">
                            <div class="FormPanel">
                                <table>
                                    <tr>
                                        <td class="lblForm">
                                            <span>City Name: </span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCityName" runat="server" Text='<%# Eval("cityName") %>' CssClass="txtForm"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqtxtCityName" runat="server" ControlToValidate="txtCityName"
                                                ErrorMessage="*" CssClass="required"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                </table>
                                <div class="btnsForm">
                                    <asp:ImageButton ID="btnForm" runat="server" ImageUrl='<%# (Container is GridEditFormInsertItem) ? "../Images/add.jpg" : "../Images/update.jpg" %>'
                                        CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                        ToolTip='<%#(Container is GridEditFormInsertItem) ? "Add New City" : "Update Existing City" %>' />
                                    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../Images/cancel.jpg" CommandName="Cancel"
                                        CausesValidation="false" ToolTip="Cancel" />
                                </div>
                            </div>
                        </asp:Panel>
                    </FormTemplate>
                </EditFormSettings>
                <Columns>
                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" ButtonType="ImageButton"
                        HeaderText="Delete City" ConfirmText="are you sure you want to delete a City ?"
                        ConfirmDialogWidth="400px" ConfirmDialogHeight="135px" ConfirmTitle="delete City">
                        <ItemStyle Width="150px"></ItemStyle>
                    </telerik:GridButtonColumn>
                    <telerik:GridEditCommandColumn HeaderText="Edit City" ButtonType="ImageButton">
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText="City Id" DataField="cityId" DataType="System.Int32"
                        Visible="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="City Name" DataField="cityName" DataType="System.String">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
</asp:Content>
