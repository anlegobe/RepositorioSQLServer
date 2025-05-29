DROP TRIGGER IF EXISTS trg_AuditoriaPago_Insert;
GO

CREATE TRIGGER trg_AuditoriaPago_Insert
ON Pago
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Usuario NVARCHAR(128) = SYSTEM_USER;
    DECLARE @Host NVARCHAR(128) = HOST_NAME();

    INSERT INTO AuditoriaPago (
        PagoID, EmpleadoID_Nue, PeriodoID_Nue, Monto_Nue,
        FechaHora, UsuarioEjecuta, HostName, TipoOperacion
    )
    SELECT 
        i.PagoID, i.EmpleadoID, i.PeriodoID, i.Monto,
        GETDATE(), @Usuario, @Host, 'I'
    FROM inserted i;
END;