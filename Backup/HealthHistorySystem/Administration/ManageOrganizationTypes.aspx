<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManageOrganizationTypes.aspx.cs" Inherits="HealthHistorySystem.WebForm12" %>

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
            <li><a id="organizationTypes" runat="server" href=" ManageOrganizationTypes.aspx">Manage
                Organization Types</a></li>
            <li><a id="processCategories" runat="server" href=" ManageProcessCategories.aspx">Manage
                Process Categories</a></li>
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
                <telerik:AjaxSetting AjaxControlID="RadGridOrganizationTypes">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadGridOrganizationTypes" LoadingPanelID="RadAjaxLoadingPanel"
                            UpdatePanelHeight="100%" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadGrid ID="RadGridOrganizationTypes" AutoGenerateColumns="false" runat="server"
            AllowPaging="true" PageSize="15" Skin="WebBlue" OnDeleteCommand="RadGridOrganizationTypes_DeleteCommand"
            OnInsertCommand="RadGridOrganizationTypes_InsertCommand" OnNeedDataSource="RadGridOrganizationTypes_NeedDataSource"
            OnUpdateCommand="RadGridOrganizationTypes_UpdateCommand">
            <ClientSettings>
                <ClientEvents OnPopUpShowing="PopUpShowing" />
            </ClientSettings>
            <MasterTableView EditMode="PopUp" CommandItemDisplay="TopAndBottom" DataKeyNames="id">
                <EditFormSettings EditFormType="Template">
                    <PopUpSettings Modal="true" Height="350" Width="800" />
                    <FormTemplate>
                        <asp:Panel ID="OrganizationTypeForm" runat="server" DefaultButton="btnForm">
                            <div class="FormPanel">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblOrganizationType" runat="server" CssClass="lblForm" Text="Organization Type Name: "></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtOrganizationType" runat="server" CssClass="txtForm" Text='<%# Eval("OrganizationTypeName") %>'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqtxtOrganizationType" ControlToValidate="txtOrganizationType"
                                                CssClass="required" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                </table>
                                <div class="btnsForm">
                                    <asp:ImageButton ID="btnForm" runat="server" ImageUrl='<%# (Container is GridEditFormInsertItem) ? "../Images/add.jpg" : "../Images/update.jpg" %>'
                                        CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                        ToolTip='<%#(Container is GridEditFormInsertItem) ? "Add New organization Type" : "Update Existing organization Type" %>' />
                                    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../Images/cancel.jpg" CommandName="Cancel"
                                        CausesValidation="false" ToolTip="Cancel" />
                                </div>
                            </div>
                        </asp:Panel>
                    </FormTemplate>
                </EditFormSettings>
                <Columns>
                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" ButtonType="ImageButton"
                        HeaderText="Delete an existing organization type" ConfirmText="are you sure you want to delete an organization type ?"
                        ConfirmDialogWidth="400px" ConfirmDialogHeight="135px" ConfirmTitle="delete an organization category">
                        <ItemStyle Width="200px"></ItemStyle>
                    </telerik:GridButtonColumn>
                    <telerik:GridEditCommandColumn HeaderText="Edit an Organization Type" ButtonType="ImageButton">
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText="Organization Type Id" DataField="id" DataType="System.Int32"
                        Visible="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Organization Type Name" DataField="OrganizationTypeName"
                        DataType="System.String">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
</asp:Content>
