DROP TRIGGER IF EXISTS trg_AuditoriaEmpleado_Delete;
GO

CREATE TRIGGER trg_AuditoriaEmpleado_Delete
ON Empleado
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Usuario NVARCHAR(128) = SYSTEM_USER;
    DECLARE @Host NVARCHAR(128) = HOST_NAME();

    INSERT INTO AuditoriaEmpleado (
        EmpleadoID, FechaHora, UsuarioEjecuta, HostName, TipoOperacion
    )
    SELECT 
        d.EmpleadoID, GETDATE(), @Usuario, @Host, 'D'
    FROM deleted d;
END;