CREATE TABLE [dbo].[sys_Parametros] (
    [idGerente]    VARCHAR (6)   NOT NULL,
    [fechaSistema] INT           NULL,
    [idEmpresa]    INT           NULL,
    [Sucursal]     VARCHAR (4)   NULL,
    [Ciudad]       SMALLINT      NULL,
    [RutaImpServ]  VARCHAR (200) NULL,
    [RutaImpClie]  VARCHAR (200) NULL,
    [idSucursal]   INT           NOT NULL,
    CONSTRAINT [PK_sys_Parametros] PRIMARY KEY CLUSTERED ([idSucursal] ASC),
    CONSTRAINT [FK_sys_Parametros_Sucursal] FOREIGN KEY ([idSucursal]) REFERENCES [dbo].[sys_Sucursal] ([idSucursal])
);

