<%@ Language=VBScript %>
<%
' Validacion de entrada del Usuario
option explicit
Response.Buffer = true
%>
<% Response.AddHeader "pragma", "no-cache" 
Response.CacheControl = "Private" 
Response.Expires = -60 %> 

<!-- #include file="includes/frames.inc"-->
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<%
dim giError
dim gsError

dim sUsuario
dim sPassword
dim msecPageLoad


sUsuario	= UCase(request("txtUsuario"))
sPassword	= UCase(request("txtPassword"))
Response.write sUsuario
Response.write sPassword
function entraUSUA ()	

	on error resume next
		dim sError	
		if len(trim(sUsuario)) = 0 then
			giError = 70010
			entraUSUA = "Debe digitar el usuario"
			exit function
		end if	
		if len(trim(sPassword)) = 0 then
			giError = 70011
			entraUSUA = "Debe digitar el password"
			exit function
		end if
		
		dim objCls_Usuario
    	set objCls_Usuario = server.CreateObject("egac.cls_usuario")
		if err.number <> 0 then
			entraUSUA	= Err.description
			giError		= err.number
			GetObjectContext.SetAbort
			err.clear
			set objCls_Usuario = nothing
			exit function
		end if 					
		dim opRS	
		
		set opRS = objCls_Usuario.ValidaUsuario(cstr(sUsuario),cstr(sPassword))
		if err.number <> 0 then		
			Response.write Err.description 
			entraUSUA	= Err.description 
			giError		= err.number    
			GetObjectContext.SetAbort
			err.clear
			set objCls_Usuario = nothing
			exit function
		end if		
		'Entrada de variables de session
		if not opRS.EOF then
			giError		= opRS.Fields(0).Value			
			entraUSUA	= opRS.Fields(1).Value			
			if giError = 0 then
				sUsuario=opRS.Fields("usuario").Value 'Esta asignación es por si se logeo con usuariologin, para que se asigne el usuario convencional de 6 caracteres en su lugar
				session("sUsuario") = opRS.Fields("usuario").Value
				Session("sEmpresa")	= opRS.Fields(2).Value
				Session("sSucursal")= opRS.Fields(3).Value
				Session("sPerfil")	= opRS.Fields(4).Value
				Session("sIdioma")	= opRS.Fields(5).Value
				Session("dMaxAutorizar")= opRS.Fields("MaxAutorizar").Value
				Session("iNivel")= opRS.Fields("Nivel").Value
				session("sUsuarioGlobal") = opRS.Fields("UsuarioGlobal").Value
				session("noSucursales") = opRS.Fields("noSucursales").Value
				session("CveSucursal") = opRS.Fields("CveSucursal").Value
				session("DescSucursal") = opRS.Fields("DescSucursal").Value
				session("UsarCentral") = opRS.Fields("UsarCentral").Value
                session("idSucursalCm") = opRS.Fields("idSucursalCm").Value
				session("sRuta") = opRS.Fields("Ruta").Value
                session("Ciudad") = opRS.Fields("Ciudad").Value
                session("Distribuidor") = opRS.Fields("Distribuidor").Value
				session("TipoMarca") = opRS.Fields("TipoMarca").Value
			end if			
		end if
		
  		set objCls_Usuario = nothing
		set opRS = nothing
end function

gsError = entraUSUA ()
if gsError = "Expirado" then
	'Response.Redirect "index.asp?iEntra=1"
	Response.Redirect "CambioPassword.asp?iEntra=1&strUsuario="&cstr(sUsuario)
    
	Response.Redirect "loginMultiempresa.asp?iEntra=1"

elseif len(trim(gsError)) <> 0 then
   Response.Redirect "Error.asp?ierror=" & giError & "&sError=" & server.URLEncode(gsError)& "&iME=1"
else
	if trim(Session("sPerfil"))="POCKETS" then
		Response.Redirect "catPocket/SE1_a_tbse_MenuServicio.asp"
	else
		'Response.Redirect "index.asp?iEntra=0"
		if session("noSucursales")>1 then
			Response.Redirect "loginMultiempresa.asp?iEntra=0"'
		else
			Response.Redirect  "ValidaUsuario.asp?txtVariable=12345678998765432112345678987654321&txtUsuario="&cstr(sUsuario)
		'Response.Redirect "index.asp?iEntra=0"
		end if
	end if		
end if

%>
</BODY>
</HTML>