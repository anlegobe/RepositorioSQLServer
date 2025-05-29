--Script de reverso
-- Primero eliminamos las tablas dependientes (las que tienen FKs)

DROP TABLE IF EXISTS AsignacionRol;
DROP TABLE IF EXISTS Pago;

-- Luego eliminamos las tablas intermedias y padres

DROP TABLE IF EXISTS Permiso;
DROP TABLE IF EXISTS PeriodoPago;
DROP TABLE IF EXISTS Empleado;
DROP TABLE IF EXISTS Departamento;
DROP TABLE IF EXISTS Rol;
DROP TABLE IF EXISTS Usuario;
DROP TABLE IF EXISTS Tabla;
DROP TABLE IF EXISTS AuditoriaCambios;
DROP TABLE IF EXISTS AuditoriaEmpleado;
DROP TABLE IF EXISTS AuditoriaPago;