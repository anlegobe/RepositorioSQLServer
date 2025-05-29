DROP TABLE IF EXISTS Empleado;
GO

CREATE TABLE Empleado (
    EmpleadoID INT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    DepartamentoID INT NOT NULL,
    FOREIGN KEY (DepartamentoID) REFERENCES Departamento(DepartamentoID)
);