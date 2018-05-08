CREATE TABLE [dbo].[sys_Usuario_Sucursal] (
    [usuario]       VARCHAR (6)  NOT NULL,
    [ClaveAcceso]   VARCHAR (10) NULL,
    [Nivel]         SMALLINT     NULL,
    [VigenciaFirma] INT          NULL,
    [Status]        SMALLINT     NULL,
    [UsuarioAlta]   VARCHAR (6)  NULL,
    [idUsuario]     INT          NULL,
    [idSucursal]    INT          NOT NULL,
    [TipoUsuario]   VARCHAR (10) NULL,
    CONSTRAINT [PK_usua] PRIMARY KEY CLUSTERED ([usuario] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_sys_Usuario_Sucursal] FOREIGN KEY ([idSucursal]) REFERENCES [dbo].[sys_Sucursal] ([idSucursal]),
    CONSTRAINT [FK_sys_Usuario_Usuario] FOREIGN KEY ([idUsuario]) REFERENCES [dbo].[sys_Usuario] ([idUsuario])
);

