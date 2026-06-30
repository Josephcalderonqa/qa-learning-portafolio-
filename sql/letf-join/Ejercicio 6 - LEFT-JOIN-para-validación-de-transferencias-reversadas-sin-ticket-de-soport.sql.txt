Ejercicio 6 - LEFT JOIN para validación de transferencias reversadas sin ticket de soporte
Objetivo

Consultar transferencias bancarias que fueron reversadas automáticamente por el sistema, pero que no poseen ticket de soporte asociado, identificando:
ID de la transferencia
Nombre del usuario
Número de cuenta origen
Monto de la transferencia
Estado de la transferencia
Fecha de reversa
Mostrando únicamente:
transferencias reversadas,
sin ticket de soporte registrado.
Contexto QA Backend
En plataformas financieras y bancarias, algunas transferencias pueden ser reversadas automáticamente por validaciones internas, reglas antifraude, fondos insuficientes o errores de conciliación.
En escenarios ideales, estas reversas deberían generar automáticamente un ticket de soporte o incidente operativo.
Cuando esto no sucede, pueden existir:
errores silenciosos,
incidentes no monitoreados,
pérdida de eventos,
fallos async,
problemas de trazabilidad,
o integraciones incompletas entre servicios.
Este tipo de consultas es común en QA backend, observabilidad y monitoreo transaccional.
Tablas utilizadas
bank_transfers
support_tickets
accounts
users

Lógica relacional

Plain text
bank_transfers
¦
+-- transfer_id
¦      +-- support_tickets
¦
+-- source_account_id
       +-- accounts
               +-- user_id
                       +-- users
Consulta SQL
SQL
SELECT
    b.transfer_id,
    u.full_name,
    a.account_number,
    b.amount,
    b.status,
    b.reversed_at

FROM bank_transfers b

LEFT JOIN support_tickets s
    ON b.transfer_id = s.transfer_id

LEFT JOIN accounts a
    ON b.source_account_id = a.account_id

LEFT JOIN users u
    ON a.user_id = u.user_id

WHERE s.ticket_id IS NULL
  AND b.status = 'REVERSED';

Explicación técnica
La consulta conserva todas las transferencias bancarias mediante LEFT JOIN.
Posteriormente intenta localizar un ticket de soporte asociado.
Cuando una transferencia no tiene ticket:
SQL
s.ticket_id
queda en:
Plain text
NULL
Por esta razón:
SQL
WHERE s.ticket_id IS NULL
permite detectar transferencias reversadas que nunca generaron incidente operativo.
Además:
SQL
b.status = 'REVERSED'
filtra únicamente transferencias que efectivamente fueron reversadas por el sistema.
Conceptos practicados
LEFT JOIN
Detección de registros faltantes
Uso de IS NULL
Validaciones backend orientadas a soporte
Conciliación de eventos
Navegación relacional
Foreign Keys
Procesos async
Observabilidad transaccional
Monitoreo operativo financiero
Escenario orientado a banca/fintech
Validación de transferencias reversadas sin ticket de soporte asociado, verificando correctamente:
transferencia afectada,
usuario origen,
cuenta involucrada,
ausencia de incidente operativo,
posibles fallos de automatización,
o pérdida de eventos entre servicios internos.