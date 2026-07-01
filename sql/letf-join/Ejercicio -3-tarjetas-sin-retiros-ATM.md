Ejercicio 3 - LEFT JOIN para validación de tarjetas sin retiros ATM
Objetivo
Consultar tarjetas bancarias que no han realizado retiros en cajeros automáticos, identificando:
Nombre del usuario
Número de cuenta
Número de tarjeta
Mostrando únicamente tarjetas sin retiros ATM registrados.
Contexto QA Backend
En plataformas bancarias y sistemas fintech es común validar medios de pago que aún no presentan actividad transaccional.
En este escenario, se requiere detectar tarjetas bancarias que nunca han sido utilizadas en retiros ATM, permitiendo identificar:
tarjetas inactivas,
productos recién emitidos,
usuarios sin actividad,
posibles fallos de integración,
o ausencia de movimientos esperados dentro del ecosistema transaccional.
Este tipo de validaciones es frecuente en QA backend, auditoría operativa y monitoreo funcional.

Tablas utilizadas
cards
accounts
users
atm_withdrawals

Lógica relacional

Plain text
cards
¦
+-- account_id
¦      +-- accounts
¦              +-- user_id
¦                      +-- users
¦
+-- card_id
       +-- atm_withdrawals

Consulta SQL

SQL
SELECT
    u.full_name,
    a.account_number,
    c.card_number

FROM cards c

LEFT JOIN atm_withdrawals aw
    ON c.card_id = aw.card_id

LEFT JOIN accounts a
    ON c.account_id = a.account_id

LEFT JOIN users u
    ON a.user_id = u.user_id

WHERE aw.withdrawal_id IS NULL;

Explicación técnica
La consulta conserva todas las tarjetas bancarias mediante LEFT JOIN, incluso aquellas que no poseen registros asociados en la tabla atm_withdrawals.
Cuando una tarjeta no tiene retiros ATM relacionados:
SQL
aw.withdrawal_id
queda en:
Plain text
NULL
Por esta razón, el filtro:
SQL
WHERE aw.withdrawal_id IS NULL
permite detectar específicamente tarjetas sin retiros registrados.
Conceptos practicados
LEFT JOIN
Detección de registros sin relación
Uso de IS NULL
Navegación relacional
Foreign Keys
Uso de aliases
Validaciones backend orientadas a ausencia de datos
Diferencias entre INNER JOIN y LEFT JOIN
Identificación de entidades sin actividad transaccional
Escenario orientado a banca/fintech
Validación de tarjetas bancarias sin retiros ATM registrados, verificando correctamente:
usuario propietario de la tarjeta,
cuenta asociada,
tarjetas sin actividad,
ausencia de movimientos ATM,
o posibles inconsistencias funcionales dentro de la plataforma financiera.