# SIGAU — Sistema de Información y Gestión Académica Universitaria
## Módulo: Mapa de Aulas — Corporación Universitaria Remington

## ¿Qué módulo implementas?
Módulo de **Mapa Interactivo y Navegación de Aulas**: permite a los estudiantes
consultar su horario académico, localizar aulas en el campus y calcular rutas hacia ellas.

## ¿Qué tablas cubre tu módulo?
`USUARIOS`, `ROL`, `ESTUDIANTE`, `ADMINISTRADOR`, `CARRERA`, `DOCENTE`,
`MATERIA`, `ASIGNACION`, `AULA`, `PISO`, `TORRE`, `UBICACION`,
`RUTA`, `CONSULTA`, `HISTORIAL`, `NOTIFICACION`, `REPORTE_SOPORTE`

## ¿Qué framework elegiste y por qué?
**Framework:** Django (Python)  
**Razón:** Arquitectura MTV alineada con los componentes del E5, ORM robusto
para mapear el modelo relacional del E9-E10, y admin panel integrado útil
para el rol Administrador definido en el MER.

## ¿Cómo ejecutar el proyecto?
```bash
# Clonar el repositorio
git clone https://github.com/Maddox333/proyecto-Maddox-Lasciche.git
cd proyecto-Maddox-Lasciche

