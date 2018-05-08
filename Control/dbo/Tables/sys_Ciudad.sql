CREATE TABLE [dbo].[sys_Ciudad] (
    [idEstado]    VARCHAR (4)  NOT NULL,
    [Ciudad]      VARCHAR (80) NOT NULL,
    [Municipio]   VARCHAR (80) NULL,
    [lada]        varchar(10)     NULL,
    [idCiudad]	  INT          NULL,
    CONSTRAINT [PK_sys_Ciudad] PRIMARY KEY NONCLUSTERED ([idEstado] ASC, [Ciudad] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_sys_Ciudad_sys_Estado] FOREIGN KEY ([idEstado]) REFERENCES [dbo].[sys_Estado] ([idEstado])
);

