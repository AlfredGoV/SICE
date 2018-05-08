CREATE TABLE [dbo].[sys_Usuario] (
    [id_Usuario]     INT          IDENTITY (1, 1) NOT NULL,
    [Usuario]       VARCHAR (6)   NULL,
    [Clave_Acceso]  VARCHAR (10) NULL,
    [Nombre_Usuario] VARCHAR (80) NULL,
    [Vigencia]      INT          NULL,
    [Usuario_Login]  VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([id_Usuario] ASC)
);

