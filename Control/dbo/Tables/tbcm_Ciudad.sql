CREATE TABLE [dbo].[tbcm_Ciudad] (
    [idEstado]    VARCHAR (4)  NOT NULL,
    [Ciudad]      VARCHAR (40) NOT NULL,
    [Municipio]   VARCHAR (40) NULL,
    [lada]        SMALLINT     NULL,
    [Consecutivo] INT          NULL,
    CONSTRAINT [PK_tbcm_Ciudad] PRIMARY KEY NONCLUSTERED ([idEstado] ASC, [Ciudad] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_tbcm_Ciudad_tbcm_estado] FOREIGN KEY ([idEstado]) REFERENCES [dbo].[tbcm_estado] ([idEstado])
);

