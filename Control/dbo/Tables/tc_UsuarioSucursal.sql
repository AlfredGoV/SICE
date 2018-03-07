CREATE TABLE [dbo].[tc_UsuarioSucursal] (
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
    CONSTRAINT [FK_tc_usuario_Sucursal] FOREIGN KEY ([idSucursal]) REFERENCES [dbo].[tc_Sucursal] ([idSucursal]),
    CONSTRAINT [FK_tc_usuario_Usuario] FOREIGN KEY ([idUsuario]) REFERENCES [dbo].[tc_Usuario] ([idUsuario])
);

