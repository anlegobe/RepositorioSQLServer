--obtiene los campos y tipos de datos de las tabla sobre la cual el rol tiene permiso
DROP PROCEDURE IF EXISTS ObtenerCamposYTablaPorRol;
GO

CREATE OR ALTER PROCEDURE ObtenerCamposYTablaPorRol
    @RolID INT,
    @NombreTabla VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar si existen registros que coincidan
    IF NOT EXISTS (
        SELECT 1
        FROM Permiso p
        INNER JOIN Tabla t ON p.NombreTabla = t.NombreTabla
        WHERE p.RolID = @RolID AND p.NombreTabla = @NombreTabla
    )
    BEGIN
        THROW 50002, 'No se encontraron registros para el RolID y NombreTabla especificados.', 1;
    END

    -- Retornar NombreTabla, CamposConcatenados, TiposConcatenados y Permiso
    SELECT 
        p.NombreTabla,
        STRING_AGG(t.NombreCampo, ', ') WITHIN GROUP (ORDER BY t.Orden) AS CamposConcatenados,
        STRING_AGG(t.TipoDato, ', ') WITHIN GROUP (ORDER BY t.Orden) AS TiposConcatenados,
        p.Permiso
    FROM Permiso p
    INNER JOIN Tabla t ON p.NombreTabla = t.NombreTabla
    WHERE p.RolID = @RolID AND p.NombreTabla = @NombreTabla
    GROUP BY p.NombreTabla, p.Permiso;
END;