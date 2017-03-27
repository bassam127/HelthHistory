using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace HealthHistorySystem
{
    public partial class WebForm11 : System.Web.UI.Page
    {
        HealthHistoryEntities db = new HealthHistoryEntities();
        private object getProcessTypeCategories()
        {
            var query = from processCategory in db.Proc_Category
                        select new
                        {
                            id = processCategory.id,
                            processCategoryName = processCategory.name,
                        };
            return query;
        }
        private Proc_Category getProcessCategoryById(int ProcessCategoryId)
        {
            var query = (from processCategory in db.Proc_Category
                         where processCategory.id == ProcessCategoryId
                         select processCategory).FirstOrDefault();
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
            processCategories.Attributes["class"] = "active";
        }
        protected void RadGridProcessCategories_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            RadGridProcessCategories.DataSource = getProcessTypeCategories();
        }
        protected void RadGridProcessCategories_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem dataItem = e.Item as GridEditableItem;
            Proc_Category processCategory = getProcessCategoryById(Convert.ToInt32(dataItem.GetDataKeyValue("id")));
            TextBox txtProcessCategoryName = e.Item.FindControl("txtProcessCategoryName") as TextBox;
            processCategory.name = txtProcessCategoryName.Text;
            db.SaveChanges();
            RadAjaxManager.ResponseScripts.Add(@"radalert('you have updated a process category successfuly !!', 400, 135,'update succeeded !!');");
        }
        protected void RadGridProcessCategories_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            TextBox txtProcessCategoryName = e.Item.FindControl("txtProcessCategoryName") as TextBox;
            Proc_Category processCategory = new Proc_Category();
            processCategory.name = txtProcessCategoryName.Text;
            db.AddToProc_Category(processCategory);
            db.SaveChanges();
            RadAjaxManager.ResponseScripts.Add(@"radalert('you have added a new process category successfuly !!', 400, 135,'adding succeeded !!');");
        }
        protected void RadGridProcessCategories_DeleteCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem dataItem = e.Item as GridEditableItem;
                db.DeleteObject(getProcessCategoryById(Convert.ToInt32(dataItem.GetDataKeyValue("id"))));
                db.SaveChanges();
                RadAjaxManager.ResponseScripts.Add(@"radalert('you have delete a process category successfuly !!', 400, 135,'delete succeeded !!');");
            }
            catch (Exception ex)
            {
                RadAjaxManager.ResponseScripts.Add(@"radalert('" + ex.Message + "', 400, 135,'delete failed !!');");
            }
        }
    }
}