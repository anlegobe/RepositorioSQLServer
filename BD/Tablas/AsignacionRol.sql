DROP TABLE IF EXISTS AsignacionRol;
GO

CREATE TABLE AsignacionRol (
    UsuarioID INT NOT NULL,
    RolID INT NOT NULL,
    PRIMARY KEY (UsuarioID, RolID),
    FOREIGN KEY (UsuarioID) REFERENCES Usuario(UsuarioID),
    FOREIGN KEY (RolID) REFERENCES Rol(RolID)
);