CREATE TABLE [dbo].[tbcm_estado] (
    [idEstado] VARCHAR (4)  NOT NULL,
    [NoEstado] SMALLINT     NULL,
    [Estado]   VARCHAR (26) NULL,
    CONSTRAINT [PK_tbcm_estado] PRIMARY KEY CLUSTERED ([idEstado] ASC)
);

