# Decisiones Técnicas — SIGAU

## Decisión #01
**¿Qué decidí?**
~~Usar Django (Python) como framework de desarrollo backend.~~ *(Decisión revertida — ver Decisión #03)*

**¿Por qué?**
Django ofrecía un ORM que mapeaba directamente las entidades del modelo relacional,
un sistema de autenticación integrado compatible con los roles definidos en el MER
(Estudiante, Administrador), y una arquitectura MTV que se alineaba con los componentes
definidos en el E5.

**¿Qué artefacto de diseño respalda esta decisión?**
E5 — Diagrama de Componentes UML / E6 — Diagrama de Despliegue UML / E9 — Modelo Relacional

---

## Decisión #02
**¿Qué decidí?**
Usar MySQL 8.0 como motor de base de datos en lugar de PostgreSQL.

**¿Por qué?**
MySQL es ampliamente usado en entornos académicos, tiene mejor integración
con el entorno de desarrollo del equipo, y el motor InnoDB garantiza soporte completo de
integridad referencial y transacciones ACID.

**¿Qué artefacto de diseño respalda esta decisión?**
E11 — Script DDL / E9 — Modelo Relacional / E10 — Normalización 3FN

---

## Decisión #03
**¿Qué decidí?**
Migrar el framework backend de Django (Python) a NestJS (Node.js + TypeScript).

**¿Por qué?**
El criterio académico indicó que Django facilitaba demasiado el desarrollo,
por lo que se optó por NestJS como framework que exige mayor comprensión
de la arquitectura. NestJS ofrece una estructura modular explícita, uso de
decoradores TypeScript, integración con TypeORM para el modelo relacional,
y autenticación JWT manual, lo que representa un mayor reto técnico y aprendizaje.

**¿Qué artefacto de diseño respalda esta decisión?**
E5 — Diagrama de Componentes UML / E6 — Diagrama de Despliegue UML / E9 — Modelo Relacional