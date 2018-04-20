<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="PruebaAlumno.aspx.vb" Inherits="Alumnos_PruebaAlumno" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">



    <div id="fCatAlumnos" style="padding-top:30px">
<div class="titulo"                 
                style="background-color: #333333; color: #FFFFFF; font-family: 'Arial Black'; font-weight: bold; font-size: 12px;">
             <asp:Image ID="Image1" runat="server"
            ImageUrl="../images/gov.PNG" />ABC DE ALUMNOS</div>   
<table width="1200PX">
    <tr>
    <td>
        <ul>
        <li>
        
        <div>
            
        </div>
        </li>    
        </ul>
        </td>
        <td>
        <ul>
        <li>
        Nombre
        <div>
        <input type="text" id="txt_NombreAlumno" name="txt_NombreAlumno" runat="server" onclick="this.select();" onfocus="this.select();"
                style="text-transform: uppercase; width: 334px;" />            
        <input type="hidden" id="idTipoAlumno" name="idTipoAlumno" runat="server" value="0" />
        </div>
        </li>
        </ul>   
        </td>
        <td>
        <ul>
        <li>
        
        <div>
        
        
        </div>
        </li>
        </ul>   
        </td>
       
        <td style="vertical-align: middle; ">
        <div style="padding: 5px; float: left">
        <asp:ImageButton ID="ImageButton1" runat="server" 
                ImageUrl="~/Pics/reload.png" Height="30px" Width="30px" 
                ToolTip="Deshacer Filtros" />
        </div>
        <div style="padding: 5px; float: left">
        
        </div>
        <div style="padding: 5px; float: left">
       
        </div>
        </td>        
    </tr>
    <tr>
        <td>              
        
        </td>
        <td>
        <asp:Button id="btnBuscar" Text="Buscar" runat="server" CssClass="boton"/>
        &nbsp;</td>
        <td style="width:5px">
        <asp:DropDownList id="lstTope" runat="server" Enabled="true">
            <asp:ListItem Text= "5"></asp:ListItem>
            <asp:ListItem Text= "10"></asp:ListItem>
            <asp:ListItem Text= "20"></asp:ListItem>
            <asp:ListItem Text= "50"></asp:ListItem>
            <asp:ListItem Text= "100"></asp:ListItem>
        </asp:DropDownList>
        </td>
        <%--<td>
        <asp:Button id="btnRegresar" Text="Regresar" runat="server" CssClass="boton" />
        </td>
        <td>
        <asp:Button id="btnImprimir" Text="Imprimir" runat="server" CssClass="boton" />
        </td>    --%>    
    </tr>
</table>
</div>


    <p>
        &nbsp;</p>
    <p>
        ABC DE ALUMNOS<br />
    </p>
    <p>
        <table style="width: 100%; height: 76px;">
            <tr>
                <td>
                    <asp:Button ID="BtnAlta" runat="server" Text="ALTA" Width="118px" />
                &nbsp; abc de alumnos</td>
                <td>&nbsp;</td>
                
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="GridAlumnos" runat="server" Width="1096px">
                        <Columns>
                            <asp:BoundField HeaderText="Matricula" />
                            <asp:BoundField HeaderText="Nombre" />
                            <asp:BoundField HeaderText="Status" />
                            <asp:BoundField HeaderText="Dirección" />
                            <asp:BoundField HeaderText="TipoAlumno" />
                        </Columns>
                    </asp:GridView>
                </td>
                <td>&nbsp;</td>
                
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                
            </tr>
        </table>
    </p>
    <p>
    </p>



</asp:Content>

