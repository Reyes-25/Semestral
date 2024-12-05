<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DailyReport.aspx.cs" Inherits="DailyReport" %>
<%@ Register Src="~/HeaderControl.ascx" TagName="HeaderControl" TagPrefix="uc" %>

<!DOCTYPE html>
<html>
<head>
    <title>Reporte Diario</title>
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
        input[type="text"] {
            width: 98%;
            padding: 10px;
            border: 1px solid #dcdcdc;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 1rem;
        }
        button {
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        button:hover {
            background-color: #1d6fa5;
        }
        asp\:GridView {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 1rem;
            box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
        }
        asp\:GridView th, asp\:GridView td {
            text-align: left;
            padding: 12px;
            border: 1px solid #ddd;
        }
        asp\:GridView th {
            background-color: #3498db;
            color: white;
        }
        asp\:GridView tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <uc:HeaderControl ID="HeaderControl" runat="server" />
        <div class="content">
            <h1>Reporte Diario de Reservas</h1>
            <asp:TextBox ID="txtFecha" runat="server" Placeholder="Ingrese la fecha (YYYY-MM-DD)"></asp:TextBox>
            <asp:Button ID="btnGenerarReporte" runat="server" Text="Generar Reporte" OnClick="btnGenerarReporte_Click" />
            <asp:GridView ID="gridReporte" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="ReservaID" HeaderText="ID Reserva" />
                    <asp:BoundField DataField="NombreHotel" HeaderText="Hotel" />
                    <asp:BoundField DataField="FechaReserva" HeaderText="Fecha de Reserva" DataFormatString="{0:dd/MM/yyyy}" />
                    <asp:BoundField DataField="Estado" HeaderText="Estado" />
                </Columns>
            </asp:GridView>
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />
        </div>
    </form>
</body>
</html>
