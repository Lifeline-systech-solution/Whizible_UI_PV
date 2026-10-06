<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Drawing;
using System.Drawing.Imaging;
using System.Web;
using System.Security.Cryptography;
using System.Configuration;
using System.Text;
using System.Web.SessionState;
public class Handler : IHttpHandler, IRequiresSessionState
{
    
    public void ProcessRequest (HttpContext context) {
        //Added by Vaijat Kokate on 15 Sep 2015
        using (Bitmap b = new Bitmap(150, 40, PixelFormat.Format32bppArgb))
        {
            using (Graphics g = Graphics.FromImage(b))
            {
                Rectangle rect = new Rectangle(0, 0, 149, 39);
                g.FillRectangle(Brushes.White, rect);

                // Create string to draw.
                Random r = new Random();
                int startIndex = r.Next(1, 5);
                int length = r.Next(5, 10);
                String drawString = Guid.NewGuid().ToString().Replace("-", "0").Substring(startIndex, length);

                context.Session["drawString"] = drawString;
                // Create font and brush.
                Font drawFont = new Font("Microsoft Sans Serif", 16, FontStyle.Italic | FontStyle.Strikeout);
                using (SolidBrush drawBrush = new SolidBrush(Color.Black))
                {
                    // Create point for upper-left corner of drawing.
                    PointF drawPoint = new PointF(15, 10);
                   
                    // Draw string to screen.
                    g.DrawRectangle(new Pen(Color.LightSlateGray, 0), rect);
                  // g.DrawString(context.Request.QueryString["query"], drawFont, drawBrush, drawPoint);
                    g.DrawString(drawString, drawFont, drawBrush, drawPoint);
                   // HttpContext.Current.Session["captcha"] = drawString;
                }
                b.Save(context.Response.OutputStream, ImageFormat.Jpeg);
                context.Response.ContentType = "image/jpeg";
                context.Response.End();
            }
        }
        //End Added by Vaijat Kokate on 15 Sep 2015
    }
   
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}