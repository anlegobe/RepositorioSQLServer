--Procedimiento almacenado para obtener los roles permisos sobre tablas 

DROP PROCEDURE IF EXISTS ObtenerPermisosPorUsuario;
GO

CREATE OR ALTER PROCEDURE ObtenerPermisosPorUsuario
    @UsuarioID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar existencia de asignaciones
    IF NOT EXISTS (
        SELECT 1
        FROM AsignacionRol ar
        JOIN Permiso p ON ar.RolID = p.RolID
        WHERE ar.UsuarioID = @UsuarioID
    )
    BEGIN
        THROW 50001, 'El usuario no tiene permisos asignados.', 1;
    END

    -- Consultar roles y permisos del usuario
    SELECT 
        r.RolID,
        r.NombreRol,
        p.NombreTabla,
        p.Permiso
    FROM Usuario u
    INNER JOIN AsignacionRol ar ON u.UsuarioID = ar.UsuarioID
    INNER JOIN Rol r ON ar.RolID = r.RolID
    INNER JOIN Permiso p ON r.RolID = p.RolID
    WHERE u.UsuarioID = @UsuarioID;
END;