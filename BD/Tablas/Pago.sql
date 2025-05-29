DROP TABLE IF EXISTS Pago;
GO

CREATE TABLE Pago (
    PagoID INT IDENTITY PRIMARY KEY,
    EmpleadoID INT NOT NULL,
    PeriodoID INT NOT NULL,
    Monto DECIMAL(18, 2) NOT NULL,
    FOREIGN KEY (EmpleadoID) REFERENCES Empleado(EmpleadoID),
    FOREIGN KEY (PeriodoID) REFERENCES PeriodoPago(PeriodoID)
);