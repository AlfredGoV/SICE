CREATE TABLE [dbo].[tc_Ciudad] (
    [idEstado]    VARCHAR (4)  NOT NULL,
    [Ciudad]      VARCHAR (80) NOT NULL,
    [Municipio]   VARCHAR (80) NULL,
    [lada]        varchar(10)     NULL,
    [idCiudad]	  INT          NULL,
    CONSTRAINT [PK_tc_Ciudad] PRIMARY KEY NONCLUSTERED ([idEstado] ASC, [Ciudad] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_tc_Ciudad_tc_Estado] FOREIGN KEY ([idEstado]) REFERENCES [dbo].[tc_Estado] ([idEstado])
);

