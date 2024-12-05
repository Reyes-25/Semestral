<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>
<%@ Register Src="~/HeaderControl.ascx" TagName="HeaderControl" TagPrefix="uc" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 0;
        }
        .content {
            width: 400px;
            max-width: 90%;
            margin: 100px auto;
            padding: 20px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h1 {
            color: #2c3e50;
            margin-bottom: 20px;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #dcdcdc;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 1rem;
        }
        button {
            padding: 10px 20px;
            background-color: #27ae60;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 100%;
        }
        button:hover {
            background-color: #1e8449;
        }
        .register-link {
            display: block;
            margin-top: 15px;
            font-size: 0.9rem;
            color: #2980b9;
            text-decoration: none;
        }
        .register-link:hover {
            text-decoration: underline;
        }
        asp\:Label {
            margin-top: 10px;
            display: block;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <uc:HeaderControl ID="HeaderControl" runat="server" />
        <div class="content">
            <h1>Inicia Sesión</h1>
            <asp:TextBox ID="txtEmail" runat="server" Placeholder="Correo electrónico"></asp:TextBox>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" Placeholder="Contraseña"></asp:TextBox>
            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" />
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>

            <a class="register-link" href="Register.aspx">¿No tienes cuenta? Regístrate aquí.</a>
        </div>
    </form>
</body>
</html>
