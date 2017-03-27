<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ViewPatientRecord.aspx.cs" Inherits="HealthHistorySystem.WebForm8" %>

<%@ Register Assembly="Telerik.Web.UI, Version=2013.1.403.40, Culture=neutral, PublicKeyToken=121fae78165ba3d4"
    Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="hor_menu" runat="server">
    <div class="menu">
        <ul>
            <li><a id="patientRecord" runat="server" href="ViewPatientRecord.aspx">Patient Record</a></li>
            <li><a id="changePassword" runat="server" href="ChangePassword.aspx">Change Password</a></li>
        </ul>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="slider_area" runat="server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="left_column_area" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="content_area" runat="server">
    <div class="paddingContent">
        <telerik:RadListView ID="RadListViewPatient" runat="server" Skin="WebBlue" ItemPlaceholderID="PlaceHolder"
            AllowPaging="false" OnNeedDataSource="RadListViewPatient_NeedDataSource">
            <LayoutTemplate>
                <asp:Panel ID="PlaceHolder" runat="server">
                </asp:Panel>
            </LayoutTemplate>
            <ItemTemplate>
                <table>
                    <tr>
                        <td>
                            <asp:Label ID="lblPatientName" runat="server" CssClass="lblForm" Text="Patient Name: "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="txtPatientName" runat="server" CssClass="patientData" Text='<%# Eval("patientName") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblMotherName" runat="server" CssClass="lblForm" Text="Patient's Mother Name: "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="txtMotherName" runat="server" CssClass="patientData" Text='<%# Eval("motherName") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblNationality" runat="server" CssClass="lblForm" Text="Patient's Nationality: "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="txtNationality" runat="server" CssClass="patientData" Text='<%# Eval("nationality") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblNationalityNo" runat="server" CssClass="lblForm" Text="Patient's Nationality No: "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="txtNationalityNo" runat="server" CssClass="patientData" Text='<%# Eval("nationalityNo") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblCity" runat="server" CssClass="lblForm" Text="Patient's City: "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="txtCity" runat="server" CssClass="patientData" Text='<%# Eval("city") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblAddress" runat="server" CssClass="lblForm" Text="Patient's Address: "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="txtAddress" runat="server" CssClass="patientData" Text='<%# Eval("address") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblPhone" runat="server" CssClass="lblForm" Text="Patient's Phone No: "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="txtPhone" runat="server" CssClass="patientData" Text='<%# Eval("phone") %>'></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblmobile" runat="server" CssClass="lblForm" Text="Patient's Mobile No: "></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="txtmobile" runat="server" CssClass="patientData" Text='<%# Eval("mobile") %>'></asp:Label>
                        </td>
                    </tr>
                </table>
            </ItemTemplate>
        </telerik:RadListView>
        <div class="float_left left_right_content">
            <h3 class="patientProcesses">
                Patient Processes</h3>
            <telerik:RadListView ID="RadListViewPatientRegister" runat="server" Skin="WebBlue"
                AllowPaging="true" ItemPlaceholderID="PlaceHolder" OnNeedDataSource="RadListViewPatientRegister_NeedDataSource">
                <LayoutTemplate>
                    <asp:Panel ID="PlaceHolder" runat="server">
                    </asp:Panel>
                    <telerik:RadDataPager ID="RadDataPager" PagedControlID="RadListViewPatientRegister"
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
                AllowPaging="true" ItemPlaceholderID="PlaceHolder" OnNeedDataSource="RadListViewPatientMedicine_NeedDataSource">
                <LayoutTemplate>
                    <asp:Panel ID="PlaceHolder" runat="server">
                    </asp:Panel>
                    <telerik:RadDataPager ID="RadDataPager" PagedControlID="RadListViewPatientMedicine"
                        runat="server" CssClass="RadDataPager_Default" PageSize="1" Visible='<%# Container.PageCount != 1%>'>
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
    </div>
</asp:Content>
