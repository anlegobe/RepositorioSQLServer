DROP TRIGGER IF EXISTS trg_AuditoriaEmpleado_Insert;
GO

CREATE TRIGGER trg_AuditoriaEmpleado_Insert
ON Empleado
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Usuario NVARCHAR(128) = SYSTEM_USER;
    DECLARE @Host NVARCHAR(128) = HOST_NAME();

    INSERT INTO AuditoriaEmpleado (
        EmpleadoID, Nombre_Nue, DepartamentoID_Nue,
        FechaHora, UsuarioEjecuta, HostName, TipoOperacion
    )
    SELECT 
        i.EmpleadoID, i.Nombre, i.DepartamentoID,
        GETDATE(), @Usuario, @Host, 'I'
    FROM inserted i;
END;