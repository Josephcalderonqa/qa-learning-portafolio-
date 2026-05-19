Ejercicios de inner join
# Ejercicio 1 - INNER JOIN con múltiples relaciones

## Objetivo

Obtener estudiantes con notas mayores a 4.0,
incluyendo ciudad, curso y profesor asociado.

---

## Modelo relacional

students
+-- cities
+-- student_courses
    +-- courses
        +-- teachers

---

## Consulta SQL

```sql
SELECT
    s.student_name,
    c.city_name,
    co.course_name,
    t.teacher_name,
    sc.grade

FROM students s

INNER JOIN cities c
    ON s.city_id = c.city_id

INNER JOIN student_courses sc
    ON s.student_id = sc.student_id

INNER JOIN courses co
    ON sc.course_id = co.course_id

INNER JOIN teachers t
    ON co.teacher_id = t.teacher_id

WHERE sc.grade > 4.0

ORDER BY s.student_name ASC,
         sc.grade DESC;
```

---

## Conceptos practicados

- INNER JOIN
- Relaciones one-to-many
- Relaciones many-to-many
- Uso de aliases
- Filtros con WHERE
- ORDER BY
- Diseño relacional
- Tablas puente

---

## Escenario QA Backend

Validación de integridad relacional entre
estudiantes, cursos y profesores.