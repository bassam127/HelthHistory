using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HealthHistorySystem
{
    public partial class WebForm7 : System.Web.UI.Page
    {
        HealthHistoryEntities db = new HealthHistoryEntities();
        private Sec_Users getPatientById(int patientId)
        {
            var query = (from patient in db.Sec_Users
                         where patient.id == patientId
                         select patient).FirstOrDefault();
            return query;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] != null)
            {
                Sec_Users user = Session["user"] as Sec_Users;
                if (user.Sec_UserType.name.ToLower() != "patient")
                {
                    Response.Redirect("~/Login.aspx");
                }
            }
            else
                if (Session["user"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                }
            changePassword.Attributes["class"] = "active";
        }
        protected void btnChangePassword_Click(object sender, ImageClickEventArgs e)
        {
            Sec_Users user = null;
            if (Session["user"] != null)
            {
                user = Session["user"] as Sec_Users;
                if (user.Sec_UserType.name.ToLower() != "patient")
                {
                    Response.Redirect("~/Login.aspx");
                }
            }
            else
                if (Session["user"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                }
            Sec_Users patient = getPatientById(user.id);
            if (patient.password.ToLower() == txtCurrentPassword.Text.ToLower())
            {
                patient.password = txtNewPassword.Text;
                db.SaveChanges();
                lblMsg.Text = "Password has been changed successfully";
                lblMsg.Visible = true;
            }
        }
    }
}