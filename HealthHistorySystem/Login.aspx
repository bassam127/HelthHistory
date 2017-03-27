<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Login.aspx.cs" Inherits="HealthHistorySystem.WebForm9" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="Styles/nivo-slider.css" type="text/css" />
    <script type="text/javascript" src="Scripts/jquery-1.10.2.min.js"></script>
    <script src="Scripts/jquery.nivo.slider.pack.js" type="text/javascript"></script>
    <link rel="stylesheet" href="Styles/themes/default/default.css" type="text/css" />
    <script type="text/javascript">
        $(window).load(function () {
            $('#slider').nivoSlider({
            controlNav: false,
            effect: 'fade',               // Specify sets like: 'fold,fade,sliceDown' 
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="hor_menu" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="slider_area" runat="server">
    <div class="theme-default">
        <div id="slider" class="nivoSlider">
            <img src="Images/1.jpg" alt="" />
            <img src="Images/2.jpg" alt="" />
            <img src="Images/3.jpg" alt="" />
            <img src="Images/4.jpg" alt="" />
            <img src="Images/5.jpg" alt="" />
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="left_column_area" runat="server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="content_area" runat="server">
    <div class="paddingContent">
        <asp:Panel ID="loginPanel" runat="server" DefaultButton="btnLogin" CssClass="loginPanel">
            <table>
                <tr>
                    <td>
                        <asp:Label ID="lblUserName" runat="server" Text="User Name: " CssClass="lblForm"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtUserName" runat="server" CssClass="txtForm"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="reqtxtUserName" ControlToValidate="txtUserName" CssClass="required"
                            runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lblPassword" runat="server" Text="Password: " CssClass="lblForm"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="txtForm"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="txtUserName"
                            CssClass="required" runat="server" ErrorMessage="*"></asp:RequiredFieldValidator>
                    </td>
                </tr>
            </table>
            <asp:ImageButton ID="btnLogin" runat="server" ImageUrl="Images/Login.jpg" CssClass="loginBtn"
                OnClick="btnLogin_Click" />
            <asp:Label ID="lblMsg" runat="server" Visible="false" CssClass="required"></asp:Label>
        </asp:Panel>
        <p>
            Health History System is the next generation of integrated health systems, marked
            by strong patient focus, heightened efficiency, consistent quality performance and
            open, collaborative sharing of best practices.</p>
        <p>
            It is dedicated to providing patients with an exceptional, coordinated care experience
            and a single, high standard of service.
        </p>
        <p>
            Health Hsitory System is a web-based web applications allows patients to access
            the system every whereto view thier records, also doctors can add and manager patients
            records, admin can control everything within the system from adding organizations
            to manage doctors.
        </p>
    </div>
</asp:Content>
