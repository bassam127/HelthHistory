using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

namespace HealthHistorySystem
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        HealthHistoryEntities db = new HealthHistoryEntities();
        private object getProcessTypes()
        {
            var query = from process in db.Proc_Type
                        select new
                        {
                            processId = process.id,
                            processCatId = process.CategoryId,
                            categoryName = process.Proc_Category.name,
                            processName = process.name
                        };
            return query;
        }
        private object getProcessCategories()
        {
            var query = from ProcessCategory in db.Proc_Category
                        select new
                        {
                            id = ProcessCategory.id,
                            name = ProcessCategory.name
                        };
            return query;
        }
        private Proc_Type getProcessTypeById(int procTypeId)
        {
            var query = (from procType in db.Proc_Type
                         where procType.id == procTypeId
                         select procType).FirstOrDefault();
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
            process.Attributes["class"] = "active";
        }
        protected void RadGridProcessTypes_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            RadGridProcessTypes.DataSource = getProcessTypes();
        }
        protected void RadGridProcessTypes_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
        {
            if (e.Item is GridEditFormInsertItem && RadGridProcessTypes.MasterTableView.IsItemInserted)
            {
                RadComboBox cmbProcessCat = e.Item.FindControl("cmbProcessCat") as RadComboBox;
                cmbProcessCat.DataSource = getProcessCategories();
                cmbProcessCat.DataBind();

            }
            else // form template is in edit mode 
                if (e.Item is GridEditFormItem && e.Item.IsInEditMode)
                {
                    RadComboBox cmbProcessCat = e.Item.FindControl("cmbProcessCat") as RadComboBox;
                    cmbProcessCat.DataSource = getProcessCategories();
                    cmbProcessCat.DataBind();
                    TextBox txtProcessType = e.Item.FindControl("txtProcessType") as TextBox;
                    GridEditableItem dataItem = e.Item as GridEditableItem;
                    string processCatId = dataItem.GetDataKeyValue("processCatId").ToString();
                    cmbProcessCat.SelectedValue = dataItem.GetDataKeyValue("processCatId").ToString();
                }
        }
        protected void RadGridProcessTypes_InsertCommand(object sender, GridCommandEventArgs e)
        {
            RadComboBox cmbProcessCat = e.Item.FindControl("cmbProcessCat") as RadComboBox;
            TextBox txtProcessType = e.Item.FindControl("txtProcessType") as TextBox;
            if (cmbProcessCat.SelectedIndex != -1)
            {
                Proc_Type processType = new Proc_Type();
                processType.name = txtProcessType.Text;
                processType.CategoryId = Convert.ToInt32(cmbProcessCat.SelectedValue);
                db.AddToProc_Type(processType);
                db.SaveChanges();
                RadAjaxManager.ResponseScripts.Add(@"radalert('you have added a process type successfuly !!', 400, 135,'adding succeeded !!');");
            }
            else
                RadAjaxManager.ResponseScripts.Add(@"radalert('please check your entries !!', 400, 135,'adding failed !!');");
        }
        protected void RadGridProcessTypes_UpdateCommand(object sender, GridCommandEventArgs e)
        {
            RadComboBox cmbProcessCat = e.Item.FindControl("cmbProcessCat") as RadComboBox;
            TextBox txtProcessType = e.Item.FindControl("txtProcessType") as TextBox;
            GridEditableItem dateItem = e.Item as GridEditableItem;
            int ProcId = Convert.ToInt32(dateItem.GetDataKeyValue("processId"));
            Proc_Type processType = getProcessTypeById(ProcId);
            processType.name = txtProcessType.Text;
            processType.CategoryId = Convert.ToInt32(cmbProcessCat.SelectedValue);
            db.SaveChanges();
            RadAjaxManager.ResponseScripts.Add(@"radalert('you have updated a process type successfuly !!', 400, 135,'update succeeded !!');");
        }
        protected void RadGridProcessTypes_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem dateItem = e.Item as GridEditableItem;
                int ProcId = Convert.ToInt32(dateItem.GetDataKeyValue("processId"));
                Proc_Type processType = getProcessTypeById(ProcId);
                db.DeleteObject(processType);
                db.SaveChanges();
                RadAjaxManager.ResponseScripts.Add(@"radalert('you have deleted a process type successfuly !!', 400, 135,'delete succeeded !!');");
            }
            catch (Exception ex)
            {
                RadAjaxManager.ResponseScripts.Add(@"radalert('" + ex.Message + "', 400, 135,'delete failed !!');");
            }
        }
    }
}