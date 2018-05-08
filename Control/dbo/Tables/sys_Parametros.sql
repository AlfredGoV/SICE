CREATE TABLE [dbo].[sys_Parametros] (
    [idGerente]    VARCHAR (6)   NOT NULL,
    [fechaSistema] INT           NULL,
    [id_Empresa]    INT           NULL,
    [Sucursal]     VARCHAR (4)   NULL,
    [Ciudad]       SMALLINT      NULL,
    [RutaImpServ]  VARCHAR (200) NULL,
    [RutaImpClie]  VARCHAR (200) NULL,
    [id_Sucursal]   INT           NOT NULL,
    CONSTRAINT [PK_sys_Parametros] PRIMARY KEY CLUSTERED ([id_Sucursal] ASC),
    CONSTRAINT [FK_sys_Parametros_Sucursal] FOREIGN KEY ([id_Sucursal]) REFERENCES [dbo].[sys_Sucursal] ([id_Sucursal])
);

