-- ========================
-- Datos: Rol
-- ========================
INSERT INTO Rol (NombreRol) VALUES 
('Administrador'),
('RRHH'),
('Contador'),
('Supervisor'),
('Empleado'),
('Auditor'),
('TI'),
('Consultor'),
('Jefe Area'),
('Interno');

-- ========================
-- Datos: Usuario
-- ========================
INSERT INTO Usuario (NombreUsuario, estado, documento, email, password, fechaCreacion, fechaCambioEstado) VALUES 
('jlopez', 'ACTIVO', '123456789', 'jlopez@example.com', 'pass123', GETDATE(), NULL),
('mperez', 'ACTIVO', '987654321', 'mperez@example.com', 'pass456', GETDATE(), NULL),
('jruiz', 'ACTIVO', '456789123', 'jruiz@example.com', 'pass789', GETDATE(), NULL),
('agomez', 'INACTIVO', '654321987', 'agomez@example.com', 'pass321', GETDATE(), GETDATE()),
('lrodriguez', 'ACTIVO', '112233445', 'lrodriguez@example.com', 'pass654', GETDATE(), NULL),
('cmorales', 'ACTIVO', '998877665', 'cmorales@example.com', 'pass987', GETDATE(), NULL),
('dquintero', 'ACTIVO', '554433221', 'dquintero@example.com', 'pass741', GETDATE(), NULL),
('psanchez', 'ACTIVO', '776655443', 'psanchez@example.com', 'pass852', GETDATE(), NULL),
('ffranco', 'ACTIVO', '332211009', 'ffranco@example.com', 'pass963', GETDATE(), NULL),
('rjimenez', 'ACTIVO', '101010101', 'rjimenez@example.com', 'pass000', GETDATE(), NULL);

-- ========================
-- Datos: Departamento
-- ========================
INSERT INTO Departamento (Nombre) VALUES 
('Recursos Humanos'),
('Contabilidad'),
('TI'),
('Ventas'),
('Marketing'),
('Logística'),
('Dirección'),
('Producción'),
('Soporte'),
('Calidad');

-- ========================
-- Datos: PeriodoPago
-- ========================
INSERT INTO PeriodoPago (FechaInicio, FechaFin) VALUES 
('2025-01-01', '2025-01-15'),
('2025-01-16', '2025-01-31'),
('2025-02-01', '2025-02-15'),
('2025-02-16', '2025-02-28'),
('2025-03-01', '2025-03-15'),
('2025-03-16', '2025-03-31'),
('2025-04-01', '2025-04-15'),
('2025-04-16', '2025-04-30'),
('2025-05-01', '2025-05-15'),
( '2025-05-16', '2025-05-31');

-- ========================
-- Datos: Empleado
-- ========================
INSERT INTO Empleado (Nombre, DepartamentoID) VALUES 
('Laura Gómez', 1),
('Carlos Mejía', 2),
('Ana Torres', 3),
('Pedro Álvarez', 4),
('Lucía Martínez', 5),
('Andrés Rodríguez', 6),
('María Fernández', 7),
('José Morales', 8),
('Claudia Rivas', 9),
('Daniel Salas', 10);

-- ========================
-- Datos: Pago
-- ========================
INSERT INTO Pago (EmpleadoID, PeriodoID, Monto) VALUES 
(1, 1, 1200000),
(2, 2, 1500000),
(3, 3, 1800000),
(4, 4, 1350000),
(5, 5, 1250000),
(6, 6, 1400000),
(7, 7, 1550000),
(8, 8, 1650000),
(9, 9, 1750000),
(10, 10, 1600000);

-- ========================
-- Datos: AsignacionRol
-- ========================
INSERT INTO AsignacionRol (UsuarioID, RolID) VALUES 
(1, 1),
(1, 2),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

-- ========================
-- Datos: Permiso
-- ========================
INSERT INTO Permiso (RolID, NombreTabla, FiltroCondicion, Permiso) VALUES
-- Acceso completo a todas las tablas
(1, 'Departamento', NULL, 'I'),
(1, 'PeriodoPago', NULL, 'I,D'),
(1, 'Empleado', NULL, 'D'),
(1, 'Pago', NULL, 'D,U'),

(2, 'Empleado', 'DepartamentoID = 1', 'I'),
(3, 'Pago', 'EmpleadoID IN (102,103)', 'I,U,D'), 
(4, 'Empleado', 'DepartamentoID IN (4,5)', 'I,U,D'), 
(5, 'Empleado', 'DepartamentoID = 5', 'I,U,D'), 
(6, 'Pago', NULL, 'I,U,D'), 
(7, 'Empleado', NULL, 'I,U,D'), 
(8, 'Departamento', NULL, 'I,U,D'), 
(9, 'Empleado', 'DepartamentoID = 9', 'I,U,D'), 
(10, 'Empleado', 'EmpleadoID = 110', 'I,U,D'); 

-- ========================
-- Datos: Tabla (metadata de las tablas principales)
-- ========================
-- Departamento
INSERT INTO Tabla (NombreTabla, NombreCampo, TipoDato, Orden) VALUES 
('Departamento', 'DepartamentoID', 'INT', 1),
('Departamento', 'Nombre', 'VARCHAR(100)', 2);

-- PeriodoPago
INSERT INTO Tabla (NombreTabla, NombreCampo, TipoDato, Orden) VALUES 
('PeriodoPago', 'PeriodoID', 'INT', 1),
('PeriodoPago', 'FechaInicio', 'DATE', 2),
('PeriodoPago', 'FechaFin', 'DATE', 3);

-- Empleado
INSERT INTO Tabla (NombreTabla, NombreCampo, TipoDato, Orden) VALUES 
('Empleado', 'EmpleadoID', 'INT', 1),
('Empleado', 'Nombre', 'VARCHAR(100)', 2),
('Empleado', 'DepartamentoID', 'INT', 3);

-- Pago
INSERT INTO Tabla (NombreTabla, NombreCampo, TipoDato, Orden) VALUES 
('Pago', 'PagoID', 'INT', 1),
('Pago', 'EmpleadoID', 'INT', 2),
('Pago', 'PeriodoID', 'INT', 3),
('Pago', 'Monto', 'DECIMAL(18,2)', 4);