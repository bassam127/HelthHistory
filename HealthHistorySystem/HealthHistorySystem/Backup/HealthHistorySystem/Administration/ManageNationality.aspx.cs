using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace HealthHistorySystem
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        private HealthHistoryEntities db = new HealthHistoryEntities();
        private object GetNationality()
        {
            var query = from nationalityRecord in db.Nationalities
                        select new
                        {
                            nationalityId = nationalityRecord.id,
                            nationalityName = nationalityRecord.name
                        };
            return query;
        }
        private Nationality getnationalityById(int nationalityId)
        {
            var query = (from nationality in db.Nationalities
                         where nationality.id == nationalityId
                         select nationality).FirstOrDefault();
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
            nationalities.Attributes["class"] = "active";
        }
        protected void RadGrid1_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {

            RadGridNationality.DataSource = GetNationality();
        }
        protected void RadGridNationality_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem dataItem = e.Item as GridEditableItem;
            int nationalityId = Convert.ToInt32(dataItem.GetDataKeyValue("nationalityId"));
            TextBox txtNationality = e.Item.FindControl("txtNationality") as TextBox;
            Nationality nationality = getnationalityById(nationalityId);
            nationality.name = txtNationality.Text;
            db.SaveChanges();
            RadAjaxManager.ResponseScripts.Add(@"radalert('you have updated a nationality successfuly !!', 400, 135,'update succeeded !!');");
        }
        protected void RadGridNationality_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            TextBox txtNationality = e.Item.FindControl("txtNationality") as TextBox;
            Nationality nationality = new Nationality();
            nationality.name = txtNationality.Text;
            db.AddToNationalities(nationality);
            db.SaveChanges();
            RadAjaxManager.ResponseScripts.Add(@"radalert('you have added a new nationality successfuly !!', 400, 135,'adding succeeded !!');");
        }
        protected void RadGridNationality_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem dataItem = e.Item as GridEditableItem;
                int nationalityId = Convert.ToInt32(dataItem.GetDataKeyValue("nationalityId"));
                Nationality nationality = getnationalityById(nationalityId);
                db.DeleteObject(nationality);
                db.SaveChanges();
                RadAjaxManager.ResponseScripts.Add(@"radalert('you have deleted a city successfuly !!', 400, 135,'delete succeeded !!');");
            }
            catch (Exception ex)
            {
                RadAjaxManager.ResponseScripts.Add(@"radalert('" + ex.Message + "', 400, 135,'delete failed !!');");
            }
        }
    }
}