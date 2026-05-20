# Ejercicio 3 - INNER JOIN con cuentas origen y destino

## Objetivo

Consultar transferencias completadas mayores a 500000, identificando:

- ID de la transferencia
- Nombre del usuario remitente
- Nombre del usuario destinatario
- Número de cuenta origen
- Número de cuenta destino
- Monto transferido
- Estado de la transferencia

Ordenando los resultados por monto de mayor a menor.

---

## Contexto QA Backend

En un sistema fintech, una transferencia no almacena directamente el nombre del remitente ni del destinatario.

La tabla `transfers` solo guarda referencias a la cuenta origen y a la cuenta destino.  
Por eso, como QA backend, se debe navegar desde la transferencia hacia las cuentas y luego hacia los usuarios propietarios de esas cuentas.

---

## Tablas utilizadas

- `users`
- `accounts`
- `transfers`

---

## Lógica relacional

```text
transfers
¦
+-- source_account_id
¦      +-- accounts (sender account)
¦              +-- users (sender user)
¦
+-- target_account_id
       +-- accounts (receiver account)
               +-- users (receiver user)
```

---

## Consulta SQL

```sql
SELECT
    t.transfer_id,
    u.full_name AS sender_name,
    us.full_name AS receiver_name,
    a.account_number AS sender_account_number,
    ac.account_number AS receiver_account_number,
    t.amount,
    t.status

FROM transfers t

INNER JOIN accounts a
    ON t.source_account_id = a.account_id

INNER JOIN accounts ac
    ON t.target_account_id = ac.account_id

INNER JOIN users u
    ON u.user_id = a.user_id

INNER JOIN users us
    ON us.user_id = ac.user_id

WHERE t.status = 'COMPLETED'
  AND t.amount > 500000

ORDER BY t.amount DESC;
```

---

## Conceptos practicados

- INNER JOIN
- Uso de aliases
- Reutilización de una misma tabla en diferentes roles
- Reutilización de `accounts` como cuenta origen y cuenta destino
- Reutilización de `users` como remitente y destinatario
- Diferencia entre ID interno y dato funcional
- Navegación relacional
- Foreign keys
- Filtros con WHERE
- Ordenamiento con ORDER BY
- Pensamiento backend orientado a transacciones

---

## Escenario orientado a banca/fintech

Validación de transferencias completadas, verificando que cada transacción pueda asociarse correctamente con su cuenta origen, cuenta destino, usuario remitente y usuario destinatario.