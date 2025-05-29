DROP TABLE IF EXISTS Usuario;
GO

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
