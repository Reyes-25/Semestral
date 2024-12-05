using System;
using System.Data.SqlClient;

public partial class Login : System.Web.UI.Page
{
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string password = txtPassword.Text.Trim();

        if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
        {
            lblError.Text = "Por favor, ingresa email y contraseña.";
            lblError.Visible = true;
            return;
        }

        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;

        try
        {
            string query = "SELECT UsuarioID, Nombre FROM Usuarios WHERE Email = @Email AND Password = @Password";
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);

                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        Session["UsuarioID"] = reader["UsuarioID"].ToString();
                        Session["UsuarioNombre"] = reader["Nombre"].ToString();
                                                
                        Response.Redirect("Reservations.aspx");
                    }
                    else
                    {
                        lblError.Text = "Credenciales incorrectas.";
                        lblError.Visible = true;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblError.Text = "Error al conectar con la base de datos.";
            lblError.Visible = true;
        }
    }
}
