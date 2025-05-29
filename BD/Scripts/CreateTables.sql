-- ========================
-- Tablas independientes
-- ========================

CREATE TABLE Rol (
    RolID INT IDENTITY PRIMARY KEY,
    NombreRol VARCHAR(100) NOT NULL
);

CREATE TABLE Usuario (
    UsuarioID INT IDENTITY PRIMARY KEY,
    NombreUsuario VARCHAR(100) NOT NULL,
    estado VARCHAR(10),--ACTIVO o INACTIVO
    documento VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(100) NOT NULL,
    fechaCreacion DATE NOT NULL,
    fechaCambioEstado DATE
);

CREATE TABLE Departamento (
    DepartamentoID INT IDENTITY PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
)

CREATE TABLE PeriodoPago (
    PeriodoID INT IDENTITY PRIMARY KEY,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL
);

CREATE TABLE Tabla (
    TablaID INT IDENTITY PRIMARY KEY, 
    NombreTabla VARCHAR(100) NOT NULL,
    NombreCampo VARCHAR(100) NOT NULL,
    TipoDato VARCHAR(50) NOT NULL,
	Orden INT NOT NULL
    CONSTRAINT UQ_Tabla_NombreTabla_NombreCampo UNIQUE (NombreTabla, NombreCampo)
);

-- ========================
-- Tablas dependientes
-- ========================

CREATE TABLE Empleado (
    EmpleadoID INT IDENTITY PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    DepartamentoID INT NOT NULL,
    FOREIGN KEY (DepartamentoID) REFERENCES Departamento(DepartamentoID)
);

CREATE TABLE AsignacionRol (
    UsuarioID INT NOT NULL,
    RolID INT NOT NULL,
    PRIMARY KEY (UsuarioID, RolID),
    FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID),
    FOREIGN KEY (RolID) REFERENCES Rol(RolID)
);

CREATE TABLE Pago (
    PagoID INT IDENTITY PRIMARY KEY,
    EmpleadoID INT NOT NULL,
    PeriodoID INT NOT NULL,
    Monto DECIMAL(18, 2) NOT NULL,
    FOREIGN KEY (EmpleadoID) REFERENCES Empleado(EmpleadoID),
    FOREIGN KEY (PeriodoID) REFERENCES PeriodoPago(PeriodoID)
);

CREATE TABLE Permiso (
    PermisoID INT IDENTITY PRIMARY KEY,
    RolID INT NOT NULL,
    NombreTabla VARCHAR(100),
    FiltroCondicion VARCHAR(MAX),
	Permiso VARCHAR(10) NOT NULL
    FOREIGN KEY (RolID) REFERENCES Rol(RolID),
	CONSTRAINT UQ_Permiso_RolID_TablaID UNIQUE (RolID, NombreTabla)
);

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

CREATE NONCLUSTERED INDEX IX_AuditoriaPago
ON AuditoriaPago (PagoID);

CREATE NONCLUSTERED INDEX IX_Tabla_NombreTabla
ON Tabla (NombreTabla);
