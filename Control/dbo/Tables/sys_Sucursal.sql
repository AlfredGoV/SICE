CREATE TABLE [dbo].[sys_Sucursal] (
    [id_Empresa]   TINYINT        NULL,
    [id_Sucursal]  INT    IDENTITY(1,1)       NOT NULL,
    [Matriz]      TINYINT        NULL,
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
    CONSTRAINT [PK_tc_catSucursal] PRIMARY KEY NONCLUSTERED ([id_Sucursal] ASC),
    CONSTRAINT [FK_sys_Sucursal_Empresa] FOREIGN KEY ([id_Empresa]) REFERENCES [dbo].[sys_Empresa] ([id_Empresa])
);

