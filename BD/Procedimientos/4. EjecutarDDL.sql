--procedimiento almacenado que va a recibir como parametros EjecutarDML varchar
--este procedimiento va ejecutar la cadena como una sentencia dinamica
DROP PROCEDURE IF EXISTS EjecutarDML;
GO

CREATE OR ALTER PROCEDURE EjecutarDML
    @cadenaDML NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
	
    DECLARE @MensajeError NVARCHAR(4000);
	
    BEGIN TRY
        -- Ejecutar la sentencia DML
        EXEC sp_executesql @cadenaDML;
    END TRY
    BEGIN CATCH
        DECLARE @ErrorMsg NVARCHAR(4000), @ErrorSeverity INT;
        SELECT 
            @ErrorMsg = ERROR_MESSAGE(),
            @ErrorSeverity = ERROR_SEVERITY();
            SET @MensajeError = 'Error al ejecutar la sentencia DML: ' + @ErrorMsg;
        THROW 50010, @MensajeError,1 ;
    END CATCH
END;