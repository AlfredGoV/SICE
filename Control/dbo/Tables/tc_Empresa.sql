CREATE TABLE [dbo].[tc_Empresa] (
    [idEmpresa] TINYINT      NOT NULL,
    [empresa]   VARCHAR (50) NULL,
    [rfc]       VARCHAR (13) NULL,
    CONSTRAINT [PK_tc_catEmpresa] PRIMARY KEY NONCLUSTERED ([idEmpresa] ASC) WITH (FILLFACTOR = 90)
);

