# Decisiones Técnicas — SIGAU

## Decisión #01
**¿Qué decidí?**  
Usar Django (Python) como framework de desarrollo backend.

**¿Por qué?**  
Django ofrece un ORM que mapea directamente las entidades del modelo relacional,
un sistema de autenticación integrado compatible con los roles definidos en el MER
(Estudiante, Administrador), y una arquitectura MTV que se alinea con los componentes
definidos en el E5.

**¿Qué artefacto de diseño respalda esta decisión?**  
E5 - Diagrama de Componentes UML / E6 - Diagrama de Despliegue UML / E9 - Modelo Relacional

## Decisión #02
**¿Qué decidí?**  
Usar MySQL 8.0 como motor de base de datos en lugar de PostgreSQL.

**¿Por qué?**  
MySQL es ampliamente usado en entornos académicos, tiene mejor integración
con Django mediante el conector `mysqlclient`, y es más familiar para el
equipo de desarrollo. El motor InnoDB garantiza soporte completo de
integridad referencial y transacciones ACID.

**¿Qué artefacto de diseño respalda esta decisión?**  
E11 - Script DDL / E9 - Modelo Relacional / E10 - Normalización 3FN