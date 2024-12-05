using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class Home : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblWelcome.Text = "Explora los mejores hoteles en Panamá.";
        }
    }

    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        try
        {
            string provincia = txtProvincia.Text.Trim();
            string query = "SELECT HotelID, Nombre, Direccion, Telefono FROM Hoteles WHERE Provincia = @Provincia";

            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Provincia", provincia);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gridHoteles.DataSource = dt;
                gridHoteles.DataBind();
            }
        }
        catch (Exception ex)
        {
            lblError.Text = "Error: " + ex.Message;
        }
    }

    protected void txtProvincia_TextChanged(object sender, EventArgs e)
    {
        btnBuscar_Click(sender, e);
    }

    protected void gridHoteles_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Reservar")
        {
            int index = Convert.ToInt32(e.CommandArgument);

            string hotelID = gridHoteles.DataKeys[index].Value.ToString();

            Response.Redirect($"Booking.aspx?HotelID={hotelID}");
        }
    }

}
