--Procedimiento que ejecuta la consulta dinamica para traer el conjunto de registros sobre el cual el rol tiene permisos
DROP PROCEDURE IF EXISTS EjecutarConsultaPorRolYTabla;
GO

CREATE OR ALTER PROCEDURE EjecutarConsultaPorRolYTabla
    @RolID INT,
    @NombreTabla VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Campos NVARCHAR(MAX);
    DECLARE @Condicion NVARCHAR(MAX);
    DECLARE @SQL NVARCHAR(MAX);
    DECLARE @MensajeError NVARCHAR(4000);
	
    -- Validar existencia de permiso
    IF NOT EXISTS (
        SELECT 1
        FROM Permiso
        WHERE RolID = @RolID AND NombreTabla = @NombreTabla
    )
    BEGIN
        THROW 50001, 'El rol no tiene permisos sobre la tabla especificada.', 1;
    END

    -- Obtener campos ordenados
    SELECT @Campos = STRING_AGG(t.NombreCampo, ', ') WITHIN GROUP (ORDER BY t.Orden)
    FROM Tabla t
    WHERE t.NombreTabla = @NombreTabla;

    -- Obtener filtro condicional (puede ser NULL)
    SELECT @Condicion = FiltroCondicion
    FROM Permiso
    WHERE RolID = @RolID AND NombreTabla = @NombreTabla;

    -- Construcción base del SQL
    SET @SQL = 'SELECT ' + @Campos + ' FROM ' + QUOTENAME(@NombreTabla);

    -- Agregar cláusula WHERE solo si hay condición válida
    IF @Condicion IS NOT NULL AND LTRIM(RTRIM(@Condicion)) <> ''
    BEGIN
        SET @SQL += ' WHERE ' + @Condicion;
    END

    -- Ejecutar la consulta dinámica con manejo de errores
    BEGIN TRY
        EXEC sp_executesql @SQL;
    END TRY
    BEGIN CATCH
        DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT;
        SELECT 
            @ErrMsg = ERROR_MESSAGE(),
            @ErrSeverity = ERROR_SEVERITY();
			SET @MensajeError = 'Error al ejecutar la consulta dinámica: ' + @ErrMsg;
            THROW 50002, @MensajeError, 1;
    END CATCH
END;