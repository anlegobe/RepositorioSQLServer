DROP TABLE IF EXISTS AuditoriaPago;
GO

CREATE TABLE AuditoriaPago (
    AuditoriaID INT IDENTITY PRIMARY KEY,
    PagoID INT,
    EmpleadoID_Ant INT,
    EmpleadoID_Nue INT,
    PeriodoID_Ant INT,
    PeriodoID_Nue INT,
    Monto_Ant DECIMAL(18,2),
    Monto_Nue DECIMAL(18,2),
    FechaHora DATETIME DEFAULT GETDATE(),
    UsuarioEjecuta NVARCHAR(128),
    HostName NVARCHAR(128),
    TipoOperacion CHAR(1) -- 'I'=Insert, 'U'=Update, 'D'=Delete
);

CREATE NONCLUSTERED INDEX IX_AuditoriaPago
ON AuditoriaPago (PagoID);