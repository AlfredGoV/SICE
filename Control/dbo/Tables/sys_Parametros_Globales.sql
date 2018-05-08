CREATE TABLE [dbo].[sys_Parametros_Globales] (
    [usarcentral]    TINYINT       CONSTRAINT [DF_sys_Parametros_Globales_usarcentral] DEFAULT ((0)) NOT NULL,
    [servsqlvinc]    VARCHAR (100) CONSTRAINT [DF_sys_Parametros_Globales_servsqlvinc] DEFAULT ('') NOT NULL,
    [loginextendido] TINYINT       CONSTRAINT [DF_sys_Parametros_Globales_loginextendido] DEFAULT ((0)) NOT NULL
);

