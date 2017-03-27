using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace HealthHistorySystem
{
    public partial class WebForm12 : System.Web.UI.Page
    {
        HealthHistoryEntities db = new HealthHistoryEntities();
        private object getOrganizationTypes()
        {
            var query = from organization in db.OrganizationTypes
                        select new
                        {
                            id = organization.id,
                            OrganizationTypeName = organization.name,
                        };
            return query;
        }
        private OrganizationType getOrganizationTypeById(int organizationTypeId)
        {
            var query = (from organizationType in db.OrganizationTypes
                         where organizationType.id == organizationTypeId
                         select organizationType).FirstOrDefault();
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
            organizationTypes.Attributes["class"] = "active";
        }
        protected void RadGridOrganizationTypes_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            RadGridOrganizationTypes.DataSource = getOrganizationTypes();
        }
        protected void RadGridOrganizationTypes_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem dataItem = e.Item as GridEditableItem;
            TextBox txtOrganizationType = e.Item.FindControl("txtOrganizationType") as TextBox;
            OrganizationType organizationType = getOrganizationTypeById(Convert.ToInt32(dataItem.GetDataKeyValue("id")));
            organizationType.name = txtOrganizationType.Text;
            db.SaveChanges();
            RadAjaxManager.ResponseScripts.Add(@"radalert('you have updated an organization type successfuly !!', 400, 135,'update succeeded !!');");
        }
        protected void RadGridOrganizationTypes_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            TextBox txtOrganizationType = e.Item.FindControl("txtOrganizationType") as TextBox;
            OrganizationType organizationType = new OrganizationType();
            organizationType.name = txtOrganizationType.Text;
            db.AddToOrganizationTypes(organizationType);
            db.SaveChanges();
            RadAjaxManager.ResponseScripts.Add(@"radalert('you have added a new organization type successfuly !!', 400, 135,'adding succeeded !!');");
        }
        protected void RadGridOrganizationTypes_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem dataItem = e.Item as GridEditableItem;
                OrganizationType organizationType = getOrganizationTypeById(Convert.ToInt32(dataItem.GetDataKeyValue("id")));
                db.DeleteObject(organizationType);
                db.SaveChanges();
                RadAjaxManager.ResponseScripts.Add(@"radalert('you have deleted an organization type successfuly !!', 400, 135,'delete succeeded !!');");
            }
            catch (Exception ex)
            {
                RadAjaxManager.ResponseScripts.Add(@"radalert('" + ex.Message + "', 400, 135,'delete failed !!');");
            }
        }
    }
}