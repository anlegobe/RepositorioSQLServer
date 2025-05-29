DROP TABLE IF EXISTS Permiso;
GO

CREATE TABLE Permiso (
    PermisoID INT IDENTITY PRIMARY KEY,
    RolID INT NOT NULL,
    NombreTabla VARCHAR(100),
    FiltroCondicion VARCHAR(MAX),
	Permiso VARCHAR(10) NOT NULL
    FOREIGN KEY (RolID) REFERENCES Rol(RolID),
	CONSTRAINT UQ_Permiso_RolID_TablaID UNIQUE (RolID, NombreTabla)
);