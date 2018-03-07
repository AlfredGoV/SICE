CREATE TABLE [dbo].[tc_Sucursal] (
    [idEmpresa]   TINYINT       NOT NULL,
    [idSucursal]  INT           NOT NULL,
    [Matriz]      TINYINT       NOT NULL,
    [calle]       VARCHAR (180) NULL,
    [noExt]       VARCHAR (10)  NULL,
    [noInt]       VARCHAR (10)  NULL,
    [Colonia]     VARCHAR (150) NULL,
    [cp]          VARCHAR (5)   NULL,
    [Ciudad]      VARCHAR (50)  NULL,
    [Municipio]   VARCHAR (50)  NULL,
    [Estado]      VARCHAR (20)  NULL,
    [logo]        VARCHAR (40)  NULL,
    [Telefono]    VARCHAR (30)  NULL,
    [Descripcion] VARCHAR (50)  NULL,
    CONSTRAINT [PK_tc_catSucursal] PRIMARY KEY NONCLUSTERED ([idSucursal] ASC),
    CONSTRAINT [FK_tc_Sucursal_Empresa] FOREIGN KEY ([idEmpresa]) REFERENCES [dbo].[tc_Empresa] ([idEmpresa])
);

