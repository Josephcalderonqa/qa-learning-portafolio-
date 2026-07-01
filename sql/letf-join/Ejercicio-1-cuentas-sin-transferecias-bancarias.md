# Ejercicio 1 - LEFT JOIN para validación de cuentas sin transferencias bancarias

## Objetivo

Consultar las cuentas bancarias que **no han realizado transferencias**, identificando:

- Nombre del usuario.
- Número de cuenta.

Mostrando únicamente las cuentas que no tienen transferencias registradas.

---

## Contexto QA Backend

En plataformas **fintech** y sistemas bancarios es frecuente validar entidades que aún no presentan movimientos transaccionales.

Este escenario permite detectar:

- Cuentas inactivas.
- Usuarios sin actividad financiera.
- Posibles errores de integración.
- Cuentas recientemente creadas.
- Ausencia de movimientos esperados dentro del sistema.

Este tipo de validaciones es común en procesos de **QA Backend**, monitoreo operacional y análisis funcional de datos.

---

## Tablas utilizadas

- `accounts`
- `users`
- `bank_transfers`

---

## Lógica relacional

```text
users
  │
  └── user_id
       │
accounts
  │
  └── account_id
       │
bank_transfers
```

---

## Consulta SQL

```sql
SELECT
    u.full_name,
    a.account_number
FROM accounts a
LEFT JOIN bank_transfers b
    ON a.account_id = b.account_id
LEFT JOIN users u
    ON a.user_id = u.user_id
WHERE b.transfer_id IS NULL;
```

---

## Explicación técnica

La consulta utiliza **LEFT JOIN** para conservar todas las cuentas bancarias, incluso aquellas que no tienen registros en la tabla `bank_transfers`.

Cuando una cuenta no posee transferencias asociadas, el campo `b.transfer_id` toma el valor **NULL**.

Por esta razón, el filtro:

```sql
WHERE b.transfer_id IS NULL
```

permite identificar únicamente las cuentas que aún no registran movimientos de transferencia.

---

## Conceptos practicados

- LEFT JOIN
- Uso de `IS NULL`
- Detección de registros sin relación
- Navegación mediante claves foráneas (Foreign Keys)
- Uso de alias en consultas SQL
- Validaciones backend orientadas a ausencia de datos
- Diferencias entre INNER JOIN y LEFT JOIN

---

## Escenario QA Backend

Este ejercicio simula una validación frecuente en plataformas bancarias y fintech para identificar cuentas sin actividad transaccional.

Permite verificar correctamente:

- El usuario propietario de la cuenta.
- Cuentas sin actividad financiera.
- Ausencia de movimientos asociados.
- Posibles usuarios inactivos.
- Inconsistencias funcionales dentro del ecosistema transaccional.