Ejercicio 5 - LEFT JOIN para conciliación de pagos PSE sin confirmación bancaria
Objetivo

Consultar pagos PSE registrados en la plataforma que no poseen confirmación bancaria asociada, identificando:
ID del pago
Nombre del usuario
Banco utilizado
Monto del pago
Estado del pago
Fecha de creación
Mostrando únicamente pagos PSE sin confirmación bancaria registrada.
Contexto QA Backend
En plataformas fintech, los pagos PSE suelen depender de confirmaciones externas provenientes de entidades bancarias.
En algunos escenarios, un pago puede existir dentro de la plataforma, pero la confirmación del banco nunca llegar correctamente debido a:
fallos de integración,
pérdida de callbacks,
problemas de conciliación,
errores async,
o inconsistencias entre servicios externos y la plataforma principal.
Este tipo de validaciones es común en QA backend y monitoreo transaccional financiero.

Tablas utilizadas
pse_payments
bank_confirmations
banks
users

Lógica relacional

Plain text
pse_payments
¦
+-- payment_id
¦      +-- bank_confirmations
¦
+-- bank_id
¦      +-- banks
¦
+-- user_id
       +-- users

Consulta SQL

SQL
SELECT
    p.payment_id,
    u.full_name,
    b.bank_name,
    p.amount,
    p.status,
    p.created_at

FROM pse_payments p

LEFT JOIN bank_confirmations bc
    ON p.payment_id = bc.payment_id

LEFT JOIN banks b
    ON p.bank_id = b.bank_id

LEFT JOIN users u
    ON p.user_id = u.user_id

WHERE bc.confirmation_id IS NULL;

Explicación técnica
La consulta conserva todos los pagos PSE registrados en la plataforma mediante LEFT JOIN.
Posteriormente, intenta encontrar una confirmación bancaria asociada.
Cuando un pago no tiene confirmación:
SQL
bc.confirmation_id
queda en:
Plain text
NULL

Por esta razón, el filtro:

SQL
WHERE bc.confirmation_id IS NULL
permite detectar pagos pendientes de conciliación bancaria o integraciones incompletas.
Conceptos practicados
LEFT JOIN
Conciliación financiera
Detección de integraciones faltantes
Uso de IS NULL
Navegación relacional
Foreign Keys
Validaciones backend orientadas a procesos async
Monitoreo de callbacks externos
Auditoría de transacciones financieras
Escenario orientado a banca/fintech
Validación de pagos PSE sin confirmación bancaria registrada, verificando correctamente:
pago creado en plataforma,
usuario asociado,
banco relacionado,
ausencia de confirmación externa,
posibles fallos de integración,
o problemas de conciliación financiera.