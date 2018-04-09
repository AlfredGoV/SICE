<%@ Page Title="" Language="VB" MasterPageFile="~/Site.master" AutoEventWireup="false" CodeFile="c_TipoAlumnos_A.aspx.vb" Inherits="Alumnos_c_TipoAlumnos_A" EnableViewStateMac="False" validateRequest="false" enableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

 <style type="text/css">
    .hiddencol
    {
        display:none;
    }
    .viscol
    {
        display:block;
    }
</style>

<script type="text/javascript">
    var botonAceptar
    var grid2
    var idEval
    var usuario = "<%=Session("sUsuario")%>";
    var perfil = "<%=Session("sPerfil")%>";



    var ll_usuario = "<%= sUsuario %>";
    var ll_RFC = "<%= sRFC %>";
    var tipoXML = ""
    var ArchivoXML = ""


     function ImpCuentas() {   
            var ls_usuario = "<%=session("sUsuario")%>"
            var ls_usuarioGlobal = "<%=session("sUsuarioGlobal")%>"

            $.fancybox({
                'scrolling': 'yes',                
                'width': 700,
                'height': 200, 
                'transitionIn': 'elastic',
                'transitionOut': 'elastic',
                'titlePosition': 'inside',
                'type': 'iframe',
                'autoDimensions': 'true',
                'modal':'false',
                'hideOnOverlayClick':'false',
                'autoScale' : 'true',
                'centerOnScroll': 'true',
                'showCloseButton': false,
                'titleShow':'false',
                'enableEscapeButton' : 'false',
                'href': "co_ProgressBar.aspx?descripcion=CUENTAS&ejercicio=0&periodo=0&estado=REPORTADO&razon=0&agencia=0&sUsuario="+ls_usuario+"&sUsuarioGlobal="+ls_usuarioGlobal+"&archivo=CUENTAS&idhpol=0&registro=0",
                'onClosed': function () {
                    //tableView.rebind();
                }
            });
        }


    function onUpdating(){

            //alert("ENTRO AQUI");
        
            // get the update progress div
            var updateProgressDiv = $get('updateProgressDiv'); 
            // make it visible
            updateProgressDiv.style.display = '';

            //  get the gridview element        
            var gridView =  $get('<%= GridView1.ClientID %>');

           /* if (gridView)
                 alert("Tiene el grid");
            else
                alert("No lo tiene");*/
        
            // get the bounds of both the gridview and the progress div
            var gridViewBounds = Sys.UI.DomElement.getBounds(gridView);
            var updateProgressDivBounds = Sys.UI.DomElement.getBounds(updateProgressDiv);
        
            //    do the math to figure out where to position the element (the center of the gridview)
            var x = gridViewBounds.x + Math.round(gridViewBounds.width / 2) - Math.round(updateProgressDivBounds.width / 2);
            var y = gridViewBounds.y + Math.round(gridViewBounds.height / 2) - Math.round(updateProgressDivBounds.height / 2);
        
       
            //    set the progress element to this position
            Sys.UI.DomElement.setLocation (updateProgressDiv, x, y);        
        }

        function onUpdated() {
            // get the update progress div
            var updateProgressDiv = $get('updateProgressDiv'); 
            // make it invisible
            updateProgressDiv.style.display = 'none';
        }

        function BindGrid()
        {
         //var btnid = '<%=btnBuscar.UniqueID%>'
         //__doPostBack(btnid, "OnClick");
         document.getElementById('<%=btnBuscar.ClientID%>').click();
        }



         function OpenConsolidar(tipo) {
             $.fancybox({
                 'scrolling': 'yes',
                 'width': 700,
                 'height': 200,
                 'transitionIn': 'fade',
                 'transitionOut': 'fade',
                 'titlePosition': 'inside',
                 'type': 'iframe',
                 'href': "co_ProgressBar.aspx?descripcion=" + tipo + "&ejercicio=0&periodo=0&estado=REPORTADO&razon=" + ll_RFC + "&agencia=0&usuario=" + ll_usuario + "&archivo=" + tipo +  "&idhpol=0&registro=0",
                 'onClosed': function () {
                    BindGrid();
                 }
             });

         }




    function formatTitle(title, currentArray, currentIndex, currentOpts) {
        return '<div id="JQueryFTD_Demo-title"><span><input id="btnAceptar" class="boton" type="submit" accesskey="S" value="Aceptar" name="btnAceptar" onClick="CallIframe()"></span><span><input id="btnAceptar" class="boton" type="submit" accesskey="C" value="Cancel" name="btnCancel" onClick="closeFancy()"></span></div>';
    }


    function closeFancy() {
        parent.$.fancybox.close();

    }
    
    function CPerfil() {       

       if (perfil == "CONTAAUX"){
            hideAlta();   
            //disabledEdit();  
       }

        if (perfil == "CONTA"){             
            showAlta();
            //enabledEdit();
       }
    }
   
   function hideAlta()
    {
        for (i = 0; i < document.getElementsByTagName('div').length; i++) {
                if (document.getElementsByTagName('div').item(i).className == 'divLeft') {
                    document.getElementsByTagName('div').item(i).style.display = "none";
                }
            }
    }


     function showAlta()
    {
        for (i = 0; i < document.getElementsByTagName('div').length; i++) {
                if (document.getElementsByTagName('div').item(i).className == 'divLeft') {
                    document.getElementsByTagName('div').item(i).style.display = "block";
                }
            }
    }



    function disabledEdit()
    {
            for (i = 0; i < document.getElementsByTagName('a').length; i++) {
                if (document.getElementsByTagName('a').item(i).className == 'editlink') {
                    document.getElementsByTagName('a').item(i).style.disabled= true; 
                }
            }
    }

    function enabledEdit()
    {
        for (i = 0; i < document.getElementsByTagName('a').length; i++) {
                if (document.getElementsByTagName('a').item(i).className == 'editlink') {
                    document.getElementsByTagName('a').item(i).style.disabled= false;
                }
            }
    }

    function HideColumn(columnNo) {
        var dgTest = document.getElementById('<%= GridView1.ClientID %>');

        if (dgTest.rows.length > 1) {
            for (var i = 0; i < dgTest.rows.length; i++) {
               var column = dgTest.rows[i].cells[columnNo]
               if (column) {
                                   dgTest.rows[i].cells[columnNo].style.display = "none";
               } 
                
            }
        }

    }

    function ShowColumn(columnNo) {
        var dgTest = document.getElementById('<%= GridView1.ClientID %>');


        if (dgTest.rows.length > 1) {

            for (var i = 0; i < dgTest.rows.length; i++) {

                var column = dgTest.rows[i].cells[columnNo]
                if (column) {
                    dgTest.rows[i].cells[columnNo].style.display = "";
                } 

            }
        }

    }

    function Change(valor) {


        if (valor == "Ver Global") {

            HideColumn("5");
            ShowColumn("4");
        }
        else {
            HideColumn("4");
            ShowColumn("5");
        }

    }


    function OnSelectedIndexChange(oList) {

        var sValue = oList.options[oList.selectedIndex].value;

        if (sValue == "Local") {
//            HideColumn("5");
            ShowColumn("4");
        }

        if (sValue == "Global") {
//            ShowColumn("5");
            HideColumn("4");
        }
    }



    function expandcollapse(obj, row, valor) {

        var div = document.getElementById(obj);
        var img = document.getElementById('img' + obj);
        document.getElementById('<%= idEval.ClientID %>').value = valor;


        if (div.style.display == "none") {
            div.style.display = "block";
            if (row == 'alt') {
                img.src = "../images/Minus.ico";
            }
            else {
                img.src = "../images/Minus.ico";
            }
            img.alt = "Close to view other Customers";
        }
        else {
            div.style.display = "none";
            if (row == 'alt') {
                img.src = "../images/Plus.ico";
            }
            else {
                img.src = "../images/Plus.ico";
            }
            img.alt = "Expand to show Orders";
        }
    }



    function expandcollapseAll() {

        <%--var clienttype = document.getElementById('<%= hsleyenda.ClientID %>');--%>                
        var clienttype = "Mostrar"

        if (clienttype.innerHTML == "Mostrar") {
            clienttype.innerHTML = "Ocultar";
            
            for (i = 0; i < document.getElementsByTagName('div').length; i++) {
                if (document.getElementsByTagName('div').item(i).className == 'exapancontract') {
                    document.getElementsByTagName('div').item(i).style.display = "block";                   
                }
            }

            for (i = 0; i < document.getElementsByTagName('img').length; i++) {
                if (document.getElementsByTagName('img').item(i).className == 'imgdiv') {
                    document.getElementsByTagName('img').item(i).src = "../images/Minus.ico";
                }
            }    
        }

        else {
            clienttype.innerHTML = "Mostrar";
            
            for (i = 0; i < document.getElementsByTagName('div').length; i++) {
                if (document.getElementsByTagName('div').item(i).className == 'exapancontract') {
                    document.getElementsByTagName('div').item(i).style.display = "none";
                }
            }

            for (i = 0; i < document.getElementsByTagName('img').length; i++) {
                if (document.getElementsByTagName('img').item(i).className == 'imgdiv') {
                    document.getElementsByTagName('img').item(i).src = "../images/Plus.ico";
                }
            }       
        }
    }
   


    function OpenFancy(valor) {
        valor = valor + "&idEval=" + document.getElementById('<%= idEval.ClientID %>').value
        $.fancybox({
            'scrolling': 'no',
            'width': 790,
            'height': 320,
            'transitionIn': 'fade',
            'transitionOut': 'fade',
            'titlePosition': 'inside',
            'autoDimensions': 'true',
            'autoScale': 'true',
            'centerOnScroll': 'true',
            'enableEscapeButton': 'true',
            'type': 'iframe',
            'href': valor,
            'onClosed': function () { BindGrid(); }
        });
    }

    function OpenImport(valor) {       
        var ls_usuario = "<%=session("sUsuario")%>"
        var ls_usuarioGlobal = "<%=session("sUsuarioGlobal")%>" 
        $.fancybox({
            'scrolling': 'no',
            'width': 380,
            'height': 150,
            'transitionIn': 'fade',
            'transitionOut': 'fade',
            'titlePosition': 'inside',
            'autoDimensions': 'true',
            'autoScale': 'true',
            'centerOnScroll': 'true',
            'enableEscapeButton': 'true',
            'type': 'iframe',
            'href': valor+'&sUsuario='+ls_usuario+'&sUsuarioGlobal='+ls_usuarioGlobal,
            'onClosed': function () { BindGrid(); }
        });
    }


    function OpenConcentradora(valor) {
        $.fancybox({
            'scrolling': 'yes',
            'width': 700,
            'height': 400,
            'transitionIn': 'fade',
            'transitionOut': 'fade',
            'titlePosition': 'inside',
            'autoDimensions': 'true',
            'autoScale': 'true',
            'centerOnScroll': 'true',
            'enableEscapeButton': 'true',
            'type': 'iframe',
            'href': valor,
            'onClosed': function () {BindGrid(); }
        });
    }



    function doIt() { document.getElementById("form1").submit(); }

//    $(document).bind("ajaxStart.mine", function() {
//        $('#ajaxProgress').show();
//    });

//    $(document).bind("ajaxStop.mine", function() {
//        $('#ajaxProgress').hide();
//    });



    $(document).ready(function () {

    CPerfil();
        // Setup the ajax indicator  
        //$('body').append('<div id="ajaxBusy"><p><img src="~/images/ajax-loader.gif"></p></div>');  
        //$('#ajaxBusy').css({    display:"none",    margin:"0px",    paddingLeft:"0px",    paddingRight:"0px",    paddingTop:"0px",    paddingBottom:"0px",    position:"absolute",    right:"3px",    top:"3px",     width:"auto"  });});
        // Ajax activity indicator bound to ajax start/stop document events
        //$(document).ajaxStart(function(){ $('#ajaxBusy').show(); }).ajaxStop(function(){   $('#ajaxBusy').hide();});



        Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);

        function EndRequestHandler(sender, args) {

            $("#<%= ctalocal.ClientID %>").autocomplete('ConsultaCatalogo.ashx', {
                width: 420,
                max: 50,
                highlight: false,
                scroll: true,
                scrollHeight: 250,
                formatItem: function (data, i, n, value) {

                    var id = data[0];
                    var clave = data[1];
                    var nombre = data[2];
                    var padre = data[3];

                    return "<table><tr><td style='vertical-align: middle'><img style='display: inline-block; padding-left:5px; padding-right:5px' src='../images/Document_New.png' alt='' width='25' height='25'" + value + "'/></td><td><p style='display:inline-block'>Origen: <label title='" + padre + "'>" + padre.substring(0, 30) + "..." + "<br/>Clave: " + clave + "<br/>Nombre: <label title='" + nombre + "'>" + nombre.substring(0, 30) + "..." + "</label></p></td></tr></table>";


                    //return "<div><img style='display: inline-block; padding-left:5px; padding-right:5px' src='../images/Document_New.png' alt='' width='25' height='25'" + value + "'/><p style='display:inline-block'>Clave: " + clave + "<br/> Nombre: <label title='" + nombre + "'>" + nombre.substring(0, 30) + "..." + "</label></p></div>";
                },
                formatResult: function (data, value) {

                    //                    $("#idCTA").value = data[0];
                    return data[2];

                }
            });

            $("#<%= ctalocal.ClientID %>").result(function (event, data, formatted) {
                if (data) {

                    // Extract the data values
                    var id = data[0];
                    var clave = data[1];
                    var nombre = data[2];

                    $("#<%= idCTA.ClientID %>").val(id);
                }
            });

        }


        $("#<%= ctalocal.ClientID %>").autocomplete('ashx/ConsultaCatalogo.ashx', {
            width: 420,
            max: 10,
            highlight: false,
            scroll: true,
            scrollHeight: 250,
            formatItem: function (data, i, n, value) {

                var id = data[0];
                var clave = data[1];
                var nombre = data[2];
                var padre = data[3];

                return "<table><tr><td style='vertical-align: middle'><img style='display: inline-block; padding-left:5px; padding-right:5px' src='../images/Document_New.png' alt='' width='25' height='25'" + value + "'/></td><td><p style='display:inline-block'>Origen: <label title='" + padre + "'>" + padre.substring(0, 30) + "..." + "<br/>Clave: " + clave + "<br/>Nombre: <label title='" + nombre + "'>" + nombre.substring(0, 30) + "..." + "</label></p></td></tr></table>";

                //return "<div><img style='display: inline-block; padding-left:5px; padding-right:5px' src='../images/Document_New.png' alt='' width='25' height='25'" + value + "'/><p style='display:inline-block'>Clave: " + clave + "<br/> Nombre: <label title='" + nombre + "'>" + nombre.substring(0, 30) + "..." + "</label></p></div>";
            },
            formatResult: function (data, value) {

                //                    $("#idCTA").value = data[0];
                return data[2];

            }
        });

        $("#<%= ctalocal.ClientID %>").result(function (event, data, formatted) {
            if (data) {

                // Extract the data values
                var id = data[0];
                var clave = data[1];
                var nombre = data[2];

                $("#<%= idCTA.ClientID %>").val(id);
            }
        });



        $("#inForm").fancybox({
            'scrolling': 'no',
            'width': 890,
            'height': 280,
            'transitionIn': 'fade',
            'transitionOut': 'fade',
            'titlePosition': 'inside',
            'type': 'iframe',
            'href': "co_abcCuentas.aspx",
            'onClosed': function () { document.getElementById("form1").submit(); }
        });

        $("#inFormulario").fancybox({
            'scrolling': 'no',
            'width': 590,
            'height': 320,
            'transitionIn': 'fade',
            'transitionOut': 'fade',
            'titlePosition': 'inside',
            'type': 'inline',
            'onClosed': function () { parent.location.reload(true); }
        });

        grid2 = $("#GridView2");
    });


    function btnTipo_onclick() {

    }

</script>  

    <input type="hidden" id="idEval" name="idEval" runat="server" />

<div id="fCatCuentas" style="padding-top:30px">
<div class="titulo"                 
                style="background-color: #333333; color: #FFFFFF; font-family: 'Arial Black'; font-weight: bold; font-size: 12px;">
             <asp:Image ID="Image1" runat="server"
            ImageUrl="../images/gov.gif" />ABC DE CUENTAS LOCAL</div>   
<table width="1200PX">
    <tr>
    <td>
        <ul>
        <li>
        Nivel
        <div>
            <asp:DropDownList ID="DDLNivel" runat="server" Width="65">          
                <asp:ListItem Text="Todos" Value="" ></asp:ListItem>                
                <asp:ListItem Text="1" Value="1" Selected="True"></asp:ListItem>
                <asp:ListItem Text="2" Value="2"></asp:ListItem>                    
                <asp:ListItem Text="3" Value="3"></asp:ListItem>
                <asp:ListItem Text="4" Value="4"></asp:ListItem>
                <asp:ListItem Text="5" Value="5"></asp:ListItem>
                <asp:ListItem Text="6" Value="6"></asp:ListItem>
                <asp:ListItem Text="7" Value="7"></asp:ListItem>
                <asp:ListItem Text="8" Value="8"></asp:ListItem>
                <asp:ListItem Text="9" Value="9"></asp:ListItem>
                <asp:ListItem Text="10" Value="10"></asp:ListItem>
            </asp:DropDownList>
        </div>
        </li>    
        </ul>
        </td>
        <td>
        <ul>
        <li>
        Cuenta
        <div>
        <input type="text" id="ctalocal" name="ctalocal" runat="server" onclick="this.select();" onfocus="this.select();"
                style="text-transform: uppercase; width: 334px;" />            
        <input type="hidden" id="idCTA" name="idCTA" runat="server" value="0" />
        <%--<asp:TextBox id="TextBox2" runat="server" Width="300px"></asp:TextBox>--%>
        <%--<asp:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" ></asp:AutoCompleteExtender>--%>
        </div>
        </li>
        </ul>   
        </td>
        <td>
        <ul>
        <li>
        Naturaleza
        <div>
        <asp:DropDownList ID="DDLNaturaleza" runat="server">
        <asp:ListItem Text="Todos" Value="" Selected="True"></asp:ListItem>
        <asp:ListItem Text="Deudora" Value="Deudor"></asp:ListItem>
        <asp:ListItem Text="Acredora" Value="Acredor"></asp:ListItem>
        </asp:DropDownList>
        <%--<asp:AutoCompleteExtender ID="AutoCompleteExtender3" runat="server" ></asp:AutoCompleteExtender>--%>
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
        <asp:ImageButton ID="ImageButton2" runat="server" 
                ImageUrl="~/images/importar.png" Height="30px" Width="30px" 
                ToolTip="Importar Cuentas" OnClientClick="javascripr:OpenImport('co_abcImportExcel.aspx?sTipo=catalogo');  return false;" />
        </div>
        <div style="padding: 5px; float: left">
        <asp:ImageButton ID="ImageButton3" runat="server" 
                ImageUrl="~/images/concentradora.png" Height="30px" Width="30px" 
                ToolTip="Definir Cuenta Concentradora" OnClientClick="javascripr:OpenConcentradora('co_abcCtaConcentradora.aspx');  return false;" />
        </div>
        </td>        
    </tr>
    <tr>
        <td>              
        <input type="submit" id="btnAlta" name="btnAlta" runat="server" value="Alta" class="boton" onclick="OpenFancy('co_abcCuentas.aspx?idCTA=0&sTipo=Local'); return false;" />
        </td>
        <td>
        <asp:Button id="btnBuscar" Text="Buscar" runat="server" CssClass="boton"/>
        <input type ="button" id="exp" runat="server" class="boton"  value="GENERAR XML" onclick="javascript:OpenConsolidar('CATALOGO');" /> 
        </td>
        <td style="width:5px">
        <asp:DropDownList id="lstTope" runat="server" Enabled="true">
            <asp:ListItem Text= "5"></asp:ListItem>
            <asp:ListItem Text= "10"></asp:ListItem>
            <asp:ListItem Text= "20"></asp:ListItem>
           <%-- <asp:ListItem Text= "50"></asp:ListItem>--%>
            <%--<asp:ListItem Text= "1000"></asp:ListItem>--%>
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
<asp:UpdatePanel ID="UpdatePanel1" runat="server">
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="btnBuscar" EventName="Click" />
    </Triggers>
    <ContentTemplate>
    <asp:GridView ID="GridView1" runat="server" CellPadding="4" ForeColor="#333333" 
        GridLines="None" AllowPaging="True" 
        AutoGenerateColumns="False" DataSourceID="LinqDataSource1" 
        DataKeyNames="idCTA"  ShowFooter="True" Font-Size="X-Small" 
        Font-Names="Verdana" BorderStyle="Outset" PageSize="5" Width="99%">   
    <AlternatingRowStyle BackColor="White" />
        <Columns>            
            <asp:TemplateField ItemStyle-Width="40">
                <ItemTemplate> 
                   <a id="a1" class="editlink" href="#" onclick="javascript:OpenFancy('co_abcCuentas.aspx?idCTA=<%#Eval("idCTA")%>&sTipo=<%=ls_tipo%>')"><asp:Image ID="Image1" runat="server" ImageUrl="~/images/EDIT.GIF" Visible='<%# WhichDB() %>' Height="25" Width="25" BorderStyle="None"></asp:Image></a>                                  
                </ItemTemplate>
                <ItemStyle Width="40px" />
            </asp:TemplateField>            
            <asp:TemplateField>
                    <ItemTemplate>                        
                        <a href="javascript:expandcollapse('div<%# Eval("idCTA") %>', 'one', <%#Eval("idCTA")%>);">
                            <img id="imgdiv<%# Eval("idCTA") %>" class="imgdiv" alt="Click para mostrar/ocultar las cuentas heredadas <%# Eval("idCTA") %>"  width="10px" height="10px" border="0" src="../images/Plus.ico"/>
                        </a>                        
                    </ItemTemplate>
            </asp:TemplateField>
             <asp:BoundField DataField="Nivel" HeaderText="Nivel" 
                    SortExpression="Nivel" ItemStyle-Width="120" >
            </asp:BoundField>
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" 
                SortExpression="Nombre" ItemStyle-Width="300" >
            <ItemStyle Width="300px" />
            </asp:BoundField>
            
			<asp:BoundField DataField="Clave" HeaderText="Clave" 
                SortExpression="Clave" ItemStyle-Width="300" >            
            <ItemStyle Width="300px" />
            </asp:BoundField>                       
            
			<asp:BoundField DataField="Naturaleza" HeaderText="Naturaleza"
                    SortExpression = "Naturaleza" ItemStyle-Width= "300" >
					<ItemStyle Width="300px" />
			</asp:BoundField>			
                
            <asp:TemplateField HeaderText="Tipo" ItemStyle-Width="120">
                <ItemTemplate>
                    <%# ComputeEstadoF(Eval("EF"))%>
                </ItemTemplate>
                <ItemStyle Width="120px" />
            </asp:TemplateField>             
       
             <asp:TemplateField>
			        <ItemTemplate>
			            <tr>
                            <td colspan="8">                                
                                <div id="div<%# Eval("idCTA") %>" class="exapancontract" style="display:none;position:relative;left:15px;OVERFLOW: auto; WIDTH:97%; background-color: #CCCCCC;" >
                                <div id="divLeft" class="divLeft" style="float: left">
                                <input type="submit" id="btnAlta" name="btnAlta" value="+Agregar" style='<%# WhichDB2() %>' class="boton" onclick="OpenFancy('co_abcCuentas.aspx?idCTA=0&sTipo=<%=ls_tipo%>&nivel=<%#Eval("nivel")%>&cuentanum=<%#Eval("cuentanum")%>&idpadre=<%#Eval("idcta")%>'); return false;" /><label> NO CUENTA: <%#Eval("cuentanum")%></label>
                                </div>                                
                                   <asp:GridView ID="GridView2" AllowPaging="False" AllowSorting="true" BackColor="White" Width="100%" Font-Size="X-Small" AutoGenerateColumns="false" ForeColor="#333333"
                                            Font-Names="Verdana" runat="server" DataKeyNames="idCTA" ShowFooter="true" GridLines="None" EmptyDataRowStyle-BackColor="#FFFF66">
                                        <AlternatingRowStyle BackColor="White" />
                                        <Columns>                                             
                                          <asp:TemplateField ItemStyle-Width="40">
                                                <ItemTemplate> 
                                                   <a id="a1" class="editlink" href="#" onclick="javascript:OpenFancy('co_abcCuentas.aspx?idCTA=<%#Eval("idCTA")%>&sTipo=<%=ls_tipo%>')"><asp:Image ID="Image1" runat="server" Visible='<%# WhichDB() %>' ImageUrl="~/images/EDIT.GIF" Height="25" Width="25" BorderStyle="None"></asp:Image></a>                                  
                                                </ItemTemplate>
                                            </asp:TemplateField>                                            
                                            <asp:BoundField DataField="Nivel" HeaderText="Nivel" 
                                                SortExpression="Nivel" ItemStyle-Width="120" >
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Nombre" HeaderText="Nombre" 
                                                SortExpression="Nombre" ItemStyle-Width="200" />
                                            <asp:BoundField DataField="Clave" HeaderText="Clave" 
                                                SortExpression="Clave" ItemStyle-Width="200" />   
												
                                            <asp:BoundField DataField="Naturaleza" HeaderText="Naturaleza"
													 SortExpression = "Naturaleza" ItemStyle-Width = "200" />
													
				
			
                                         <asp:TemplateField HeaderText="Tipo" ItemStyle-Width="120">
                                                <ItemTemplate>
                                                    <%# ComputeEstadoF(Eval("EF"))%>
                                                </ItemTemplate>
                                                <ItemStyle Width="120px" />
                                            </asp:TemplateField>  

                                            
                                            <%-- <asp:TemplateField HeaderText="Saldo" ItemStyle-Width="120">
                                                <ItemTemplate>
                                                    <%# FormatCurrency(Convert.ToString(ComputeSaldos(Eval("idCTA")), New System.Globalization.CultureInfo("es-MX")))%>
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Right" Width="120"/>                                                 
                                            </asp:TemplateField>--%>
                                        </Columns>
                                         <EmptyDataTemplate>        
                                            No existen registros disponibles...
                                        </EmptyDataTemplate>
                                        <FooterStyle BackColor="#FFCC00" Font-Bold="True" ForeColor="White" />
                                        <HeaderStyle BackColor="#FFCC00" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="#FFCC00" ForeColor="White" HorizontalAlign="Center" />
                                        <RowStyle BackColor="#EFEFEF" />
                                        <SelectedRowStyle BackColor="#FFFF99" Font-Bold="True" ForeColor="#333333" />
                                        <SortedAscendingCellStyle BackColor="#F5F7FB" />
                                        <SortedAscendingHeaderStyle BackColor="#FFCC00" />
                                        <SortedDescendingCellStyle BackColor="#E9EBEF" />
                                        <SortedDescendingHeaderStyle BackColor="#FFCC00" />
                                   </asp:GridView>
                                </div>
                             </td>
                        </tr>
			        </ItemTemplate>			       
			    </asp:TemplateField>            
        </Columns>            
    <EmptyDataTemplate>        
        <div style='display:block; text-align:center; font-size:12px'><img style='padding-left:5px; padding-right:5px' src='../images/document_warning.png' alt='' width='125' height='125'/><h1>NO EXISTEN ELEMENTOS</h1><a href='co_rptPolizas.aspx?sResult=1'>¡ HAGA CLICK AQUI !, PARA BUSQUEDA SUGERIDA</a></div>
    </EmptyDataTemplate>
    <FooterStyle BackColor="#F8981D" Font-Bold="True" ForeColor="White" />
    <HeaderStyle BackColor="#F8981D" Font-Bold="True" ForeColor="White" />
    <PagerStyle BackColor="#F8981D" ForeColor="White" HorizontalAlign="Center" />
    <RowStyle BackColor="#EFEFEF" />
    <SelectedRowStyle BackColor="#FDE2C1" Font-Bold="True" ForeColor="#333333" />
    <SortedAscendingCellStyle BackColor="#F5F7FB" />
    <SortedAscendingHeaderStyle BackColor="#F8981D" />
    <SortedDescendingCellStyle BackColor="#E9EBEF" />
    <SortedDescendingHeaderStyle BackColor="#F8981D" />
    </asp:GridView>                     
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" 
        ContextTypeName="GoVirtualMCo.Internet" EnableDelete="True" 
        EnableInsert="True" EnableUpdate="True" EntityTypeName="" 
        TableName="tbco_catalogo" OrderBy="Nombre, Clave, Naturaleza, EF" 
        Where="Nivel == @Nivel">
        <WhereParameters>
            <asp:ControlParameter ControlID="DDLNivel" DefaultValue="1" Name="Nivel" 
                PropertyName="SelectedValue" Type="Int32" />
        </WhereParameters>
    </asp:LinqDataSource>
</ContentTemplate>
</asp:UpdatePanel>
<asp:UpdatePanelAnimationExtender ID="UpdatePanelAnimationExtender1" runat="server" TargetControlID="UpdatePanel1">
    <Animations>
        <OnUpdating>
            <Parallel duration="0">
                <%-- place the update progress div over the gridview control --%>
                <ScriptAction Script="onUpdating();" />  
                <%-- disable the search button --%>                       
                <EnableAction AnimationTarget="btnBuscar" Enabled="false" />
                <%-- fade-out the GridView --%>
                <FadeOut minimumOpacity=".5" />
             </Parallel>
        </OnUpdating>
        <OnUpdated>
            <Parallel duration="0">
                <%-- fade back in the GridView --%>
                <FadeIn minimumOpacity=".5" />
                <%-- re-enable the search button --%>  
                <EnableAction AnimationTarget="btnBuscar" Enabled="true" />
                <%--find the update progress div and place it over the gridview control--%>
                <ScriptAction Script="onUpdated();" /> 
            </Parallel> 
        </OnUpdated>
    </Animations>
</asp:UpdatePanelAnimationExtender>
<div id="updateProgressDiv" style="display: none; height: 40px; width: 40px; text-align:center; font-weight:bold; font-family:Arial Black; color:Black">      
    <img src="../images/ajax-loader.gif" alt="Cargando..." />
    Cargando... 
</div>

</asp:Content>

