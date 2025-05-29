DROP TABLE IF EXISTS PeriodoPago;
GO

CREATE TABLE PeriodoPago (
    PeriodoID INT PRIMARY KEY,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL
);