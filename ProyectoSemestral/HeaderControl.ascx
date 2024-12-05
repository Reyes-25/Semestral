<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="HeaderControl.ascx.cs" Inherits="ProyectoSemestral.HeaderControl" %>

<style>
    .header-container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        background-color: #007BFF;
        padding: 10px 20px;
        color: white;
        font-family: Arial, sans-serif;
    }

    .header-container .logo a {
        margin: 0;
        font-size: 24px;
        font-weight: bold;
        text-decoration: none;
        color: white;
    }

    .auth-section {
        display: flex;
        align-items: center;
        gap: 20px; 
    }

    .auth-section .menu-container {
        display: flex;
        align-items: center;  
        gap: 20px; 
    }

    .auth-section .menu {
        display: flex;
        gap: 20px;
        align-items: center;
    }

    .auth-section .menu-item {
        font-size: 16px;
        color: #ADD8E6; 
        cursor: pointer;
        font-weight: bold;
        transition: color 0.3s ease;
    }

    .auth-section .menu-item:hover {
        color: white; 
    }

    /* Estiliza el ícono del perfil */
    .auth-section .profile-icon {
        width: 40px;
        height: 40px;
        background-color: #fff;
        color: #007BFF;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 18px;
        font-weight: bold;
        border-radius: 50%;
        cursor: pointer;
    }

    /* Estilos para el botón de Cerrar sesión */
    .auth-section .btn-logout {
        background-color: transparent;
        border: none;
        color: #ADD8E6;
        cursor: pointer;
        font-size: 16px;
        font-weight: bold;
        transition: color 0.3s ease;
    }

    .auth-section .btn-logout:hover {
        color: white; 
    }
</style>

<div class="header-container">
    <div class="logo">
        <a href="Home.aspx">TravelsPTY</a>
    </div>
    <div class="auth-section">
        <asp:Panel ID="pnlLoggedOut" runat="server" Visible="true">
            <asp:Button ID="btnRegister" runat="server" Text="Registrar" CssClass="btn" OnClick="btnRegister_Click" />
            <asp:Button ID="btnLogin" runat="server" Text="Iniciar Sesión" CssClass="btn" OnClick="btnLogin_Click" />
        </asp:Panel>

        <asp:Panel ID="pnlLoggedIn" runat="server" Visible="false">
            <div class="menu-container">
                <div class="menu">
                    <span class="menu-item" onclick="window.location.href='<%= ResolveUrl("~/Reservations.aspx") %>'">Reservaciones</span>
                    <span class="menu-item" onclick="window.location.href='<%= ResolveUrl("~/DailyReport.aspx") %>'">Reporte Diario</span>
                    <asp:Button ID="btnLogout" runat="server" OnClick="Logout_Click" CssClass="btn-logout" Text="Cerrar Sesión" />
                </div>
                <div class="profile-icon" onclick="toggleMenu()">
                    <asp:Label ID="lblUserInitial" runat="server" Text="U"></asp:Label>
                </div>
            </div>
        </asp:Panel>
    </div>
</div>
