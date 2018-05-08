CREATE TABLE [dbo].[sys_Empresa] (
    [id_Empresa] TINYINT      NOT NULL,
    [Empresa]   VARCHAR (50) NULL,
    [RFC]       VARCHAR (13) NULL,
    CONSTRAINT [PK_tc_catEmpresa] PRIMARY KEY NONCLUSTERED ([id_Empresa] ASC) WITH (FILLFACTOR = 90)
);

