using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class DailyReport : System.Web.UI.Page
{
    protected void btnGenerarReporte_Click(object sender, EventArgs e)
    {
        string fecha = txtFecha.Text.Trim(); 
        if (string.IsNullOrEmpty(fecha))
        {
            lblMessage.Text = "Por favor, ingrese una fecha válida."; 
            return;
        }
        
        string query = @"
            SELECT R.ReservaID, H.Nombre AS NombreHotel, R.FechaReserva, R.Estado 
            FROM Reservas R
            JOIN Hoteles H ON R.HotelID = H.HotelID
            WHERE CAST(R.FechaReserva AS DATE) = @Fecha";

        try
        {
            string connectionString = ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
                        
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Fecha", fecha);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();  
                da.Fill(dt); 

                if (dt.Rows.Count > 0)
                {
                    gridReporte.DataSource = dt;  
                    gridReporte.DataBind(); 
                    lblMessage.Text = "";  
                }
                else
                {
                    lblMessage.Text = "No se encontraron reservas para la fecha indicada."; // Mensaje cuando no hay resultados
                }
            }
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Error al generar el reporte: " + ex.Message;
        }
    }
}
