CREATE TABLE [dbo].[tc_HoraUsua] (
    [sUsuario] VARCHAR (6) NOT NULL,
    [iDia]     SMALLINT    NOT NULL,
    [iDeHora]  INT         NOT NULL,
    [iAHora]   INT         NULL,
    CONSTRAINT [PK_tc_horausua] PRIMARY KEY CLUSTERED ([sUsuario] ASC, [iDia] ASC, [iDeHora] ASC) WITH (FILLFACTOR = 90)
);

