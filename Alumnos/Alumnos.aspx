<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="Alumnos.aspx.vb" Inherits="Alumnos_Alumnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <div class="jumbotron">
        <h1>ALUMNOS</h1>
        
        <td colspan="6">Nombre
            <asp:TextBox name="txtNombre" runat="server"></asp:TextBox>
            Apellido Paterno
            <asp:TextBox name="txtAPatareno" runat="server"></asp:TextBox>
            Apellido Materno
            <asp:TextBox name="txtAMaterno" runat="server"></asp:TextBox>
            
        </td>
    
        <p class="lead">SICE is a free web framework for building great Web sites and Web applications using HTML, CSS, and JavaScript.</p>
        <p><a  class="btn btn-primary btn-lg">Aceptar &raquo;</a></p>
    </div>
    <tr>
        <td>
            <asp:TextBox runat="server">Nombre</asp:TextBox>
        </td>
    </tr>   
</asp:Content>

