using System;
using System.Data.SqlClient;

public partial class Register : System.Web.UI.Page
{
    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        // Obtener datos del formulario
        string nombre = txtNombre.Text.Trim();
        string email = txtEmail.Text.Trim();
        string telefono = txtTelefono.Text.Trim();
        string password = txtPassword.Text.Trim(); 

        
        if (string.IsNullOrEmpty(nombre) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(telefono) || string.IsNullOrEmpty(password))
        {
            lblMessage.Text = "Por favor, completa todos los campos.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;

        try
        {
            string query = "INSERT INTO Usuarios (Nombre, Email, Telefono, Password) VALUES (@Nombre, @Email, @Telefono, @Password)";

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@Nombre", nombre);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Telefono", telefono);
                    cmd.Parameters.AddWithValue("@Password", password);

                    con.Open();
                    cmd.ExecuteNonQuery();

                    lblMessage.Text = "Registro exitoso. Ahora puedes iniciar sesión.";
                    lblMessage.ForeColor = System.Drawing.Color.Green;

                    txtNombre.Text = string.Empty;
                    txtEmail.Text = string.Empty;
                    txtTelefono.Text = string.Empty;
                    txtPassword.Text = string.Empty;
                }
            }
        }
        catch (Exception ex)
        {
            lblMessage.Text = "Error al registrar usuario: " + ex.Message;
            lblMessage.ForeColor = System.Drawing.Color.Red;
        }
    }
}
