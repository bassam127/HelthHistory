using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace HealthHistorySystem
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        private HealthHistoryEntities db = new HealthHistoryEntities();
        private object getOrganizations()
        {
            var query = from organization in db.Organizations
                        select new
                        {
                            id = organization.id,
                            organizationTypeId = organization.orgtypeid,
                            name = organization.name,
                            address = organization.address,
                            phone = organization.phone,
                            mobile = organization.mobile,
                            email = organization.e_mail,
                            website = organization.website,
                        };
            return query;
        }
        private object getOrganizationTypes()
        {
            var query = from organizationType in db.OrganizationTypes
                        select new
                        {
                            id = organizationType.id,
                            name = organizationType.name
                        };
            return query;
        }
        private object getOrganizationUsers()
        {
            var query = from organizationUser in db.Sec_Users
                        select new
                        {
                            id = organizationUser.id,
                            name = organizationUser.Username,
                        };
            return query;
        }
        private Organization getOrganizationById(int OrganizationId)
        {
            var query = (from orgaization in db.Organizations
                         where orgaization.id == OrganizationId
                         select orgaization).FirstOrDefault();
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
            centers.Attributes["class"] = "active";
        }
        protected void RadGridCenters_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            RadGridCenters.DataSource = getOrganizations();
        }
        protected void RadGridCenters_InsertCommand(object sender, GridCommandEventArgs e)
        {
            RadComboBox cmbOrganizationType = e.Item.FindControl("cmbOrganizationType") as RadComboBox;
            TextBox txtOrgnizationName = e.Item.FindControl("txtOrgnizationName") as TextBox;
            TextBox txtOrganizationAddress = e.Item.FindControl("txtOrganizationAddress") as TextBox;
            TextBox txtOrganizationPhone = e.Item.FindControl("txtOrganizationPhone") as TextBox;
            TextBox txtOrganizationEmail = e.Item.FindControl("txtOrganizationEmail") as TextBox;
            TextBox txtOrganizationWebsite = e.Item.FindControl("txtOrganizationWebsite") as TextBox;
            TextBox txtOrganizationMobile = e.Item.FindControl("txtOrganizationMobile") as TextBox;
            Organization organization = new Organization();
            organization.orgtypeid = Convert.ToInt32(cmbOrganizationType.SelectedValue);
            organization.name = txtOrgnizationName.Text;
            organization.address = txtOrganizationAddress.Text;
            organization.phone = txtOrganizationPhone.Text;
            organization.mobile = txtOrganizationMobile.Text;
            organization.e_mail = txtOrganizationEmail.Text;
            organization.website = txtOrganizationWebsite.Text;
            db.AddToOrganizations(organization);
            db.SaveChanges();
            RadAjaxManager.ResponseScripts.Add(@"radalert('you have added a center successfuly !!', 400, 135,'adding succeeded !!');");
        }
        protected void RadGridCenters_ItemDataBound(object sender, GridItemEventArgs e)
        {
            //insert mode
            if (e.Item is GridEditFormInsertItem && RadGridCenters.MasterTableView.IsItemInserted)
            {
                RadComboBox cmbOrganizationType = e.Item.FindControl("cmbOrganizationType") as RadComboBox;
                cmbOrganizationType.DataSource = getOrganizationTypes();
                cmbOrganizationType.DataBind();
            }
            else
                if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
                {
                    RadComboBox cmbOrganizationType = e.Item.FindControl("cmbOrganizationType") as RadComboBox;
                    cmbOrganizationType.DataSource = getOrganizationTypes();
                    cmbOrganizationType.DataBind();
                    GridEditableItem dataItem = e.Item as GridEditableItem;
                    string organizationTypeId = dataItem.GetDataKeyValue("organizationTypeId").ToString();
                    cmbOrganizationType.SelectedValue = organizationTypeId;
                }
        }
        protected void RadGridCenters_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem dataItem = e.Item as GridEditableItem;
                int organizationId = Convert.ToInt32(dataItem.GetDataKeyValue("id"));
                Organization organization = getOrganizationById(organizationId);
                db.DeleteObject(organization);
                db.SaveChanges();
                RadAjaxManager.ResponseScripts.Add(@"radalert('you have deleted a center successfuly !!', 400, 135,'delete succeeded !!');");
            }
            catch (Exception ex)
            {
                RadAjaxManager.ResponseScripts.Add(@"radalert('" + ex.Message + "', 400, 135,'delete failed !!');");
            }
        }
        protected void RadGridCenters_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            RadComboBox cmbOrganizationType = e.Item.FindControl("cmbOrganizationType") as RadComboBox;
            TextBox txtOrgnizationName = e.Item.FindControl("txtOrgnizationName") as TextBox;
            TextBox txtOrganizationAddress = e.Item.FindControl("txtOrganizationAddress") as TextBox;
            TextBox txtOrganizationPhone = e.Item.FindControl("txtOrganizationPhone") as TextBox;
            TextBox txtOrganizationEmail = e.Item.FindControl("txtOrganizationEmail") as TextBox;
            TextBox txtOrganizationWebsite = e.Item.FindControl("txtOrganizationWebsite") as TextBox;
            TextBox txtOrganizationMobile = e.Item.FindControl("txtOrganizationMobile") as TextBox;
            GridEditableItem dataItem = e.Item as GridEditableItem;
            int organizationId = Convert.ToInt32(dataItem.GetDataKeyValue("id"));
            Organization organization = getOrganizationById(organizationId);
            organization.orgtypeid = Convert.ToInt32(cmbOrganizationType.SelectedValue);
            organization.name = txtOrgnizationName.Text;
            organization.address = txtOrganizationAddress.Text;
            organization.phone = txtOrganizationPhone.Text;
            organization.e_mail = txtOrganizationEmail.Text;
            organization.website = txtOrganizationWebsite.Text;
            organization.mobile = txtOrganizationMobile.Text;
            db.SaveChanges();
            RadAjaxManager.ResponseScripts.Add(@"radalert('you have updated a center successfuly !!', 400, 135,'update succeeded !!');");
        }

    }
}