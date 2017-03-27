using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Web.Security;

namespace HealthHistorySystem
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        private HealthHistoryEntities db = new HealthHistoryEntities();
        private bool userExisted(string name)
        {
            var query = db.Sec_Users.Where(p => p.Username.ToLower() == name.ToLower()).Any();
            return query;
        }
        private Sec_Users getUser(int? UserId)
        {
            var query = (from user in db.Sec_Users
                         where user.id == UserId
                         select user).FirstOrDefault();
            return query;

        }
        private object getPatients()
        {
            var query = from patientRecord in db.Patients
                        where patientRecord.Sec_Users.UserTypeId == 1
                        select new
                        {
                            patientId = patientRecord.id,
                            patientCityID = patientRecord.City.id,
                            patientnatid = patientRecord.natid,
                            patientName = patientRecord.name,
                            patientmother = patientRecord.mothername,
                            patientcity = patientRecord.City.name,
                            patientnationality = patientRecord.Nationality.name,
                            patientaddress = patientRecord.address,
                            patientphone = patientRecord.phone,
                            patientmobile = patientRecord.mobile,
                            userName = patientRecord.Sec_Users.Username,
                            password = patientRecord.Sec_Users.password,
                            NationalityNo = patientRecord.nationalityno,
                        };
            return query;
        }
        private object getCities()
        {
            var query = from cityRecord in db.Cities
                        select new
                        {
                            cityID = cityRecord.id,
                            cityName = cityRecord.name
                        };
            return query;
        }
        private object getNationalities()
        {
            var query = from nationalityRecord in db.Nationalities
                        select new
                        {
                            nationalityID = nationalityRecord.id,
                            natioalityName = nationalityRecord.name
                        };
            return query;
        }
        private Patient getPatientById(int patientId)
        {
            var query = (from patientRecord in db.Patients
                         where patientRecord.id == patientId
                         select patientRecord).FirstOrDefault();
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
            patients.Attributes["class"] = "active";
        }
        protected void RadGridPatients_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            RadGridPatients.DataSource = getPatients();
        }
        protected void RadGridPatients_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            TextBox txtPatientName = e.Item.FindControl("txtPatientName") as TextBox;
            TextBox txtMotherName = e.Item.FindControl("txtMotherName") as TextBox;
            RadComboBox cmbCities = e.Item.FindControl("cmbCities") as RadComboBox;
            RadComboBox cmbNationalities = e.Item.FindControl("cmbNationalities") as RadComboBox;
            TextBox txtAddress = e.Item.FindControl("txtAddress") as TextBox;
            TextBox txtPhone = e.Item.FindControl("txtPhone") as TextBox;
            TextBox txtMobile = e.Item.FindControl("txtMobile") as TextBox;
            TextBox txtNationalityNumber = e.Item.FindControl("txtNationalityNumber") as TextBox;
            Sec_Users user = new Sec_Users();
            if (cmbCities.SelectedIndex != -1 && cmbNationalities.SelectedIndex != -1)
            {
                user.Username = txtPatientName.Text;
                user.IsActive = true;
                user.UserTypeId = 1;
                user.password = Membership.GeneratePassword(6, 0);
                if (userExisted(txtPatientName.Text))
                {
                    RadAjaxManager.ResponseScripts.Add(@"radalert('Patient Name is Taken !!', 400, 135,'Adding Failed !!');");
                    return;
                }
                db.AddToSec_Users(user);
                db.SaveChanges();
                Patient patient = new Patient();
                patient.name = txtPatientName.Text;
                patient.mothername = txtMotherName.Text;
                patient.address = txtAddress.Text;
                patient.phone = txtPhone.Text;
                patient.mobile = txtMobile.Text;
                patient.cityid = Convert.ToInt32(cmbCities.SelectedValue);
                patient.natid = Convert.ToInt32(cmbNationalities.SelectedValue);
                patient.UserId = user.id;
                patient.nationalityno = txtNationalityNumber.Text;
                db.AddToPatients(patient);
                db.SaveChanges();
                RadAjaxManager.ResponseScripts.Add(@"radalert('Adding Succeeded !!', 400, 135,'Adding Succeeded !!');");
            }
            else
                RadAjaxManager.ResponseScripts.Add(@"radalert('please check your entries !!', 400, 135,'update failed !!');");
        }
        protected void RadGridPatients_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            // form template is in insert mode 
            if (e.Item is GridEditFormInsertItem && RadGridPatients.MasterTableView.IsItemInserted)
            {
                RadComboBox cmbCities = e.Item.FindControl("cmbCities") as RadComboBox;
                cmbCities.DataSource = getCities();
                cmbCities.DataBind();
                RadComboBox cmbNationalities = e.Item.FindControl("cmbNationalities") as RadComboBox;
                cmbNationalities.DataSource = getNationalities();
                cmbNationalities.DataBind();
                Panel patientPasswordPanel = e.Item.FindControl("patientPasswordPanel") as Panel;
                patientPasswordPanel.Visible = false;
            }
            else
                if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
                {
                    RadComboBox cmbCities = e.Item.FindControl("cmbCities") as RadComboBox;
                    cmbCities.DataSource = getCities();
                    cmbCities.DataBind();
                    RadComboBox cmbNationalities = e.Item.FindControl("cmbNationalities") as RadComboBox;
                    cmbNationalities.DataSource = getNationalities();
                    cmbNationalities.DataBind();
                    CheckBox chkActive = e.Item.FindControl("chkActive") as CheckBox;
                    GridEditableItem dataItem = e.Item as GridEditableItem;
                    int PatientId = Convert.ToInt32(dataItem.GetDataKeyValue("patientId"));
                    chkActive.Checked = db.Patients.Where(p => p.id == PatientId).Any(p => p.Sec_Users.IsActive == true);
                    GridEditableItem editItem = e.Item as GridEditableItem;
                    string patientCityID = editItem.GetDataKeyValue("patientCityID").ToString();
                    cmbCities.SelectedValue = editItem.GetDataKeyValue("patientCityID").ToString();
                    cmbNationalities.SelectedValue = editItem.GetDataKeyValue("patientnatid").ToString();

                }
        }
        protected void RadGridPatients_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem dataitem = e.Item as GridEditableItem;
            if (dataitem != null)
            {
                int patientId = Convert.ToInt32(dataitem.GetDataKeyValue("patientId"));
                Patient patient = getPatientById(patientId);
                TextBox txtPatientName = e.Item.FindControl("txtPatientName") as TextBox;
                TextBox txtMotherName = e.Item.FindControl("txtMotherName") as TextBox;
                RadComboBox cmbCities = e.Item.FindControl("cmbCities") as RadComboBox;
                RadComboBox cmbNationalities = e.Item.FindControl("cmbNationalities") as RadComboBox;
                TextBox txtAddress = e.Item.FindControl("txtAddress") as TextBox;
                TextBox txtPhone = e.Item.FindControl("txtPhone") as TextBox;
                TextBox txtMobile = e.Item.FindControl("txtMobile") as TextBox;
                TextBox txtPatientPassword = e.Item.FindControl("txtPatientPassword") as TextBox;
                TextBox txtNationalityNumber = e.Item.FindControl("txtNationalityNumber") as TextBox;
                CheckBox chkActive = e.Item.FindControl("chkActive") as CheckBox;
                if (cmbCities.SelectedIndex != -1 && cmbNationalities.SelectedIndex != -1)
                {
                    patient.name = txtPatientName.Text;
                    patient.mothername = txtMotherName.Text;
                    patient.address = txtAddress.Text;
                    patient.phone = txtPhone.Text;
                    patient.mobile = txtMobile.Text;
                    patient.cityid = Convert.ToInt32(cmbCities.SelectedValue);
                    patient.natid = Convert.ToInt32(cmbNationalities.SelectedValue);
                    patient.nationalityno = txtNationalityNumber.Text;
                    int? UserId = patient.UserId;
                    Sec_Users user = getUser(UserId);
                    user.Username = txtPatientName.Text;
                    user.password = txtPatientPassword.Text;
                    user.IsActive = chkActive.Checked;
                    db.SaveChanges();
                    RadAjaxManager.ResponseScripts.Add(@"radalert('you have updated an existing patient successfuly !!', 400, 135,'update succeeded !!');");
                }
                else
                    RadAjaxManager.ResponseScripts.Add(@"radalert('please check your entries !!', 400, 135,'update failed !!');");
            }
        }
        protected void RadGridPatients_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem editItem = e.Item as GridEditableItem;
                int patientId = Convert.ToInt32(editItem.GetDataKeyValue("patientId"));
                Patient patient = getPatientById(patientId);
                db.DeleteObject(patient);
                db.SaveChanges();
                RadAjaxManager.ResponseScripts.Add(@"radalert('you have deleted a patient successfuly !!', 400, 135,'delete succeeded !!');");
            }
            catch (Exception ex)
            {
                RadAjaxManager.ResponseScripts.Add(@"radalert('" + ex.Message + "', 400, 135,'delete failed !!');");
            }
        }
    }
}