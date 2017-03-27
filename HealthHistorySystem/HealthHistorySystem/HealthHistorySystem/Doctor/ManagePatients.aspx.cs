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
    public partial class WebForm6 : System.Web.UI.Page
    {
        private HealthHistoryEntities db = new HealthHistoryEntities();
        private object getPatients()
        {
            var query = from patientRecord in db.Patients
                        join cityRecord in db.Cities on patientRecord.cityid equals cityRecord.id
                        join nationalityRecord in db.Nationalities on patientRecord.natid equals nationalityRecord.id
                        select new
                        {
                            patientId = patientRecord.id,
                            patientName = patientRecord.name,
                            patientmother = patientRecord.mothername,
                            patientCityID = cityRecord.id,
                            patientcity = cityRecord.name,
                            patientnatid = patientRecord.natid,
                            patientnationality = nationalityRecord.name,
                            patientaddress = patientRecord.address,
                            patientphone = patientRecord.phone,
                            patientmobile = patientRecord.mobile,
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
        private object getprocessTypes()
        {
            var query = from process in db.Proc_Type
                        select new
                        {
                            id = process.id,
                            name = process.name,
                        };
            return query;
        }
        private object getOrganizations()
        {
            var query = from organization in db.Organizations
                        select new
                        {
                            id = organization.id,
                            name = organization.name,
                        };
            return query;
        }
        private object getPatientRegisterationsById(int patientId)
        {
            var query = (from patientReg in db.PatientRegs
                         where patientReg.patientid == patientId
                         select new
                         {
                             organization = patientReg.Organization.name,
                             processType = patientReg.Proc_Type.name,
                             processDate = patientReg.procdate,
                             processDescription = patientReg.procdesc
                         }).OrderBy(p => p.processDate);
            return query;
        }
        private int getPatientRegistrationsCount(int patientId)
        {
            var query = (from patientReg in db.PatientRegs
                         where patientReg.patientid == patientId
                         select new
                         {
                             organization = patientReg.Organization.name,
                             processType = patientReg.Proc_Type.name,
                             processDate = patientReg.procdate,
                             processDescription = patientReg.procdesc
                         }).Count();
            return query;
        }
        private object getMedicinesById(int patientId)
        {
            var query = from medicine in db.PatientMedicins
                        where medicine.patientid == patientId
                        select new
                        {
                            medicineName = medicine.medicinname,
                            fromDate = medicine.fromdate,
                            toDate = medicine.todate,
                            note = medicine.note
                        };
            return query;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] != null)
            {
                Sec_Users user = Session["user"] as Sec_Users;
                if (user.Sec_UserType.name.ToLower() != "doctor")
                {
                    Response.Redirect("~/Login.aspx");
                }
            }
            else
                if (Session["user"] == null)
                {
                    Response.Redirect("~/Login.aspx");
                }
            managePatients.Attributes.Add("class", "active managePatients");
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
            if (cmbCities.SelectedIndex != -1 && cmbNationalities.SelectedIndex != -1)
            {
                Sec_Users user = new Sec_Users();
                user.Username = txtPatientName.Text;
                user.password = Membership.GeneratePassword(6, 0);
                user.IsActive = true;
                user.UserTypeId = 1;
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

                RadAjaxManager.ResponseScripts.Add(@"radalert('you have added a new patient successfuly !!', 400, 135,'adding succeeded !!');");
            }
            else
                RadAjaxManager.ResponseScripts.Add(@"radalert('please check your entries !!', 400, 135,'adding failed !!');");
        }
        protected void RadGridPatients_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            // form template is in insert mode 
            if (e.Item is GridEditFormInsertItem && RadGridPatients.MasterTableView.IsItemInserted)
            {
                // fill in drop down lists with data 
                RadComboBox cmbCities = e.Item.FindControl("cmbCities") as RadComboBox;
                cmbCities.DataSource = getCities();
                cmbCities.DataBind();
                RadComboBox cmbNationalities = e.Item.FindControl("cmbNationalities") as RadComboBox;
                cmbNationalities.DataSource = getNationalities();
                cmbNationalities.DataBind();
                ImageButton btnAddProcess = e.Item.FindControl("btnAddProcess") as ImageButton;
                btnAddProcess.Visible = false;
            }
            else // form template is in edit mode 
                if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
                {
                    // fill in drop down lists with data 
                    RadComboBox cmbCities = e.Item.FindControl("cmbCities") as RadComboBox;
                    cmbCities.DataSource = getCities();
                    cmbCities.DataBind();
                    RadComboBox cmbNationalities = e.Item.FindControl("cmbNationalities") as RadComboBox;
                    cmbNationalities.DataSource = getNationalities();
                    cmbNationalities.DataBind();
                    // get patient city id from the edited item
                    GridEditableItem editItem = (GridEditableItem)e.Item;
                    cmbCities.SelectedValue = editItem.GetDataKeyValue("patientCityID").ToString();
                    cmbNationalities.SelectedValue = editItem.GetDataKeyValue("patientnatid").ToString();
                    RadComboBox cmbProcessTypes = e.Item.FindControl("cmbProcessTypes") as RadComboBox;
                    cmbProcessTypes.DataSource = getprocessTypes();
                    cmbProcessTypes.DataBind();
                    RadDatePicker dpProcessDate = e.Item.FindControl("dpProcessDate") as RadDatePicker;
                    dpProcessDate.MinDate = System.DateTime.Now;
                    RadComboBox cmbOrganizations = e.Item.FindControl("cmbOrganizations") as RadComboBox;
                    cmbOrganizations.DataSource = getOrganizations();
                    cmbOrganizations.DataBind();
                    Panel PatientProcessMedicine = e.Item.FindControl("PatientProcessMedicine") as Panel;
                    RadListView RadListViewPatientRegister = e.Item.FindControl("RadListViewPatientRegister") as RadListView;
                    RadListView RadListViewPatientMedicine = e.Item.FindControl("RadListViewPatientMedicine") as RadListView;
                    GridEditableItem dataItem = e.Item as GridEditableItem;
                    int PatientId = Convert.ToInt32(dataItem.GetDataKeyValue("patientId"));
                    if (getPatientRegistrationsCount(PatientId) > 0)
                    {
                        PatientProcessMedicine.Visible = true;
                        RadListViewPatientRegister.DataSource = getPatientRegisterationsById(PatientId);
                        RadListViewPatientMedicine.DataBind();
                        RadListViewPatientMedicine.DataSource = getMedicinesById(PatientId);
                        RadListViewPatientMedicine.DataBind();
                    }
                }
        }
        protected void RadGridPatients_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            GridEditableItem dataitem = e.Item as GridEditableItem;
            int patientId = Convert.ToInt32(dataitem.GetDataKeyValue("patientId"));
            TextBox txtPatientName = e.Item.FindControl("txtPatientName") as TextBox;
            TextBox txtMotherName = e.Item.FindControl("txtMotherName") as TextBox;
            RadComboBox cmbCities = e.Item.FindControl("cmbCities") as RadComboBox;
            RadComboBox cmbNationalities = e.Item.FindControl("cmbNationalities") as RadComboBox;
            TextBox txtAddress = e.Item.FindControl("txtAddress") as TextBox;
            TextBox txtPhone = e.Item.FindControl("txtPhone") as TextBox;
            TextBox txtMobile = e.Item.FindControl("txtMobile") as TextBox;
            TextBox txtNationalityNumber = e.Item.FindControl("txtNationalityNumber") as TextBox;
            Panel PatientRegPanel = e.Item.FindControl("PatientRegPanel") as Panel;

            if (cmbCities.SelectedIndex != -1 && cmbNationalities.SelectedIndex != -1)
            {
                Patient patient = getPatientById(patientId);
                patient.name = txtPatientName.Text;
                patient.mothername = txtMotherName.Text;
                patient.address = txtAddress.Text;
                patient.phone = txtPhone.Text;
                patient.mobile = txtMobile.Text;
                patient.cityid = Convert.ToInt32(cmbCities.SelectedValue);
                patient.natid = Convert.ToInt32(cmbNationalities.SelectedValue);
                patient.nationalityno = txtNationalityNumber.Text;
                db.SaveChanges();
                if (PatientRegPanel.Visible == true)
                {
                    RadComboBox cmbOrganizations = PatientRegPanel.FindControl("cmbOrganizations") as RadComboBox;
                    RadComboBox cmbProcessTypes = PatientRegPanel.FindControl("cmbProcessTypes") as RadComboBox;
                    RadDatePicker dpProcessDate = PatientRegPanel.FindControl("dpProcessDate") as RadDatePicker;
                    TextBox txtProcessDescription = PatientRegPanel.FindControl("txtProcessDescription") as TextBox;
                    TextBox txtMedicineName = PatientRegPanel.FindControl("txtMedicineName") as TextBox;
                    RadDatePicker dpFromDate = PatientRegPanel.FindControl("dpFromDate") as RadDatePicker;
                    RadDatePicker dpToDate = PatientRegPanel.FindControl("dpToDate") as RadDatePicker;
                    TextBox txtNote = PatientRegPanel.FindControl("txtNote") as TextBox;
                    PatientReg patientReg = new PatientReg();
                    patientReg.patientid = patientId;
                    patientReg.orgid = Convert.ToInt32(cmbOrganizations.SelectedValue);
                    patientReg.ProcTypeId = Convert.ToInt32(cmbProcessTypes.SelectedValue);
                    patientReg.procdate = dpProcessDate.SelectedDate;
                    patientReg.procdesc = txtProcessDescription.Text;
                    db.AddToPatientRegs(patientReg);
                    db.SaveChanges();
                    PatientMedicin medicine = new PatientMedicin();
                    medicine.opregid = patientReg.id;
                    medicine.patientid = patientId;
                    medicine.medicinname = txtMedicineName.Text;
                    medicine.fromdate = dpFromDate.SelectedDate;
                    medicine.todate = dpToDate.SelectedDate;
                    medicine.note = txtNote.Text;
                    db.AddToPatientMedicins(medicine);
                    db.SaveChanges();
                }
                RadAjaxManager.ResponseScripts.Add(@"radalert('you have updated a patient successfuly !!', 400, 135,'update succeeded !!');");
            }
            else
                RadAjaxManager.ResponseScripts.Add(@"radalert('please check your entries !!', 400, 135,'update failed !!');");


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
        protected void RadGridPatients_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "AddProcess")
            {
                ImageButton btnAddProcess = e.CommandSource as ImageButton;
                Panel PatientRegPanel = btnAddProcess.NamingContainer.FindControl("PatientRegPanel") as Panel;
                PatientRegPanel.Visible = !PatientRegPanel.Visible;
                btnAddProcess.Visible = false;
                Panel PatientProcessMedicine = btnAddProcess.FindControl("PatientProcessMedicine") as Panel;
                PatientProcessMedicine.Visible = false;
            }
        }

    }
}