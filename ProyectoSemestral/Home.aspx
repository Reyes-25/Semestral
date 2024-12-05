<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" %>
<%@ Register Src="~/HeaderControl.ascx" TagName="HeaderControl" TagPrefix="uc" %>

<!DOCTYPE html>
<html>
<head>
    <title>TravelsPTY - Home</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f7f9fc;
            margin: 0;
            padding: 0;
        }
        h1 {
            text-align: center;
            margin: 20px 0;
            color: #2c3e50;
            font-size: 2.5rem;
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
        input[type="text"],
        button {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #dcdcdc;
            border-radius: 8px;
            box-sizing: border-box;
            font-size: 1rem;
        }
        button {
            background-color: #3498db;
            color: white;
            font-weight: bold;
            border: none;
            cursor: pointer;
            text-align: center;
            transition: all 0.3s ease;
        }
        button:hover {
            background-color: #1d6fa5;
        }
        .gridview-container table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            font-size: 1rem;
            box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.1);
        }
        .gridview-container th,
        .gridview-container td {
            text-align: left;
            padding: 12px;
            border: 1px solid #ddd;
        }
        .gridview-container th {
            background-color: #3498db;
            color: white;
            font-weight: bold;
        }
        .gridview-container tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .gridview-container tr:hover {
            background-color: #f9f9f9;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <uc:HeaderControl ID="HeaderControl" runat="server" />
        <div class="content">
            <h1>¡Bienvenido a TravelsPTY!</h1>
            <asp:Label ID="lblWelcome" runat="server" Text=""></asp:Label>
            <asp:TextBox ID="txtProvincia" runat="server" Placeholder="Ingrese la provincia" OnTextChanged="txtProvincia_TextChanged" AutoPostBack="True"></asp:TextBox>
            <asp:Button ID="btnBuscar" runat="server" Text="Buscar Hoteles" OnClick="btnBuscar_Click" />
            <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>

            <div class="gridview-container">
                <asp:GridView ID="gridHoteles" runat="server" AutoGenerateColumns="false" DataKeyNames="HotelID" OnRowCommand="gridHoteles_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="Nombre" HeaderText="Hotel" />
                        <asp:BoundField DataField="Direccion" HeaderText="Dirección" />
                        <asp:BoundField DataField="Telefono" HeaderText="Teléfono" />
                        <asp:ButtonField Text="Reservar" CommandName="Reservar" ButtonType="Button" />
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
