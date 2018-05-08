CREATE TABLE [dbo].[sys_Ciudad] (
    [id_Estado]    VARCHAR (4)  NOT NULL,
    [Ciudad]      VARCHAR (80) NOT NULL,
    [Municipio]   VARCHAR (80) NULL,
    [Lada]        varchar(10)     NULL,
    [id_Ciudad]	  INT          NULL,
    CONSTRAINT [PK_sys_Ciudad] PRIMARY KEY NONCLUSTERED ([id_Estado] ASC, [Ciudad] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_sys_Ciudad_sys_Estado] FOREIGN KEY ([id_Estado]) REFERENCES [dbo].[sys_Estado] ([id_Estado])
);

