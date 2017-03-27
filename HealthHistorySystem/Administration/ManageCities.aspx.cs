using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;


namespace HealthHistorySystem
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        private HealthHistoryEntities db = new HealthHistoryEntities();
        private object GetCities()
        {
            var query = from cityRecord in db.Cities
                        select new
                        {
                            cityId = cityRecord.id,
                            cityName = cityRecord.name
                        };
            return query;
        }
        private City getCityById(int CityId)
        {
            var query = (from city in db.Cities
                         where city.id == CityId
                         select city).FirstOrDefault();
            return query;
        }
        private void insertCity(City city)
        {
            db.AddToCities(city);
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
            cities.Attributes["class"] = "active";
        }
        protected void CitiesRadGrid_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            CitiesRadGrid.DataSource = GetCities();

        }
        protected void CitiesRadGrid_InsertCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            TextBox txtCityName = e.Item.FindControl("txtCityName") as TextBox;
            City city = new City();
            city.name = txtCityName.Text;
            db.AddToCities(city);
            db.SaveChanges();
            RadAjaxManager.ResponseScripts.Add(@"radalert('you have deleted a new city successfuly !!', 400, 135,'adding succeeded !!');");
        }
        protected void CitiesRadGrid_UpdateCommand(object sender, Telerik.Web.UI.GridCommandEventArgs e)
        {
            GridEditableItem dataItem = e.Item as GridEditableItem;
            int CityId = Convert.ToInt32(dataItem.GetDataKeyValue("cityId"));
            TextBox txtCityName = e.Item.FindControl("txtCityName") as TextBox;
            City city = getCityById(CityId);
            city.name = txtCityName.Text;
            db.SaveChanges();
            RadAjaxManager.ResponseScripts.Add(@"radalert('you have updated a city successfuly !!', 400, 135,'update succeeded !!');");
        }
        protected void CitiesRadGrid_DeleteCommand(object sender, GridCommandEventArgs e)
        {
            try
            {
                GridEditableItem dataItem = e.Item as GridEditableItem;
                int CityId = Convert.ToInt32(dataItem.GetDataKeyValue("cityId"));
                City city = getCityById(CityId);
                db.DeleteObject(city);
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