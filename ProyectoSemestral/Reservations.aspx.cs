using System;
using System.Data;
using System.Data.SqlClient;

public partial class Reservations : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UsuarioID"] != null)
            {
                int usuarioID = Convert.ToInt32(Session["UsuarioID"]);
                CargarReservas(usuarioID);
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }
    }

    private void CargarReservas(int usuarioID)
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;

        try
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = @"
                SELECT 
                    r.ReservaID, 
                    h.Nombre AS NombreHotel, 
                    r.FechaEntrada, 
                    r.FechaSalida, 
                    r.Estado 
                FROM 
                    Reservas r
                INNER JOIN 
                    Hoteles h ON r.HotelID = h.HotelID
                WHERE 
                    r.UsuarioID = @UsuarioID";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UsuarioID", usuarioID);
                    con.Open();

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        if (dt.Rows.Count > 0)
                        {
                            gridReservas.DataSource = dt;
                            gridReservas.DataBind();
                        }
                        else
                        {
                            lblMessage.Text = "No tienes reservas registradas.";
                            lblMessage.Visible = true;
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Error al cargar las reservas: " + ex.Message;
            lblMessage.Visible = true;
        }
    }

}
