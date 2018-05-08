CREATE TABLE [dbo].[sys_Hora_Usuario] (
    [sUsuario] VARCHAR (6) NOT NULL,
    [iDia]     SMALLINT    NOT NULL,
    [iDeHora]  INT         NOT NULL,
    [iAHora]   INT         NULL,
    CONSTRAINT [PK_sys_Hora_Usuario] PRIMARY KEY CLUSTERED ([sUsuario] ASC, [iDia] ASC, [iDeHora] ASC) WITH (FILLFACTOR = 90)
);

