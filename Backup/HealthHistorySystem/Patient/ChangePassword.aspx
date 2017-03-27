<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="ChangePassword.aspx.cs" Inherits="HealthHistorySystem.WebForm7" %>

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
        <table id="changePasswordTable">
            <tr>
                <td>
                    <asp:Label ID="lblCurrentPassword" CssClass="lblForm" runat="server" Text="Current Password: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqtxtCurrentPassword" runat="server" ControlToValidate="txtCurrentPassword"
                        CssClass="required" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblNewPassword" CssClass="lblForm" runat="server" Text="New Password: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqtxtNewPassword" runat="server" ControlToValidate="txtNewPassword"
                        CssClass="required" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblRepeatPassword" CssClass="lblForm" runat="server" Text="Repeat Password: "></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="txtRepeatPassword" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqtxtRepeatPassword" runat="server" ControlToValidate="txtRepeatPassword"
                        CssClass="required" ErrorMessage="*"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="PasswordCompareValidator" ControlToValidate="txtRepeatPassword"
                        ControlToCompare="txtNewPassword" CssClass="required" runat="server" ErrorMessage="new passwords are not the same."></asp:CompareValidator>
                </td>
            </tr>
        </table>
        <asp:ImageButton ID="btnChangePassword" runat="server" ImageUrl="~/Images/ChangePassword.jpg"
            OnClick="btnChangePassword_Click" />
        <asp:Label ID="lblMsg" runat="server" CssClass="greenMsg errorMsg" Visible="false"></asp:Label>
    </div>
</asp:Content>
