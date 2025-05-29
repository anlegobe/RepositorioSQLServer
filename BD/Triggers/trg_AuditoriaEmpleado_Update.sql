DROP TRIGGER IF EXISTS trg_AuditoriaEmpleado_Update;
GO

CREATE TRIGGER trg_AuditoriaEmpleado_Update
ON Empleado
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Usuario NVARCHAR(128) = SYSTEM_USER;
    DECLARE @Host NVARCHAR(128) = HOST_NAME();

    INSERT INTO AuditoriaEmpleado (
        EmpleadoID,
        Nombre_Ant, Nombre_Nue,
        DepartamentoID_Ant, DepartamentoID_Nue,
        FechaHora, UsuarioEjecuta, HostName, TipoOperacion
    )
    SELECT 
        i.EmpleadoID,
        d.Nombre, i.Nombre,
        d.DepartamentoID, i.DepartamentoID,
        GETDATE(), @Usuario, @Host, 'U'
    FROM inserted i
    INNER JOIN deleted d ON i.EmpleadoID = d.EmpleadoID
    WHERE 
        ISNULL(i.Nombre, '') <> ISNULL(d.Nombre, '') OR
        ISNULL(i.DepartamentoID, -1) <> ISNULL(d.DepartamentoID, -1);
END;