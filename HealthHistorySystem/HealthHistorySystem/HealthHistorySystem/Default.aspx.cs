using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.IO;


namespace image_processing
{
    public partial class _Default : Page
    {
       // static Bitmap InputImage;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        Bitmap InputImage;
        Byte[] by = new Byte[100000];
        protected void btnPreview_Click(object sender, EventArgs e)
        {
           by= PhotoUpload.FileBytes;
                 Session["ImageBytes"] = by;
                 ImagePreview.ImageUrl = "~/ImageHandler.ashx";




                 //MemoryStream imgStream = new MemoryStream(PhotoUpload.FileBytes);
    
      
                 //InputImage = new Bitmap(imgStream);
        
    

        }

        protected void grayscale(object sender, EventArgs e)
        {
            ServiceReference1.Service1Client sv = new ServiceReference1.Service1Client();
         //   byte[] vv = PhotoUpload.FileBytes;
           Byte[] v= sv.SetGrayscale(PhotoUpload.FileBytes);

           Session["ImageBytes"] = v;
           ImagePreview.ImageUrl = "~/ImageHandler.ashx";

            
        }

    }
}