CREATE TABLE [dbo].[tbcm_Ciudad] (
    [id_Estado]    VARCHAR (4)  NOT NULL,
    [Ciudad]      VARCHAR (40) NOT NULL,
    [Municipio]   VARCHAR (40) NULL,
    [Lada]        SMALLINT     NULL,
    [Consecutivo] INT          NULL,
    CONSTRAINT [PK_tbcm_Ciudad] PRIMARY KEY NONCLUSTERED ([id_Estado] ASC, [Ciudad] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_tbcm_Ciudad_tbcm_estado] FOREIGN KEY ([id_Estado]) REFERENCES [dbo].[tbcm_estado] ([id_Estado])
);

