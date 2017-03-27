<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManageProcessTypes.aspx.cs" Inherits="HealthHistorySystem.WebForm5" %>

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
                <telerik:AjaxSetting AjaxControlID="RadGridProcessTypes">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadGridProcessTypes" LoadingPanelID="RadAjaxLoadingPanel"
                            UpdatePanelHeight="100%" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadGrid ID="RadGridProcessTypes" runat="server" AutoGenerateColumns="false"
            AllowPaging="true" PageSize="15" Skin="WebBlue" OnNeedDataSource="RadGridProcessTypes_NeedDataSource"
            OnItemDataBound="RadGridProcessTypes_ItemDataBound" OnInsertCommand="RadGridProcessTypes_InsertCommand"
            OnUpdateCommand="RadGridProcessTypes_UpdateCommand" OnDeleteCommand="RadGridProcessTypes_DeleteCommand">
            <ClientSettings>
                <ClientEvents OnPopUpShowing="PopUpShowing" />
            </ClientSettings>
            <MasterTableView EditMode="PopUp" CommandItemDisplay="TopAndBottom" DataKeyNames="processId,processCatId">
                <EditFormSettings EditFormType="Template">
                    <PopUpSettings Modal="true" Height="350" Width="800" />
                    <FormTemplate>
                        <asp:Panel ID="ProcessForm" runat="server" DefaultButton="btnForm">
                            <div class="FormPanel">
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblProcessCate" runat="server" Text="Process Category: " CssClass="lblForm"></asp:Label>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cmbProcessCat" runat="server" EmptyMessage="select a process category"
                                                Skin="WebBlue" DataValueField="id" DataTextField="name">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="lblProcessType" runat="server" Text="Process Type: " CssClass="lblForm"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtProcessType" runat="server" Text='<%# Eval("processName") %>'
                                                CssClass="txtForm"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqtxtProcessType" runat="server" CssClass="required"
                                                ErrorMessage="*" ControlToValidate="txtProcessType"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                </table>
                                <div class="btnsForm">
                                    <asp:ImageButton ID="btnForm" runat="server" ImageUrl='<%# (Container is GridEditFormInsertItem) ? "../Images/add.jpg" : "../Images/update.jpg" %>'
                                        CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                        ToolTip='<%#(Container is GridEditFormInsertItem) ? "Add New Process Type" : "Update Existing Process Type" %>' />
                                    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../Images/cancel.jpg" CommandName="Cancel"
                                        CausesValidation="false" ToolTip="Cancel" />
                                </div>
                            </div>
                        </asp:Panel>
                    </FormTemplate>
                </EditFormSettings>
                <Columns>
                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" ButtonType="ImageButton"
                        HeaderText="Delete a process type" ConfirmText="are you sure you want to delete a process type ?"
                        ConfirmDialogWidth="450px" ConfirmDialogHeight="135px" ConfirmTitle="delete a process type">
                        <ItemStyle Width="170px"></ItemStyle>
                    </telerik:GridButtonColumn>
                    <telerik:GridEditCommandColumn HeaderText="Edit process type" ButtonType="ImageButton">
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText="Process ID" DataField="processId" DataType="System.Int32"
                        Visible="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Category ID" DataField="processCatId" DataType="System.Int32"
                        Visible="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Process Name" DataField="processName" DataType="System.String">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Process Category Name" DataField="categoryName"
                        DataType="System.String">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
</asp:Content>
