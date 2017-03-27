using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HealthHistorySystem
{
    public partial class WebForm9 : System.Web.UI.Page
    {
        HealthHistoryEntities db = new HealthHistoryEntities();
        private Sec_Users getUser(string userName, string password)
        {
            var query = (from user in db.Sec_Users
                         where user.Username.ToLower() == userName.ToLower() && user.password == password.ToLower() && user.IsActive == true
                         select user).FirstOrDefault();
            return query;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            Panel loginStatusPanel = Master.FindControl("loginStatusPanel") as Panel;
            loginStatusPanel.Visible = false;
        }
        protected void btnLogin_Click(object sender, ImageClickEventArgs e)
        {
            Sec_Users user = getUser(txtUserName.Text, txtPassword.Text);
            if (user != null)
            {
                if (user.id != 0 && user.Sec_UserType.name.ToLower() == "patient")
                {
                    Session["user"] = user;
                    Response.Redirect("Patient/ViewPatientRecord.aspx");
                }
                else
                    if (user.id != 0 && user.Sec_UserType.name.ToLower() == "doctor")
                    {
                        Session["user"] = user;
                        Response.Redirect("Doctor/ManagePatients.aspx");
                    }
                    else
                        if (user.id != 0 && user.Sec_UserType.name.ToLower() == "admin")
                        {
                            Session["user"] = user;
                            Response.Redirect("Administration/ManageCenters.aspx");
                        }
                        else
                        {
                            lblMsg.Text = "invalid user name or password";
                            lblMsg.Visible = true;
                        }
            }
            else
            {
                lblMsg.Text = "invalid user name or password or the user is in-active";
                lblMsg.Visible = true;
            }
        }
    }
}