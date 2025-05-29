DROP TRIGGER IF EXISTS trg_AuditoriaPago_Update;
GO

CREATE TRIGGER trg_AuditoriaPago_Update
ON Pago
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Usuario NVARCHAR(128) = SYSTEM_USER;
    DECLARE @Host NVARCHAR(128) = HOST_NAME();

    INSERT INTO AuditoriaPago (
        PagoID,
        EmpleadoID_Ant, EmpleadoID_Nue,
        PeriodoID_Ant, PeriodoID_Nue,
        Monto_Ant, Monto_Nue,
        FechaHora, UsuarioEjecuta, HostName, TipoOperacion
    )
    SELECT 
        i.PagoID,
        d.EmpleadoID, i.EmpleadoID,
        d.PeriodoID, i.PeriodoID,
        d.Monto, i.Monto,
        GETDATE(), @Usuario, @Host, 'U'
    FROM inserted i
    INNER JOIN deleted d ON i.PagoID = d.PagoID
    WHERE 
        ISNULL(i.EmpleadoID, -1) <> ISNULL(d.EmpleadoID, -1) OR
        ISNULL(i.PeriodoID, -1) <> ISNULL(d.PeriodoID, -1) OR
        ISNULL(i.Monto, -1) <> ISNULL(d.Monto, -1);
END;