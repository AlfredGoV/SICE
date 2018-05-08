CREATE TABLE [dbo].[sys_Usuario] (
    [idUsuario]     INT          IDENTITY (1, 1) NOT NULL,
    [Usuario]       VARCHAR (6)  NOT NULL,
    [Clave_Acceso]  VARCHAR (10) NULL,
    [NombreUsuario] VARCHAR (80) NULL,
    [Vigencia]      INT          NULL,
    [usuariologin]  VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([idUsuario] ASC)
);

