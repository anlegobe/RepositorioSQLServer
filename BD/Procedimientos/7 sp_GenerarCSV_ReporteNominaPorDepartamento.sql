--Reporte de Nomina por Departamento

DROP PROCEDURE IF EXISTS sp_GenerarCSV_ReporteNominaPorDepartamento;
GO

CREATE OR ALTER PROCEDURE sp_GenerarCSV_ReporteNominaPorDepartamento
    @DepartamentoID INT,
    @RutaArchivo NVARCHAR(255) -- Ejemplo: 'C:\reportes\nomina_departamento.csv'
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Consulta NVARCHAR(MAX);
    DECLARE @Comando NVARCHAR(MAX);
    DECLARE @TieneDatos BIT;

    -- Verificar si existen pagos asociados al departamento
    SELECT @TieneDatos = CASE WHEN EXISTS (
        SELECT 1
        FROM Empleado E
        JOIN Pago PG ON E.EmpleadoID = PG.EmpleadoID
        WHERE E.DepartamentoID = @DepartamentoID
    ) THEN 1 ELSE 0 END;

    IF @TieneDatos = 0
    BEGIN
        RAISERROR('No hay registros de pagos para el DepartamentoID proporcionado.', 16, 1);
        RETURN;
    END

    -- Construir la consulta SQL dinámica
    SET @Consulta = 'SELECT E.EmpleadoID, E.Nombre AS NombreEmpleado, D.Nombre AS Departamento,
                            P.FechaInicio, P.FechaFin, PG.Monto
                     FROM Empleado E
                     JOIN Departamento D ON E.DepartamentoID = D.DepartamentoID
                     JOIN Pago PG ON E.EmpleadoID = PG.EmpleadoID
                     JOIN PeriodoPago P ON PG.PeriodoID = P.PeriodoID
                     WHERE D.DepartamentoID = ' + CAST(@DepartamentoID AS NVARCHAR);

    -- Construir el comando para bcp
    SET @Comando = 'bcp "' + @Consulta + '" queryout "' + @RutaArchivo +
                   '" -c -t, -T -S ' + @@SERVERNAME;

    -- Ejecutar exportación a CSV
    BEGIN TRY
        EXEC xp_cmdshell @Comando;
    END TRY
    BEGIN CATCH
        DECLARE @ErrMsg NVARCHAR(4000) = ERROR_MESSAGE();
        RAISERROR('Error al generar el archivo CSV: %s', 16, 1, @ErrMsg);
    END CATCH
END;