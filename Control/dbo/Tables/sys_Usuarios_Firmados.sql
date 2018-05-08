CREATE TABLE [dbo].[sys_Usuarios_Firmados] (
    [Usuario]         VARCHAR (6)  NOT NULL,
    [Fecha]           INT          NULL,
    [Hora]            INT          NULL,
    [Proceso]         VARCHAR (20) NULL,
    [IgnorarNoAcceso] TINYINT      CONSTRAINT [DF_sys_Usuarios_Firmados_IgnorarNoAcceso] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_Usuarios_Firmados] PRIMARY KEY CLUSTERED ([Usuario] ASC) WITH (FILLFACTOR = 90)
);


GO
-- =============================================
-- Author:		<ALFREDO PEDRAZA>
-- Create date: <07 DE JUNIO DE 2013>
-- Description:	<Para guardar un historial de UsuarioS firmados en el VDealer>
-- =============================================

create TRIGGER [dbo].[CMtrg_sys_Usuarios_Firmados] 
   ON  [dbo].[sys_Usuarios_Firmados]
   AFTER INSERT, UPDATE, DELETE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


----lleva un Historico en tabla alterna tbco_movSaldosPolH

set language español

declare @Type char(1) 
		




if exists (select * from inserted)
	if exists (select * from deleted)
		select @Type = 'U'
	else
		select @Type = 'I'
else
	select @Type = 'D'


-- obteniendo la lista de todas columnas
select * into #ins from inserted
select * into #del from deleted




if @Type<>'U'
	insert into sys_Usuarios_FirmadosH
			(Type,UsuarioOld,FechaOld,HoraOld,ProcesoOld,UsuarioNew,FechaNew,HoraNew,ProcesoNew)	
	select  @Type, d.Usuario,d.Fecha,d.Hora,d.Proceso, i.Usuario,i.Fecha,i.Hora,i.Proceso
	from #ins i full outer join #del d on 
	d.Usuario=i.Usuario 
	where i.Usuario <> d.Usuario 
	or (i.Usuario is null and  d.Usuario is not null) 
	or (i.Usuario is not null and  d.Usuario is null)

else
	insert into sys_Usuarios_FirmadosH
			(Type,UsuarioOld,FechaOld,HoraOld,ProcesoOld,UsuarioNew,FechaNew,HoraNew,ProcesoNew)	
	select  @Type,d.Usuario,d.Fecha,d.Hora,d.Proceso, i.Usuario,i.Fecha,i.Hora,i.Proceso
	from #ins i full outer join #del d on  i.Usuario = d.Usuario 	
	where (i.Usuario<> d.Usuario or i.Fecha<> d.Fecha or i.Hora<> d.Hora or i.Proceso<> d.Proceso )


END