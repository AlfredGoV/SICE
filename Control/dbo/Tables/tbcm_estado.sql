CREATE TABLE [dbo].[tbcm_estado] (
    [id_Estado] VARCHAR (4)  NOT NULL,
    [No_Estado] SMALLINT     NULL,
    [Estado]   VARCHAR (26) NULL,
    CONSTRAINT [PK_tbcm_estado] PRIMARY KEY CLUSTERED ([id_Estado] ASC)
);

