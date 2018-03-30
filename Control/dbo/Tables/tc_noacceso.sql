CREATE TABLE [dbo].[tc_noacceso] (
    [sUsuario] VARCHAR (6) NOT NULL,
    [iFecha]   INT         NOT NULL,
    [iDeHora]  INT         NOT NULL,
    [iAHora]   INT         NULL,
    CONSTRAINT [PK_cmtbl_noacceso] PRIMARY KEY CLUSTERED ([sUsuario] ASC, [iFecha] ASC, [iDeHora] ASC)
);

