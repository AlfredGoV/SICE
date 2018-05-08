CREATE TABLE [dbo].[sys_Estado] (
    [id_Estado] VARCHAR (4)  NOT NULL,
    [No_Estado] SMALLINT     NULL,
    [Estado]   VARCHAR (30) NULL,
    [Nombre]   VARCHAR (80) NULL,
    CONSTRAINT [PK_sys_Estado] PRIMARY KEY CLUSTERED ([id_Estado] ASC)
);

