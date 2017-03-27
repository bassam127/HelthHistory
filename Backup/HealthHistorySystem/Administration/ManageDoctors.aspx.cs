using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace HealthHistorySystem
{
    public partial class WebForm10 : System.Web.UI.Page
    {
        HealthHistoryEntities db = new HealthHistoryEntities();
        private object getDoctors()
        {
            var query = from doctor in db.Sec_Users
                        where doctor.UserTypeId == 2
                        select new
                        {
                            id = doctor.id,
                            userName = doctor.Username,
                            password = doctor.password,
                            isActive = doctor.IsActive
                        };
            return query;
        }
        private Sec_Users getDoctorById(int DoctorId)
        {
            var query = (from doctor in db.Sec_Users
                         where doctor.id == DoctorId
                         select doctor).FirstOrDefault();
            return query;
        }
        private bool userExisted(string name)
        {
            var query = db.Sec_Users.Where(p => p.Username.ToLower() == name.ToLower()).Any();
            return query;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] != null)
            {
                Sec_Users user = Session["user"] as Sec_Users;
                if (user.Sec_UserType.name.ToLower() != "admin")
                {
                    Response.Redirect("~/Login.aspx");
                }
            }
            else
                if (Session["user"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                }
            doctor.Attributes["class"] = "active";
        }
        protected void RadGridDoctors_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            RadGridDoctors.DataSource = getDoctors();
        }
        protected void RadGridDoctors_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem dataItem = e.Item as GridEditableItem;
            int DoctorId = Convert.ToInt32(dataItem.GetDataKeyValue("id"));
            TextBox txtUserName = e.Item.FindControl("txtUserName") as TextBox;
            TextBox txtPassword = e.Item.FindControl("txtPassword") as TextBox;
            CheckBox chkActive = e.Item.FindControl("chkActive") as CheckBox;
            Sec_Users doctor = getDoctorById(DoctorId);
            doctor.Username = txtUserName.Text;
            doctor.password = txtPassword.Text;
            doctor.IsActive = chkActive.Checked;
            db.SaveChanges();
            RadAjaxManager.ResponseScripts.Add(@"radalert('you have updated a doctor Successfully !!', 400, 135,'update Succeeded !!');");
        }
        protected void RadGridDoctors_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            TextBox txtUserName = e.Item.FindControl("txtUserName") as TextBox;
            TextBox txtPassword = e.Item.FindControl("txtPassword") as TextBox;
            CheckBox chkActive = e.Item.FindControl("chkActive") as CheckBox;
            if (userExisted(txtUserName.Text))
            {
                RadAjaxManager.ResponseScripts.Add(@"radalert('Doctor Name is Taken !!', 400, 135,'Adding Failed !!');");
                return;
            }
            Sec_Users doctor = new Sec_Users();
            doctor.Username = txtUserName.Text;
            doctor.password = txtPassword.Text;
            doctor.IsActive = chkActive.Checked;
            doctor.UserTypeId = 2;
            db.AddToSec_Users(doctor);
            db.SaveChanges();
            RadAjaxManager.ResponseScripts.Add(@"radalert('you have added a new doctor Successfully !!', 400, 135,'Adding Succeeded !!');");
        }
        protected void RadGridDoctors_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem dataItem = e.Item as GridEditableItem;
                int DoctorId = Convert.ToInt32(dataItem.GetDataKeyValue("id"));
                db.DeleteObject(getDoctorById(DoctorId));
                db.SaveChanges();
                RadAjaxManager.ResponseScripts.Add(@"radalert('you have deleted a doctor Successfully !!', 400, 135,'delete Succeeded !!');");
            }
            catch (Exception ex)
            {
                RadAjaxManager.ResponseScripts.Add(@"radalert('" + ex.Message + "', 400, 135,'delete failed !!');");
            }
        }
    }
}