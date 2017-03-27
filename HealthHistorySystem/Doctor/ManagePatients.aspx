<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ManagePatients.aspx.cs" Inherits="HealthHistorySystem.WebForm6" %>

<%@ Register Assembly="Telerik.Web.UI, Version=2013.1.403.40, Culture=neutral, PublicKeyToken=121fae78165ba3d4"
    Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%@ Register assembly="Telerik.Web.UI" namespace="Telerik.Web.UI" tagprefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/jquery-1.10.2.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="hor_menu" runat="server">
    <div class="menu">
        <ul>
            <li><a id="managePatients" runat="server" href="ManagePatients.aspx" class="managePatients">
                Manage Patients</a></li>
        </ul>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="slider_area" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="left_column_area" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="content_area" runat="server">
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" Skin="WebBlue">
    </telerik:RadWindowManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel" runat="server" Skin="WebBlue"
        MinDisplayTime="30" InitialDelayTime="0" ZIndex="2000">
    </telerik:RadAjaxLoadingPanel>
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
    <telerik:RadGrid ID="RadGridPatients" AutoGenerateColumns="false" runat="server"
        AllowFilteringByColumn="true" PageSize="15" AllowPaging="true" Skin="WebBlue"
        OnNeedDataSource="RadGridPatients_NeedDataSource" OnInsertCommand="RadGridPatients_InsertCommand"
        OnItemDataBound="RadGridPatients_ItemDataBound" OnUpdateCommand="RadGridPatients_UpdateCommand"
        OnDeleteCommand="RadGridPatients_DeleteCommand" OnItemCommand="RadGridPatients_ItemCommand">
        <ClientSettings>
            <ClientEvents OnPopUpShowing="PopUpShowing" />
        </ClientSettings>
        <MasterTableView EditMode="EditForms" CommandItemDisplay="Top" DataKeyNames="patientId,patientnatid,patientCityID">
            <EditFormSettings EditFormType="Template">
                <FormTemplate>
                    <asp:Panel ID="patientForm" runat="server" DefaultButton="btnForm">
                        <div class="FormPanel PatientFormPanel">
                            <table>
                                <tr>
                                    <td class="lblForm">
                                        Patient Name:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPatientName" runat="server" Text='<%# Eval("patientName") %>'
                                            CssClass="txtForm"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="reqtxtPatientName" ControlToValidate="txtPatientName"
                                            runat="server" ErrorMessage="*" CssClass="required"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="lblForm">
                                        Mother Name:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtMotherName" runat="server" Text='<%# Eval("patientmother") %>'
                                            CssClass="txtForm"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="reqtxtMotherName" ControlToValidate="txtMotherName"
                                            runat="server" ErrorMessage="*" CssClass="required"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="lblForm">
                                        Patient's Address:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAddress" runat="server" Text='<%# Eval("patientaddress") %>'
                                            CssClass="txtForm"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="reqtxtAddress" ControlToValidate="txtAddress" runat="server"
                                            ErrorMessage="*" CssClass="required"></asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="lblForm">
                                        Patient's Phone Number:
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPhone" runat="server" Text='<%# Eval("patientphone") %>' CssClass="txtForm"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="reqtxtPhone" ControlToValidate="txtPhone" runat="server"
                                            ErrorMessage="*" CssClass="required"></asp:RequiredFieldValidator>
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
                                        <asp:RequiredFieldValidator ID="reqtxtMobile" ControlToValidate="txtMobile" runat="server"
                                            ErrorMessage="*" CssClass="required"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="regtxtMobile" runat="server" ControlToValidate="txtMobile"
                                            ErrorMessage="123" CssClass="required" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="lblForm">
                                        Patient's City:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cmbCities" runat="server" DataTextField="cityName" DataValueField="cityID"
                                            Skin="WebBlue" EmptyMessage="select a city">
                                        </telerik:RadComboBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="lblForm">
                                        Patient's nationality:
                                    </td>
                                    <td>
                                        <telerik:RadComboBox ID="cmbNationalities" runat="server" DataTextField="natioalityName"
                                            Skin="WebBlue" DataValueField="nationalityID" AppendDataBoundItems="true" EmptyMessage="select a nationality">
                                        </telerik:RadComboBox>
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
                            </table>
                            <asp:Panel ID="PatientRegPanel" runat="server" Visible="false">
                                <table>
                                    <tr>
                                        <td class="lblForm">
                                            Organization:
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cmbOrganizations" runat="server" EmptyMessage="select an organization"
                                                DataValueField="id" DataTextField="name" Skin="WebBlue">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Process Type:
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="cmbProcessTypes" runat="server" EmptyMessage="select a process type"
                                                DataValueField="id" DataTextField="name" Skin="WebBlue">
                                            </telerik:RadComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Process Date:
                                        </td>
                                        <td>
                                            <telerik:RadDatePicker ID="dpProcessDate" runat="server" Skin="WebBlue">
                                            </telerik:RadDatePicker>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Process Description:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtProcessDescription" runat="server" TextMode="MultiLine" CssClass="txtForm"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Medicine name:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtMedicineName" runat="server" CssClass="txtForm"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            From Date:
                                        </td>
                                        <td>
                                            <telerik:RadDatePicker ID="dpFromDate" runat="server" Skin="WebBlue">
                                            </telerik:RadDatePicker>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            To Date:
                                        </td>
                                        <td>
                                            <telerik:RadDatePicker ID="dpToDate" runat="server" Skin="WebBlue">
                                            </telerik:RadDatePicker>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="lblForm">
                                            Note:
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtNote" runat="server" TextMode="MultiLine" CssClass="txtForm"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </asp:Panel>
                            <asp:Panel ID="PatientProcessMedicine" runat="server" Visible="false" CssClass="processMedicinePanel">
                                <div class="float_left left_right_content">
                                    <h3 class="patientProcesses" runat="server">
                                        Patient Processes</h3>
                                    <telerik:RadListView ID="RadListViewPatientRegister" runat="server" Skin="WebBlue"
                                        AllowPaging="false" ItemPlaceholderID="PlaceHolder">
                                        <LayoutTemplate>
                                            <asp:Panel ID="PlaceHolder" runat="server">
                                            </asp:Panel>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <table class="patientTable">
                                                <tr>
                                                    <td class="lblForm">
                                                        Organization:
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="txtOrganization" runat="server" CssClass="patientData" Text='<%# Eval("organization") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="lblForm">
                                                        Process Type:
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label1" runat="server" CssClass="patientData" Text='<%# Eval("processType") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="lblForm">
                                                        Process Date:
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label2" runat="server" CssClass="patientData" Text='<%# Eval("processDate") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="lblForm">
                                                        Process Description:
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label3" runat="server" CssClass="patientData" Text='<%# Eval("processDescription") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </telerik:RadListView>
                                </div>
                                <div class="float_left left_right_content">
                                    <h3 class="patientProcesses">
                                        Patient Medicines</h3>
                                    <telerik:RadListView ID="RadListViewPatientMedicine" runat="server" Skin="WebBlue"
                                        AllowPaging="true" ItemPlaceholderID="PlaceHolder">
                                        <LayoutTemplate>
                                            <asp:Panel ID="PlaceHolder" runat="server">
                                            </asp:Panel>
                                            <telerik:RadDataPager ID="RadDataPager" PagedControlID="RadListViewPatientMedicine"
                                                Skin="WebBlue" runat="server" CssClass="RadDataPager_Default" PageSize="1" Visible='<%# Container.PageCount != 1%>'>
                                                <Fields>
                                                    <telerik:RadDataPagerButtonField FieldType="Numeric" />
                                                </Fields>
                                            </telerik:RadDataPager>
                                        </LayoutTemplate>
                                        <ItemTemplate>
                                            <table class="patientTable">
                                                <tr>
                                                    <td class="lblForm">
                                                        Medicine Name:
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lblMedicineName" runat="server" CssClass="patientData" Text='<%# Eval("medicineName") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="lblForm">
                                                        Form Date:
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label4" runat="server" CssClass="patientData" Text='<%# Eval("fromDate") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="lblForm">
                                                        To Date:
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label5" runat="server" CssClass="patientData" Text='<%# Eval("toDate") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="lblForm">
                                                        Note:
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label6" runat="server" CssClass="patientData" Text='<%# Eval("note") %>'></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </telerik:RadListView>
                                </div>
                            </asp:Panel>
                            <div class="clear">
                            </div>
                            <div class="btnsForm">
                                <asp:ImageButton ID="btnForm" runat="server" ImageUrl='<%# (Container is GridEditFormInsertItem) ? "../Images/add.jpg" : "../Images/update.jpg" %>'
                                    CommandName='<%# (Container is GridEditFormInsertItem) ? "PerformInsert" : "Update" %>'
                                    ToolTip='<%#(Container is GridEditFormInsertItem) ? "Add New Process Type" : "Update Existing Process Type" %>' />
                                <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="../Images/cancel.jpg" CommandName="Cancel"
                                    CausesValidation="false" ToolTip="Cancel" />
                                <asp:ImageButton ID="btnAddProcess" runat="server" ImageUrl="../Images/AddProcess.jpg"
                                    CausesValidation="false" CommandName="AddProcess" />
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
                <telerik:GridBoundColumn HeaderText="Patient Name" DataField="patientName" DataType="System.String"
                    AllowFiltering="true">
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
</asp:Content>
