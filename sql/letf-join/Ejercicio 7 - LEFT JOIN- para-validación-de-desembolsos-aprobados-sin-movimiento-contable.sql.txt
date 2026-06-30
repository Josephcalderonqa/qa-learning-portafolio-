Ejercicio 7 - LEFT JOIN para validación de desembolsos aprobados sin movimiento contable
Objetivo
Consultar desembolsos de préstamos que fueron aprobados correctamente, pero que no poseen movimiento contable registrado, identificando:
ID del desembolso
Nombre del usuario
Número de wallet
Monto aprobado
Estado del desembolso
Fecha de aprobación
Mostrando únicamente:
desembolsos APPROVED,
sin movimiento contable asociado.
Contexto QA Backend
En plataformas fintech y sistemas crediticios, un desembolso aprobado debe generar automáticamente un movimiento contable en el ledger financiero.
Cuando esto no ocurre, pueden existir:
inconsistencias financieras,
pérdida de eventos,
fallos async,
errores de integración,
problemas de auditoría,
o dinero entregado sin trazabilidad contable.
Este tipo de validaciones es altamente utilizado en QA backend, conciliación financiera y monitoreo transaccional.
Tablas utilizadas
loan_disbursements
accounting_movements
wallets
users
Lógica relacional

Plain text
loan_disbursements
¦
+-- disbursement_id
¦      +-- accounting_movements
¦
+-- wallet_id
¦      +-- wallets
¦
+-- user_id
       +-- users

Consulta SQL
SQL
SELECT
    l.disbursement_id,
    u.full_name,
    w.wallet_number,
    l.amount,
    l.status,
    l.approved_at

FROM loan_disbursements l

LEFT JOIN accounting_movements a
    ON l.disbursement_id = a.disbursement_id

LEFT JOIN wallets w
    ON l.wallet_id = w.wallet_id

LEFT JOIN users u
    ON l.user_id = u.user_id

WHERE l.status = 'APPROVED'
  AND a.movement_id IS NULL;

Explicación técnica
La consulta conserva todos los desembolsos registrados mediante LEFT JOIN.
Posteriormente intenta encontrar un movimiento contable asociado.
Cuando el desembolso no tiene registro contable:
SQL
a.movement_id
queda en:
Plain text
NULL
Por esta razón:
SQL
WHERE a.movement_id IS NULL
permite detectar desembolsos aprobados que nunca impactaron el ledger financiero.
Además:
SQL
l.status = 'APPROVED'
garantiza que únicamente se evalúan desembolsos efectivamente aprobados por el sistema.
Conceptos practicados
LEFT JOIN
Auditoría financiera
Conciliación contable
Uso de IS NULL
Validaciones backend orientadas a ledger
Procesos async
Navegación relacional
Foreign Keys
Integraciones financieras
Observabilidad transaccional
Escenario orientado a banca/fintech
Validación de desembolsos aprobados sin movimiento contable asociado, verificando correctamente:
desembolso aprobado,
usuario relacionado,
wallet impactada,
ausencia de registro en ledger,
posibles fallos de integración,
o pérdida de eventos financieros críticos