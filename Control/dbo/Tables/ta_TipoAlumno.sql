CREATE TABLE [dbo].[ta_TipoAlumno] (
    [idTipoAlumno] INT          IDENTITY (1, 1) NOT NULL,
    [Tipo]         VARCHAR (6)  NOT NULL,
    [Descripcion]  VARCHAR (80) NULL,
    PRIMARY KEY CLUSTERED ([idTipoAlumno] ASC)
);

