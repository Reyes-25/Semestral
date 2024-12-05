<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Booking.aspx.cs" Inherits="Booking" %>
<%@ Register Src="~/HeaderControl.ascx" TagName="HeaderControl" TagPrefix="uc" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservar Habitaciones</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
        }
        .content {
            width: 90%;
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h1 {
            color: #34495e;
            margin-bottom: 20px;
            font-size: 1.8rem;
        }
        label {
            font-weight: bold;
            color: #2c3e50;
            display: block;
            margin-bottom: 10px;
        }
        .calendars-container {
            display: flex; /* Organiza los calendarios en un contenedor horizontal */
            justify-content: space-evenly; /* Distribuye los calendarios con espacio uniforme */
            align-items: center; /* Alinea verticalmente los calendarios */
            gap: 20px; /* Espaciado entre los calendarios */
            margin-bottom: 30px; /* Espaciado inferior del contenedor */
        }
        .calendar-wrapper {
            flex: 1; /* Ajusta el tamaño relativo de los calendarios */
            text-align: center;
        }
        asp\:Calendar {
            width: 250px; /* Ajusta el ancho de los calendarios */
            border: 1px solid #dcdcdc; /* Borde del calendario */
            border-radius: 8px; /* Bordes redondeados */
            padding: 10px;
            font-size: 0.9rem; /* Tamaño de la fuente */
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Sombra para más estilo */
            background-color: #ffffff; /* Fondo blanco */
        }
        asp\:GridView {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            font-size: 0.95rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            margin: 0 auto; /* Centra la tabla */
        }
        asp\:GridView th, asp\:GridView td {
            text-align: left;
            padding: 12px;
            border: 1px solid #ddd;
        }
        asp\:GridView th {
            background-color: #007bff;
            color: #fff;
            font-weight: bold;
        }
        asp\:GridView tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        asp\:GridView tr:hover {
            background-color: #f1f1f1;
        }
        asp\:DropDownList {
            width: 100%;
            padding: 5px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        asp\:Button {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        asp\:Button:hover {
            background-color: #218838;
        }
        .error-message {
            color: #e74c3c;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <uc:HeaderControl ID="HeaderControl" runat="server" />
        <div class="content">
            <h1>Reservar Habitaciones</h1>
            <asp:Label ID="lblError" runat="server" CssClass="error-message"></asp:Label>
            <div class="calendars-container">
                <div class="calendar-wrapper">
                    <label for="calFechaEntrada">Fecha de Entrada:</label>
                    <asp:Calendar ID="calFechaEntrada" runat="server"></asp:Calendar>
                </div>
                <div class="calendar-wrapper">
                    <label for="calFechaSalida">Fecha de Salida:</label>
                    <asp:Calendar ID="calFechaSalida" runat="server"></asp:Calendar>
                </div>
            </div>
            <asp:GridView ID="gridHabitaciones" runat="server" AutoGenerateColumns="False" 
                OnRowCommand="gridHabitaciones_RowCommand" 
                OnRowDataBound="gridHabitaciones_RowDataBound" 
                DataKeyNames="HabitacionID">
                <Columns>
                    <asp:BoundField DataField="NombreHotel" HeaderText="Nombre del Hotel" />
                    <asp:BoundField DataField="Tipo" HeaderText="Tipo de Habitación" />
                    <asp:BoundField DataField="PrecioPorNoche" HeaderText="Precio por Noche" DataFormatString="{0:C}" />

                    <asp:TemplateField HeaderText="Cantidad de Habitaciones">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlCantidad" runat="server"></asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnReservar" runat="server" Text="Reservar" 
                                CommandName="Reservar" 
                                CommandArgument="<%# Container.DataItemIndex %>" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </form>
</body>
</html>
