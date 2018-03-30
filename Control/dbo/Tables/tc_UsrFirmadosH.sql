CREATE TABLE [dbo].[tc_UsrFirmadosH] (
    [AuditID]    BIGINT        IDENTITY (1, 1) NOT NULL,
    [Type]       CHAR (1)      NULL,
    [UpdateDate] DATETIME      CONSTRAINT [DF_tc_usrfirmadosH_UpdateDate] DEFAULT (getdate()) NULL,
    [UserName]   VARCHAR (128) CONSTRAINT [DF_tc_usrfirmadosH_UserName] DEFAULT (suser_sname()) NULL,
    [UsuarioOld] VARCHAR (6)   NULL,
    [FechaOld]   INT           NULL,
    [HoraOld]    INT           NULL,
    [ProcesoOld] VARCHAR (20)  NULL,
    [UsuarioNew] VARCHAR (6)   NULL,
    [FechaNew]   INT           NULL,
    [HoraNew]    INT           NULL,
    [ProcesoNew] VARCHAR (20)  NULL
);

