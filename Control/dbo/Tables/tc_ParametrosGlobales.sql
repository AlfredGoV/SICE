CREATE TABLE [dbo].[tc_ParametrosGlobales] (
    [usarcentral]    TINYINT       CONSTRAINT [DF_tc_parametrosGlobales_usarcentral] DEFAULT ((0)) NOT NULL,
    [servsqlvinc]    VARCHAR (100) CONSTRAINT [DF_tc_parametrosGlobales_servsqlvinc] DEFAULT ('') NOT NULL,
    [loginextendido] TINYINT       CONSTRAINT [DF_tc_parametrosGlobales_loginextendido] DEFAULT ((0)) NOT NULL
);

