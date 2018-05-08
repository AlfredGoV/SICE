CREATE TABLE [dbo].[sys_Otros_Parametros] (
    [emailRecepcion]                VARCHAR (100) NULL,
    [emailVentas]                   VARCHAR (100) NULL,
    [emailEscolar]                  VARCHAR (100) NULL,
    [TelFaxRecepcion]               VARCHAR (15)  NULL,
    [TelFaxVentas]                  VARCHAR (15)  NULL,
    [SitioWeb]                      VARCHAR (100) NULL,
    [ArchivoLlave]                  VARCHAR (100) NULL,
    [PwdLlave]                      VARCHAR (100) NULL,
    [NombreReportePDFR]             VARCHAR (50)  NULL,
    [NombreReportePDFV]             VARCHAR (50)  NULL,
    [RutaReportesFR3]               VARCHAR (50)  NULL,
    [ServerWeb]                     VARCHAR (50)  NULL,
    [RegimenFiscal]                 VARCHAR (200) NULL,
    [idSucursal]                    INT           NOT NULL,
    [NombreReportePDFVUsadoACuenta] VARCHAR (50)  NULL,
    [TimbradoPrueba]                VARCHAR (6)   NULL,
    [VigenciaCer]                   VARCHAR (10)  NULL,
    CONSTRAINT [FK_sys_Otros_Parametros_Sucursal] FOREIGN KEY ([idSucursal]) REFERENCES [dbo].[sys_Sucursal] ([idSucursal])
);

