CREATE TABLE [dbo].[tc_Estado] (
    [idEstado] VARCHAR (4)  NOT NULL,
    [NoEstado] SMALLINT     NULL,
    [Estado]   VARCHAR (30) NULL,
    [Nombre]   VARCHAR (80) NULL,
    CONSTRAINT [PK_tc_Estado] PRIMARY KEY CLUSTERED ([idEstado] ASC)
);

