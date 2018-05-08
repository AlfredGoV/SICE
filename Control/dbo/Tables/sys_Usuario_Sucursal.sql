CREATE TABLE [dbo].[sys_Usuario_Sucursal] (
    [Usuario]       VARCHAR (6)  NOT NULL,
    [Clave_Acceso]   VARCHAR (10) NULL,
    [Nivel]         SMALLINT     NULL,
    [Vigencia_Firma] INT          NULL,
    [Status]        SMALLINT     NULL,
    [Usuario_Alta]   VARCHAR (6)  NULL,
    [id_Usuario]     INT          NULL,
    [id_Sucursal]    INT           NULL,
    [Tipo_Usuario]   VARCHAR (10) NULL,
    CONSTRAINT [PK_usua] PRIMARY KEY CLUSTERED ([Usuario] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_sys_Usuario_Sucursal] FOREIGN KEY ([id_Sucursal]) REFERENCES [dbo].[sys_Sucursal] ([id_Sucursal]),
    CONSTRAINT [FK_sys_Usuario_Usuario] FOREIGN KEY ([id_Usuario]) REFERENCES [dbo].[sys_Usuario] ([id_Usuario])
);

