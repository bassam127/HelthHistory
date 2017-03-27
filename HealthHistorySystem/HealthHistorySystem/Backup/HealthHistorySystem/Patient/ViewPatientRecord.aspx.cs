using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HealthHistorySystem
{
    public partial class WebForm8 : System.Web.UI.Page
    {
        HealthHistoryEntities db = new HealthHistoryEntities();
        private int getPatientIdByUserId(int userId)
        {
            var query = (from patient in db.Patients
                         where patient.UserId == userId
                         select patient.id).FirstOrDefault();
            return query;
        }
        private object getPatientInfo(int patientId)
        {
            var query = from patient in db.Patients
                        where patient.id == patientId
                        select new
                        {
                            patientName = patient.name,
                            motherName = patient.mothername,
                            nationality = patient.Nationality.name,
                            nationalityNo = patient.nationalityno,
                            city = patient.City.name,
                            address = patient.address,
                            phone = patient.phone,
                            mobile = patient.mobile
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
        private object getMedicinesById(int patientId)
        {
            var query = (from medicine in db.PatientMedicins
                         where medicine.patientid == patientId
                         select new
                         {
                             medicineName = medicine.medicinname,
                             fromDate = medicine.fromdate,
                             toDate = medicine.todate,
                             note = medicine.note
                         }).OrderBy(p => p.medicineName);
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
            patientRecord.Attributes["class"] = "active";
        }
        protected void RadListViewPatient_NeedDataSource(object sender, Telerik.Web.UI.RadListViewNeedDataSourceEventArgs e)
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
            RadListViewPatient.DataSource = getPatientInfo(getPatientIdByUserId(user.id));
        }
        protected void RadListViewPatientRegister_NeedDataSource(object sender, Telerik.Web.UI.RadListViewNeedDataSourceEventArgs e)
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
            RadListViewPatientRegister.DataSource = getPatientRegisterationsById(getPatientIdByUserId(user.id));
        }
        protected void RadListViewPatientMedicine_NeedDataSource(object sender, Telerik.Web.UI.RadListViewNeedDataSourceEventArgs e)
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
            RadListViewPatientMedicine.DataSource = getMedicinesById(getPatientIdByUserId(user.id));
        }
    }
}