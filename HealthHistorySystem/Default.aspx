<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="image_processing._Default" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1><%: Title %>.</h1>
                <h2>Modify this template to jump-start your ASP.NET application.</h2>
            </hgroup>
            <p>
                To learn more about ASP.NET, visit <a href="http://asp.net" title="ASP.NET Website">http://asp.net</a>.
                The page features <mark>videos, tutorials, and samples</mark> to help you get the most from ASP.NET.
                If you have any questions about ASP.NET visit
                <a href="http://forums.asp.net/18.aspx" title="ASP.NET Forum">our forums</a>.
            </p>
        </div>
    </section>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
   
    <table>
    <tr>
        <td class="style3">
            <asp:Label ID="Label1" runat="server" Text="Photo upload" />
        </td>
        <td class="style4">
            <asp:FileUpload runat="server" ID="PhotoUpload" />
        </td>
        <td class="style4">
            &nbsp;</td>
        <td class="style1">
            <asp:Image runat="server" ID="ImagePreview" Height="164px" Width="125px" />
        </td>
    </tr>
</table>
    <asp:Button runat="server" OnClick="btnPreview_Click" ID="Button1" Text="Preview" />
   <asp:Button runat="server" OnClick="grayscale" ID="Button2" Text="grayscale" />
</asp:Content>
