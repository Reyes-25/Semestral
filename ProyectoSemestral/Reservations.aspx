<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Reservations.aspx.cs" Inherits="Reservations" %>
<%@ Register Src="~/HeaderControl.ascx" TagName="HeaderControl" TagPrefix="uc" %>

<!DOCTYPE html>
<html>
<head>
    <title>Mis Reservas</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 0;
        }
        .content {
            width: 90%;
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 20px;
        }
        asp\:Label {
            display: block;
            margin-bottom: 20px;
            font-weight: bold;
        }
        asp\:GridView {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 1rem;
            box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
        }
        asp\:GridView th, asp\:GridView td {
            text-align: left;
            padding: 12px;
            border: 1px solid #ddd;
        }
        asp\:GridView th {
            background-color: #2980b9;
            color: white;
        }
        asp\:GridView tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        asp\:GridView tr:hover {
            background-color: #dff9fb;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <uc:HeaderControl ID="HeaderControl" runat="server" />
        <div class="content">
            <h1>Mis Reservas</h1>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Visible="False" />
            <asp:GridView ID="gridReservas" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="ReservaID" HeaderText="ID Reserva" />
                    <asp:BoundField DataField="NombreHotel" HeaderText="Hotel" />
                    <asp:BoundField DataField="FechaEntrada" HeaderText="Fecha de Entrada" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="FechaSalida" HeaderText="Fecha de Salida" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="Estado" HeaderText="Estado" />
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
