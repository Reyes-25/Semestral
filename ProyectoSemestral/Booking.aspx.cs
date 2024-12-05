using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

public partial class Booking : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string hotelID = Request.QueryString["HotelID"];
            if (!string.IsNullOrEmpty(hotelID))
            {
                CargarHabitaciones(hotelID);
            }
            else
            {
                lblError.Text = "No se ha recibido el ID del hotel.";
            }
        }
    }

    private void CargarHabitaciones(string hotelID)
    {
        string query = @"
            SELECT 
                h.Nombre AS NombreHotel, 
                hb.HabitacionID, 
                hb.Tipo, 
                hb.PrecioPorNoche
            FROM Habitaciones hb
            INNER JOIN Hoteles h ON hb.HotelID = h.HotelID
            WHERE hb.HotelID = @HotelID";

        try
        {
            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@HotelID", hotelID);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gridHabitaciones.DataSource = dt;
                gridHabitaciones.DataBind();
            }
        }
        catch (Exception ex)
        {
            lblError.Text = "Error al cargar las habitaciones: " + ex.Message;
        }
    }

    protected void gridHabitaciones_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DropDownList ddlCantidad = (DropDownList)e.Row.FindControl("ddlCantidad");
            if (ddlCantidad != null)
            {
                for (int i = 1; i <= 10; i++)
                {
                    ddlCantidad.Items.Add(new ListItem(i.ToString(), i.ToString()));
                }
            }
        }
    }

    protected void gridHabitaciones_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Reservar")
        {
            if (Session["UsuarioID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow row = gridHabitaciones.Rows[index];

            string hotelID = Request.QueryString["HotelID"];
            DateTime fechaEntrada = calFechaEntrada.SelectedDate;
            DateTime fechaSalida = calFechaSalida.SelectedDate;

            if (fechaEntrada == DateTime.MinValue || fechaSalida == DateTime.MinValue || fechaEntrada >= fechaSalida)
            {
                lblError.Text = "Selecciona fechas de entrada y salida válidas.";
                return;
            }

            int usuarioID = Convert.ToInt32(Session["UsuarioID"]);
            DropDownList ddlCantidad = (DropDownList)row.FindControl("ddlCantidad");
            if (ddlCantidad == null || string.IsNullOrEmpty(ddlCantidad.SelectedValue))
            {
                lblError.Text = "Por favor selecciona una cantidad de habitaciones.";
                return;
            }

            int cantidad = Convert.ToInt32(ddlCantidad.SelectedValue);
            int habitacionID = Convert.ToInt32(gridHabitaciones.DataKeys[index].Value);

            if (RegistrarReserva(usuarioID, hotelID, fechaEntrada, fechaSalida, habitacionID, cantidad))
            {
                Response.Redirect("Reservations.aspx");
            }
            else
            {
                lblError.Text = "Error al realizar la reserva.";
            }
        }
    }

    private bool RegistrarReserva(int usuarioID, string hotelID, DateTime fechaEntrada, DateTime fechaSalida, int habitacionID, int cantidad)
    {
        string queryReserva = @"
            INSERT INTO Reservas (UsuarioID, HotelID, FechaReserva, FechaEntrada, FechaSalida, Estado)
            OUTPUT INSERTED.ReservaID
            VALUES (@UsuarioID, @HotelID, @FechaReserva, @FechaEntrada, @FechaSalida, @Estado)";

        string queryReservaHabitaciones = @"
            INSERT INTO ReservasHabitaciones (ReservaID, HabitacionID, Cantidad)
            VALUES (@ReservaID, @HabitacionID, @Cantidad)";

        try
        {
            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString))
            {
                con.Open();
                SqlTransaction transaction = con.BeginTransaction();

                SqlCommand cmdReserva = new SqlCommand(queryReserva, con, transaction);
                cmdReserva.Parameters.AddWithValue("@UsuarioID", usuarioID);
                cmdReserva.Parameters.AddWithValue("@HotelID", hotelID);
                cmdReserva.Parameters.AddWithValue("@FechaReserva", DateTime.Now);
                cmdReserva.Parameters.AddWithValue("@FechaEntrada", fechaEntrada);
                cmdReserva.Parameters.AddWithValue("@FechaSalida", fechaSalida);
                cmdReserva.Parameters.AddWithValue("@Estado", "Confirmada");

                int reservaID = (int)cmdReserva.ExecuteScalar();

                SqlCommand cmdReservaHabitaciones = new SqlCommand(queryReservaHabitaciones, con, transaction);
                cmdReservaHabitaciones.Parameters.AddWithValue("@ReservaID", reservaID);
                cmdReservaHabitaciones.Parameters.AddWithValue("@HabitacionID", habitacionID);
                cmdReservaHabitaciones.Parameters.AddWithValue("@Cantidad", cantidad);
                cmdReservaHabitaciones.ExecuteNonQuery();

                transaction.Commit();
                return true;
            }
        }
        catch (Exception ex)
        {
            lblError.Text = "Error al registrar la reserva: " + ex.Message;
            return false;
        }
    }
}
