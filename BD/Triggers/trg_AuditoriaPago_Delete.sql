DROP TRIGGER IF EXISTS trg_AuditoriaPago_Delete;
GO

CREATE TRIGGER trg_AuditoriaPago_Delete
ON Pago
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Usuario NVARCHAR(128) = SYSTEM_USER;
    DECLARE @Host NVARCHAR(128) = HOST_NAME();

    INSERT INTO AuditoriaPago (
        PagoID, FechaHora, UsuarioEjecuta, HostName, TipoOperacion
    )
    SELECT 
        d.PagoID, GETDATE(), @Usuario, @Host, 'D'
    FROM deleted d;
END;