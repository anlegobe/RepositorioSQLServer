DROP TABLE IF EXISTS AuditoriaEmpleado;
GO

CREATE TABLE AuditoriaEmpleado (
    AuditoriaID INT IDENTITY PRIMARY KEY,
    EmpleadoID INT,
    Nombre_Ant VARCHAR(100),
    Nombre_Nue VARCHAR(100),
    DepartamentoID_Ant INT,
    DepartamentoID_Nue INT,
    FechaHora DATETIME DEFAULT GETDATE(),
    UsuarioEjecuta NVARCHAR(128),
    HostName NVARCHAR(128),
    TipoOperacion CHAR(1) -- 'I'=Insert, 'U'=Update, 'D'=Delete
);

CREATE NONCLUSTERED INDEX IX_AuditoriaEmpleado
ON AuditoriaEmpleado (EmpleadoID);