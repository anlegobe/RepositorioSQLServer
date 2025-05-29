--Reporte de Nomina por Empleado

DROP PROCEDURE IF EXISTS sp_GenerarCSV_ReporteNominaPorEmpleado;
GO

CREATE OR ALTER PROCEDURE sp_GenerarCSV_ReporteNominaPorEmpleado
    @EmpleadoID INT,
    @RutaArchivo NVARCHAR(255) -- Ej: 'C:\reportes\reporte_nomina.csv'
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Consulta NVARCHAR(MAX);
    DECLARE @Comando NVARCHAR(MAX);
    DECLARE @TieneDatos BIT;

    -- Verificar si hay registros para el empleado
    SELECT @TieneDatos = CASE WHEN EXISTS (
        SELECT 1
        FROM Empleado E
        JOIN Pago PG ON E.EmpleadoID = PG.EmpleadoID
        WHERE E.EmpleadoID = @EmpleadoID
    ) THEN 1 ELSE 0 END;

    IF @TieneDatos = 0
    BEGIN
        RAISERROR('No hay registros de pagos para el EmpleadoID proporcionado.', 16, 1);
        RETURN;
    END

    -- Consulta dinámica
    SET @Consulta = 'SELECT E.EmpleadoID, E.Nombre AS NombreEmpleado, D.Nombre AS Departamento,
                            P.FechaInicio, P.FechaFin, PG.Monto
                     FROM Empleado E
                     JOIN Departamento D ON E.DepartamentoID = D.DepartamentoID
                     JOIN Pago PG ON E.EmpleadoID = PG.EmpleadoID
                     JOIN PeriodoPago P ON PG.PeriodoID = P.PeriodoID
                     WHERE E.EmpleadoID = ' + CAST(@EmpleadoID AS NVARCHAR);

    -- Comando BCP
    SET @Comando = 'bcp "' + @Consulta + '" queryout "' + @RutaArchivo +
                   '" -c -t, -T -S ' + @@SERVERNAME;

    -- Ejecutar
    BEGIN TRY
        EXEC xp_cmdshell @Comando;
    END TRY
    BEGIN CATCH
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error al generar el archivo CSV: %s', 16, 1, @ErrMsg);
    END CATCH
END;