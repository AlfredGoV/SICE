CREATE TABLE [dbo].[sys_No_Acceso] (
    [sUsuario] VARCHAR (6) NOT NULL,
    [iFecha]   INT         NOT NULL,
    [iDeHora]  INT         NOT NULL,
    [iAHora]   INT         NULL,
    CONSTRAINT [PK_sys_No_Acceso] PRIMARY KEY CLUSTERED ([sUsuario] ASC, [iFecha] ASC, [iDeHora] ASC)
);

