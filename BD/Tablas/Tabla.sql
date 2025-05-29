DROP TABLE IF EXISTS Tabla;
GO

CREATE TABLE Tabla (
    TablaID INT IDENTITY PRIMARY KEY, 
    NombreTabla VARCHAR(100) NOT NULL,
    NombreCampo VARCHAR(100) NOT NULL,
    TipoDato VARCHAR(50) NOT NULL,
	Orden INT NOT NULL
    CONSTRAINT UQ_Tabla_NombreTabla_NombreCampo UNIQUE (NombreTabla, NombreCampo)
);

CREATE NONCLUSTERED INDEX IX_Tabla_NombreTabla
ON Tabla (NombreTabla);