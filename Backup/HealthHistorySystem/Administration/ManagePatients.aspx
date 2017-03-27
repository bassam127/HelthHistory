<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManagePatients.aspx.cs" Inherits="HealthHistorySystem.WebForm4" %>

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
        <telerik:RadGrid ID="RadGridPatients" AutoGenerateColumns="false" runat="server"
            AllowPaging="true" PageSize="15" Skin="WebBlue" OnNeedDataSource="RadGridPatients_NeedDataSource"
            OnInsertCommand="RadGridPatients_InsertCommand" OnItemDataBound="RadGridPatients_ItemDataBound"
            OnUpdateCommand="RadGridPatients_UpdateCommand" OnDeleteCommand="RadGridPatients_DeleteCommand">
            <ClientSettings>
                <ClientEvents OnPopUpShowing="PopUpShowing" />
            </ClientSettings>
            <MasterTableView EditMode="PopUp" CommandItemDisplay="TopAndBottom" DataKeyNames="patientId,patientnatid,patientCityID">
                <EditFormSettings EditFormType="Template">
                    <PopUpSettings Modal="true" Height="350" Width="800" />
                    <FormTemplate>
                        <asp:Panel ID="PatientForm" runat="server" DefaultButton="btnForm">
                            <div class="FormPanel">
                                <table>
                                    <tr>
                                        <td class="lblForm">
                                            Patient Name:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPatientName" runat="server" Text='<%# Eval("patientName") %>'
                                                CssClass="txtForm"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqtxtPatientName" ControlToValidate="txtPatientName"
                                                CssClass="required" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <asp:Panel ID="patientPasswordPanel" runat="server">
                                        <tr>
                                            <td class="lblForm">
                                                Patient Password:
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtPatientPassword" runat="server" CssClass="txtForm" Text='<%# Eval("password") %>'></asp:TextBox>
                                            </td>
                                        </tr>
                                    </asp:Panel>
                                    <tr>
                                        <td class="lblForm">
                                            Mother Name:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtMotherName" runat="server" Text='<%# Eval("patientmother") %>'
                                                CssClass="txtForm"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqtxtMotherName" ControlToValidate="txtMotherName"
                                                CssClass="required" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Patient's Address:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtAddress" runat="server" Text='<%# Eval("patientaddress") %>'
                                                CssClass="txtForm"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqtxtAddress" ControlToValidate="txtAddress" CssClass="required"
                                                runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Patient's Phone Number:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtPhone" runat="server" Text='<%# Eval("patientphone") %>' CssClass="txtForm"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqtxtPhone" ControlToValidate="txtPhone" CssClass="required"
                                                runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="regtxtPhone" runat="server" ControlToValidate="txtPhone"
                                                ErrorMessage="123" CssClass="required" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Patient's Mobile Number:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtMobile" runat="server" Text='<%# Eval("patientmobile") %>' CssClass="txtForm"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqtxtMobile" ControlToValidate="txtMobile" CssClass="required"
                                                runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="regtxtMobile" runat="server" ControlToValidate="txtMobile"
                                                ErrorMessage="123" CssClass="required" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Nationality No:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtNationalityNumber" runat="server" CssClass="txtForm" Text='<%# Eval("NationalityNo") %>'></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="reqtxtNationalityNumber" ControlToValidate="txtNationalityNumber"
                                                CssClass="required" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="regtxtNationalityNumber" runat="server" ControlToValidate="txtNationalityNumber"
                                                ErrorMessage="123" CssClass="required" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Patient Active:
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="chkActive" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Patient's City:
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cmbCities" runat="server" DataTextField="cityName" DataValueField="cityID"
                                                EmptyMessage="select a city" Skin="WebBlue">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Patient's nationality:
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cmbNationalities" runat="server" DataTextField="natioalityName"
                                                DataValueField="nationalityID" EmptyMessage="select a nationality" Skin="WebBlue">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                </table>
                                <div class="btnsForm">
                                    <asp:ImageButton ID="btnForm" runat="server" ImageUrl='<%# (Container is GridEditFormInsertItem) ? "../Images/add.jpg" : "../Images/update.jpg" %>'
                                        CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                        ToolTip='<%#(Container is GridEditFormInsertItem) ? "Add New Patient" : "Update Existing Patient" %>' />
                                    <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../Images/cancel.jpg" CommandName="Cancel"
                                        CausesValidation="false" ToolTip="Cancel" />
                                </div>
                            </div>
                        </asp:Panel>
                    </FormTemplate>
                </EditFormSettings>
                <Columns>
                    <telerik:GridButtonColumn Text="Delete" CommandName="Delete" ButtonType="ImageButton"
                        HeaderText="Delete an existing patient" ConfirmText="are you sure you want to delete a patient ?"
                        ConfirmDialogWidth="400px" ConfirmDialogHeight="135px" ConfirmTitle="delete a patient">
                        <ItemStyle Width="100px"></ItemStyle>
                    </telerik:GridButtonColumn>
                    <telerik:GridEditCommandColumn HeaderText="Edit Patient" ButtonType="ImageButton">
                    </telerik:GridEditCommandColumn>
                    <telerik:GridBoundColumn HeaderText="Patient ID" DataField="patientId" DataType="System.Int32"
                        Visible="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Nationality ID" DataField="patientnatid" DataType="System.Int32"
                        Visible="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="City ID" DataField="patientCityID" DataType="System.Int32"
                        Visible="false">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Patient Name" DataField="patientName" DataType="System.String">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Mother Name" DataField="patientmother" DataType="System.String">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Patient's City" DataField="patientcity" DataType="System.String">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Patient's nationality" DataField="patientnationality"
                        DataType="System.String">
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
        <telerik:RadAjaxManager ID="RadAjaxManager" runat="server" EnablePageHeadUpdate="False"
            DefaultLoadingPanelID="RadAjaxLoadingPanel">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="RadGridPatients">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="RadGridPatients" LoadingPanelID="RadAjaxLoadingPanel"
                            UpdatePanelHeight="100%" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
    </div>
</asp:Content>
