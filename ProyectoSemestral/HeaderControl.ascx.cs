using System;
using System.Web;
using System.Web.UI;

namespace ProyectoSemestral
{
    public partial class HeaderControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                UpdateUserState();
            }
        }

        private void UpdateUserState()
        {
            if (Session["UsuarioNombre"] != null)
            {                
                pnlLoggedOut.Visible = false;
                pnlLoggedIn.Visible = true;

                lblUserInitial.Text = Session["UsuarioNombre"].ToString()[0].ToString().ToUpper();
            }
            else
            {
                pnlLoggedOut.Visible = true;
                pnlLoggedIn.Visible = false;
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Register.aspx");
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Login.aspx");
        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Abandon(); 

            Response.Redirect("~/Home.aspx"); 
        }

        protected void Reservations_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Reservations.aspx");
        }

        protected void DailyReport_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/DailyReport.aspx");
        }
    }
}
