<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManageCenters.aspx.cs" Inherits="HealthHistorySystem.WebForm1" %>

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
    <asp:Label ID="xx" runat="server"></asp:Label>
    <div id="right_column">
        <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="WebBlue">
        </telerik:RadWindowManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server" Skin="WebBlue"
            MinDisplayTime="30" InitialDelayTime="0" ZIndex="2000">
        </telerik:RadAjaxLoadingPanel>
        <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" EnablePageHeadUpdate="False"
            DefaultLoadingPanelID="RadAjaxLoadingPanel">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="RadGridCenters">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadGridCenters" LoadingPanelID="RadAjaxLoadingPanel"
                            UpdatePanelHeight="100%" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadGrid ID="RadGridCenters" runat="server" AutoGenerateColumns="false" Skin="WebBlue"
            AllowPaging="true" PageSize="15" OnNeedDataSource="RadGridCenters_NeedDataSource"
            OnInsertCommand="RadGridCenters_InsertCommand" OnItemDataBound="RadGridCenters_ItemDataBound"
            OnDeleteCommand="RadGridCenters_DeleteCommand" OnUpdateCommand="RadGridCenters_UpdateCommand">
            <ClientSettings>
                <ClientEvents OnPopUpShowing="PopUpShowing" />
            </ClientSettings>
            <MasterTableView EditMode="PopUp" CommandItemDisplay="TopAndBottom" DataKeyNames="id,organizationTypeId">
                <EditFormSettings EditFormType="Template">
                    <PopUpSettings Modal="true" Height="350" Width="800" />
                    <FormTemplate>
                        <asp:Panel ID="CityForm" runat="server" DefaultButton="btnForm">
                            <div class="FormPanel">
                                <table>
                                    <tr>
                                        <td class="lblForm">
                                            Orgnization Type:
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cmbOrganizationType" runat="server" EmptyMessage="select an organization type"
                                                Skin="WebBlue" DataValueField="id" DataTextField="name">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Orgnization Name:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtOrgnizationName" runat="server" Text='<%# Eval("name") %>' CssClass="txtForm">
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqtxtOrgnizationName" ControlToValidate="txtOrgnizationName"
                                                CssClass="required" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Orgnization Address:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtOrganizationAddress" runat="server" Text='<%# Eval("address") %>'
                                                CssClass="txtForm">
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqtxtOrganizationAddress" ControlToValidate="txtOrganizationAddress"
                                                CssClass="required" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Orgnization Phone:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtOrganizationPhone" runat="server" Text='<%# Eval("phone") %>'
                                                CssClass="txtForm"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqtxtOrganizationPhone" ControlToValidate="txtOrganizationPhone"
                                                CssClass="required" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="regtxtOrganizationPhone" runat="server" ControlToValidate="txtOrganizationPhone"
                                                ErrorMessage="123" CssClass="required" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Organization mobile Number:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtOrganizationMobile" runat="server" CssClass="txtForm" Text='<%# Eval("mobile") %>'> </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqtxtOrganizationMobile" ControlToValidate="txtOrganizationMobile"
                                                CssClass="required" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="regtxtOrganizationMobile" runat="server" ControlToValidate="txtOrganizationMobile"
                                                ErrorMessage="123" CssClass="required" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Orgnization Email:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtOrganizationEmail" runat="server" Text='<%# Eval("email") %>'
                                                CssClass="txtForm">
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqtxtOrganizationEmail" ControlToValidate="txtOrganizationEmail"
                                                CssClass="required" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="regtxtOrganizationEmail" runat="server" ControlToValidate="txtOrganizationEmail"
                                                ErrorMessage="not a valid e-mail address" CssClass="required" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Orgnization Website:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtOrganizationWebsite" runat="server" Text='<%# Eval("website") %>'
                                                CssClass="txtForm">
                                            </asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqtxtOrganizationWebsite" ControlToValidate="txtOrganizationWebsite"
                                                CssClass="required" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                </table>
                                <div class="btnsForm">
                                    <asp:ImageButton ID="btnForm" runat="server" ImageUrl='<%# (Container is GridEditFormInsertItem) ? "../Images/add.jpg" : "../Images/update.jpg" %>'
                                        CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                        ToolTip='<%#(Container is GridEditFormInsertItem) ? "Add New Center" : "Update Existing Center" %>' />
                                    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../Images/cancel.jpg" CommandName="Cancel"
                                        CausesValidation="false" ToolTip="Cancel" />
                                </div>
                            </div>
                        </asp:Panel>
                    </FormTemplate>
                </EditFormSettings>
                <Columns>
                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" ButtonType="ImageButton"
                        HeaderText="Delete Center" ConfirmText="are you sure you want to delete a center ?"
                        ConfirmDialogWidth="400px" ConfirmDialogHeight="135px" ConfirmTitle="delete center">
                        <ItemStyle Width="150px"></ItemStyle>
                    </telerik:GridButtonColumn>
                    <telerik:GridEditCommandColumn HeaderText="Edit center" ButtonType="ImageButton">
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText="Center id" DataField="id" DataType="System.Int32"
                        Visible="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Organization Type Id" DataField="organizationTypeId"
                        DataType="System.Int32" Visible="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Organization Name" DataField="name" DataType="System.String">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Organization Address" DataField="address" DataType="System.String">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
    </div>
</asp:Content>
