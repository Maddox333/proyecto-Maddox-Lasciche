# M8 — Matriz de Trazabilidad: DDL y Modelo Relacional

## Sistema: SIGAU
**Sistema de Información y Gestión Académica Universitaria**

---

## Descripción

Esta matriz verifica que cada tabla del DDL corresponde a una entidad
del modelo relacional, que el script SQL es correcto y que las
restricciones de integridad están implementadas.

---

## Correspondencia DDL — Modelo Relacional

| # | Tabla DDL | Entidad Relacional | CREATE TABLE | PK definida | FK definidas | Constraints | Cobertura |
|---|---|---|---|---|---|---|---|
| 1 | ROL | ROL | ✅ | ✅ | — | NOT NULL | 100% |
| 2 | USUARIOS | USUARIOS | ✅ | ✅ | id_rol → ROL | NOT NULL, UNIQUE | 100% |
| 3 | ESTUDIANTE | ESTUDIANTE | ✅ | ✅ | id_usuario → USUARIOS, id_carrera → CARRERA | NOT NULL, UNIQUE | 100% |
| 4 | DOCENTE | DOCENTE | ✅ | ✅ | id_usuario → USUARIOS | NOT NULL, UNIQUE | 100% |
| 5 | ADMINISTRADOR | ADMINISTRADOR | ✅ | ✅ | id_usuario → USUARIOS | NOT NULL, UNIQUE | 100% |
| 6 | CARRERA | CARRERA | ✅ | ✅ | — | NOT NULL | 100% |
| 7 | MATERIA | MATERIA | ✅ | ✅ | id_carrera → CARRERA | NOT NULL | 100% |
| 8 | HORARIO | HORARIO | ✅ | ✅ | — | NOT NULL | 100% |
| 9 | ASIGNACION | ASIGNACION | ✅ | ✅ | id_docente, id_materia, id_aula, id_horario | NOT NULL, UNIQUE | 100% |
| 10 | TORRE | TORRE | ✅ | ✅ | — | NOT NULL | 100% |
| 11 | PISO | PISO | ✅ | ✅ | id_torre → TORRE | NOT NULL | 100% |
| 12 | AULA | AULA | ✅ | ✅ | id_piso → PISO | NOT NULL, UNIQUE | 100% |
| 13 | UBICACION | UBICACION | ✅ | ✅ | id_aula → AULA | NOT NULL, UNIQUE | 100% |
| 14 | CONSULTA | CONSULTA | ✅ | ✅ | id_estudiante → ESTUDIANTE, id_aula → AULA | NOT NULL | 100% |
| 15 | NOTIFICACION | NOTIFICACION | ✅ | ✅ | id_usuario → USUARIOS | NOT NULL | 100% |
| 16 | REPORTE_SOPORTE | REPORTE_SOPORTE | ✅ | ✅ | id_estudiante → ESTUDIANTE, id_aula → AULA | NOT NULL | 100% |

---

## Script DDL Completo

> **Nota:** la versión completa y vigente del DDL vive en
> [`../diseño/fase2-datos/E11-script-DDL.sql`](../diseño/fase2-datos/E11-script-DDL.sql)
> y está escrita para **PostgreSQL 15**. El bloque siguiente es un resumen
> ilustrativo (sintaxis PostgreSQL) que reproduce las tablas principales.

```sql
-- ============================================================
-- SIGAU — Script DDL Completo
-- Sistema de Información y Gestión Académica Universitaria
-- Módulo: Mapa Interactivo y Navegación de Aulas
-- Base de datos: PostgreSQL 15.x
-- ============================================================

-- ------------------------------------------------------------
-- 1. ROL
-- ------------------------------------------------------------
CREATE TABLE ROL (
    id_rol      SERIAL PRIMARY KEY,
    nombre_rol  VARCHAR(50) NOT NULL
);

-- ------------------------------------------------------------
-- 2. USUARIOS
-- ------------------------------------------------------------
CREATE TABLE USUARIOS (
    id_usuario  SERIAL PRIMARY KEY,
    correo      VARCHAR(100) NOT NULL UNIQUE,
    password    VARCHAR(255) NOT NULL,
    id_rol      INT NOT NULL,
    CONSTRAINT fk_usuarios_rol FOREIGN KEY (id_rol)
        REFERENCES ROL(id_rol)
);

-- ------------------------------------------------------------
-- 3. CARRERA
-- ------------------------------------------------------------
CREATE TABLE CARRERA (
    id_carrera      SERIAL PRIMARY KEY,
    nombre_carrera  VARCHAR(100) NOT NULL,
    facultad        VARCHAR(100) NOT NULL
);

-- ------------------------------------------------------------
-- 4. ESTUDIANTE
-- ------------------------------------------------------------
CREATE TABLE ESTUDIANTE (
    id_estudiante       SERIAL PRIMARY KEY,
    id_usuario          INT NOT NULL UNIQUE,
    id_carrera          INT NOT NULL,
    nombre              VARCHAR(100) NOT NULL,
    codigo_estudiantil  VARCHAR(20) NOT NULL UNIQUE,
    semestre            INT NOT NULL,
    CONSTRAINT fk_estudiante_usuario FOREIGN KEY (id_usuario)
        REFERENCES USUARIOS(id_usuario),
    CONSTRAINT fk_estudiante_carrera FOREIGN KEY (id_carrera)
        REFERENCES CARRERA(id_carrera)
);

-- ------------------------------------------------------------
-- 5. DOCENTE
-- ------------------------------------------------------------
CREATE TABLE DOCENTE (
    id_docente      SERIAL PRIMARY KEY,
    id_usuario      INT NOT NULL UNIQUE,
    nombre          VARCHAR(100) NOT NULL,
    correo          VARCHAR(100) NOT NULL UNIQUE,
    departamento    VARCHAR(100),
    CONSTRAINT fk_docente_usuario FOREIGN KEY (id_usuario)
        REFERENCES USUARIOS(id_usuario)
);

-- ------------------------------------------------------------
-- 6. ADMINISTRADOR
-- ------------------------------------------------------------
CREATE TABLE ADMINISTRADOR (
    id_administrador    SERIAL PRIMARY KEY,
    id_usuario          INT NOT NULL UNIQUE,
    nombre              VARCHAR(100) NOT NULL,
    CONSTRAINT fk_admin_usuario FOREIGN KEY (id_usuario)
        REFERENCES USUARIOS(id_usuario)
);

-- ------------------------------------------------------------
-- 7. MATERIA
-- ------------------------------------------------------------
CREATE TABLE MATERIA (
    id_materia      SERIAL PRIMARY KEY,
    id_carrera      INT NOT NULL,
    nombre_materia  VARCHAR(100) NOT NULL,
    creditos        INT NOT NULL,
    semestre        INT NOT NULL,
    CONSTRAINT fk_materia_carrera FOREIGN KEY (id_carrera)
        REFERENCES CARRERA(id_carrera)
);

-- ------------------------------------------------------------
-- 8. HORARIO
-- ------------------------------------------------------------
CREATE TABLE HORARIO (
    id_horario      SERIAL PRIMARY KEY,
    dia_semana      VARCHAR(20) NOT NULL,
    hora_inicio     TIME NOT NULL,
    hora_fin        TIME NOT NULL
);

-- ------------------------------------------------------------
-- 9. TORRE
-- ------------------------------------------------------------
CREATE TABLE TORRE (
    id_torre        SERIAL PRIMARY KEY,
    nombre_torre    VARCHAR(50) NOT NULL,
    descripcion     TEXT
);

-- ------------------------------------------------------------
-- 10. PISO
-- ------------------------------------------------------------
CREATE TABLE PISO (
    id_piso         SERIAL PRIMARY KEY,
    id_torre        INT NOT NULL,
    numero_piso     INT NOT NULL,
    descripcion     TEXT,
    CONSTRAINT fk_piso_torre FOREIGN KEY (id_torre)
        REFERENCES TORRE(id_torre)
);

-- ------------------------------------------------------------
-- 11. AULA
-- ------------------------------------------------------------
CREATE TABLE AULA (
    id_aula         SERIAL PRIMARY KEY,
    id_piso         INT NOT NULL,
    codigo_aula     VARCHAR(20) NOT NULL UNIQUE,
    capacidad       INT NOT NULL,
    tipo            VARCHAR(50) NOT NULL,
    estado          VARCHAR(20) NOT NULL
                    CHECK (estado IN ('DISPONIBLE','OCUPADA','MANTENIMIENTO')),
    CONSTRAINT fk_aula_piso FOREIGN KEY (id_piso)
        REFERENCES PISO(id_piso)
);

-- ------------------------------------------------------------
-- 12. UBICACION
-- ------------------------------------------------------------
CREATE TABLE UBICACION (
    id_ubicacion    SERIAL PRIMARY KEY,
    id_aula         INT NOT NULL UNIQUE,
    latitud         DECIMAL(10,8) NOT NULL,
    longitud        DECIMAL(11,8) NOT NULL,
    referencia      TEXT,
    CONSTRAINT fk_ubicacion_aula FOREIGN KEY (id_aula)
        REFERENCES AULA(id_aula)
);

-- ------------------------------------------------------------
-- 13. ASIGNACION
-- ------------------------------------------------------------
CREATE TABLE ASIGNACION (
    id_asignacion   SERIAL PRIMARY KEY,
    id_docente      INT NOT NULL,
    id_materia      INT NOT NULL,
    id_aula         INT NOT NULL,
    id_horario      INT NOT NULL,
    periodo         VARCHAR(20) NOT NULL,
    CONSTRAINT fk_asig_docente  FOREIGN KEY (id_docente)
        REFERENCES DOCENTE(id_docente),
    CONSTRAINT fk_asig_materia  FOREIGN KEY (id_materia)
        REFERENCES MATERIA(id_materia),
    CONSTRAINT fk_asig_aula     FOREIGN KEY (id_aula)
        REFERENCES AULA(id_aula),
    CONSTRAINT fk_asig_horario  FOREIGN KEY (id_horario)
        REFERENCES HORARIO(id_horario),
    CONSTRAINT uq_asig_aula_horario UNIQUE (id_aula, id_horario, periodo)
);

-- ------------------------------------------------------------
-- 14. CONSULTA
-- ------------------------------------------------------------
CREATE TABLE CONSULTA (
    id_consulta     SERIAL PRIMARY KEY,
    id_estudiante   INT NOT NULL,
    id_aula         INT NOT NULL,
    fecha_consulta  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    resultado       VARCHAR(20) NOT NULL
                    CHECK (resultado IN ('EXITOSA','FALLIDA')),
    CONSTRAINT fk_consulta_estudiante FOREIGN KEY (id_estudiante)
        REFERENCES ESTUDIANTE(id_estudiante),
    CONSTRAINT fk_consulta_aula FOREIGN KEY (id_aula)
        REFERENCES AULA(id_aula)
);

-- ------------------------------------------------------------
-- 15. NOTIFICACION
-- ------------------------------------------------------------
CREATE TABLE NOTIFICACION (
    id_notificacion SERIAL PRIMARY KEY,
    id_usuario      INT NOT NULL,
    titulo          VARCHAR(100) NOT NULL,
    mensaje         TEXT NOT NULL,
    fecha_envio     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado          VARCHAR(20) NOT NULL
                    CHECK (estado IN ('ENVIADA','LEIDA','ELIMINADA')),
    CONSTRAINT fk_notif_usuario FOREIGN KEY (id_usuario)
        REFERENCES USUARIOS(id_usuario)
);

-- ------------------------------------------------------------
-- 16. REPORTE_SOPORTE
-- ------------------------------------------------------------
CREATE TABLE REPORTE_SOPORTE (
    id_reporte      SERIAL PRIMARY KEY,
    id_estudiante   INT NOT NULL,
    id_aula         INT NOT NULL,
    descripcion     TEXT NOT NULL,
    fecha_reporte   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado          VARCHAR(20) NOT NULL
                    CHECK (estado IN ('PENDIENTE','EN_REVISION','RESUELTO')),
    CONSTRAINT fk_reporte_estudiante FOREIGN KEY (id_estudiante)
        REFERENCES ESTUDIANTE(id_estudiante),
    CONSTRAINT fk_reporte_aula FOREIGN KEY (id_aula)
        REFERENCES AULA(id_aula)
);



Orden de Creación de Tablas
El orden respeta las dependencias de FK:

1. ROL
2. CARRERA
3. TORRE
4. HORARIO
5. USUARIOS       → depende de ROL
6. ESTUDIANTE     → depende de USUARIOS, CARRERA
7. DOCENTE        → depende de USUARIOS
8. ADMINISTRADOR  → depende de USUARIOS
9. MATERIA        → depende de CARRERA
10. PISO          → depende de TORRE
11. AULA          → depende de PISO
12. UBICACION     → depende de AULA
13. ASIGNACION    → depende de DOCENTE, MATERIA, AULA, HORARIO
14. CONSULTA      → depende de ESTUDIANTE, AULA
15. NOTIFICACION  → depende de USUARIOS
16. REPORTE_SOPORTE → depende de ESTUDIANTE, AULA


