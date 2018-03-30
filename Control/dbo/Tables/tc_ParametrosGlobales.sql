CREATE TABLE [dbo].[tc_ParametrosGlobales] (
    [usarcentral]    TINYINT       CONSTRAINT [DF_tc_ParametrosGlobales_usarcentral] DEFAULT ((0)) NOT NULL,
    [servsqlvinc]    VARCHAR (100) CONSTRAINT [DF_tc_ParametrosGlobales_servsqlvinc] DEFAULT ('') NOT NULL,
    [loginextendido] TINYINT       CONSTRAINT [DF_tc_ParametrosGlobales_loginextendido] DEFAULT ((0)) NOT NULL
);

