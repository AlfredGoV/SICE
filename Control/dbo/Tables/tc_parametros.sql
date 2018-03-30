CREATE TABLE [dbo].[tc_parametros] (
    [idGerente]    VARCHAR (6)   NOT NULL,
    [fechaSistema] INT           NULL,
    [idEmpresa]    INT           NULL,
    [Sucursal]     VARCHAR (4)   NULL,
    [Ciudad]       SMALLINT      NULL,
    [RutaImpServ]  VARCHAR (200) NULL,
    [RutaImpClie]  VARCHAR (200) NULL,
    [idSucursal]   INT           NOT NULL,
    CONSTRAINT [PK_tc_parametros] PRIMARY KEY CLUSTERED ([idSucursal] ASC),
    CONSTRAINT [FK_tc_parametros_Sucursal] FOREIGN KEY ([idSucursal]) REFERENCES [dbo].[tc_Sucursal] ([idSucursal])
);

