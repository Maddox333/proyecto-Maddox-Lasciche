-- ============================================================
-- SIGAU — Sistema de Información y Gestión Académica Universitaria
-- Script DDL — Creación de tablas en 3FN
-- Motor: PostgreSQL 15.x
-- Autor: Maddox Lasciche
-- ============================================================

-- ============================================================
-- LIMPIEZA PREVIA
-- ============================================================
DROP TABLE IF EXISTS REPORTE_SOPORTE CASCADE;
DROP TABLE IF EXISTS NOTIFICACION   CASCADE;
DROP TABLE IF EXISTS HISTORIAL      CASCADE;
DROP TABLE IF EXISTS CONSULTA       CASCADE;
DROP TABLE IF EXISTS RUTA           CASCADE;
DROP TABLE IF EXISTS UBICACION      CASCADE;
DROP TABLE IF EXISTS ASIGNACION     CASCADE;
DROP TABLE IF EXISTS HORARIO        CASCADE;
DROP TABLE IF EXISTS AULA           CASCADE;
DROP TABLE IF EXISTS PISO           CASCADE;
DROP TABLE IF EXISTS TORRE          CASCADE;
DROP TABLE IF EXISTS MATERIA        CASCADE;
DROP TABLE IF EXISTS DOCENTE        CASCADE;
DROP TABLE IF EXISTS CARRERA        CASCADE;
DROP TABLE IF EXISTS ADMINISTRADOR  CASCADE;
DROP TABLE IF EXISTS ESTUDIANTE     CASCADE;
DROP TABLE IF EXISTS USUARIOS       CASCADE;
DROP TABLE IF EXISTS ROL            CASCADE;

-- ============================================================
-- TABLAS DE SEGURIDAD Y USUARIOS
-- ============================================================

CREATE TABLE ROL (
    id_rol      SERIAL PRIMARY KEY,
    nombre_rol  VARCHAR(50)  NOT NULL UNIQUE,
    descripcion VARCHAR(200)
);

CREATE TABLE USUARIOS (
    id_usuario      SERIAL PRIMARY KEY,
    correo          VARCHAR(100) NOT NULL UNIQUE,
    contrasena      VARCHAR(255) NOT NULL,
    fecha_registro  DATE         NOT NULL DEFAULT CURRENT_DATE,
    activo          BOOLEAN      NOT NULL DEFAULT TRUE,
    id_rol          INT          NOT NULL,
    CONSTRAINT fk_usuarios_rol FOREIGN KEY (id_rol) REFERENCES ROL(id_rol)
);

-- ============================================================
-- TABLAS ACADÉMICAS
-- ============================================================

CREATE TABLE CARRERA (
    id_carrera          SERIAL PRIMARY KEY,
    nombre_carrera      VARCHAR(150) NOT NULL,
    facultad            VARCHAR(150) NOT NULL,
    duracion_semestres  INT          NOT NULL
);

CREATE TABLE ESTUDIANTE (
    id_estudiante       SERIAL PRIMARY KEY,
    nombre              VARCHAR(100) NOT NULL,
    codigo_estudiantil  VARCHAR(20)  NOT NULL UNIQUE,
    semestre            INT          NOT NULL,
    id_usuario          INT          NOT NULL UNIQUE,
    id_carrera          INT          NOT NULL,
    CONSTRAINT fk_estudiante_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIOS(id_usuario) ON DELETE CASCADE,
    CONSTRAINT fk_estudiante_carrera FOREIGN KEY (id_carrera) REFERENCES CARRERA(id_carrera)
);

CREATE TABLE ADMINISTRADOR (
    id_admin    SERIAL PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL,
    cargo       VARCHAR(100),
    id_usuario  INT          NOT NULL UNIQUE,
    CONSTRAINT fk_admin_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIOS(id_usuario) ON DELETE CASCADE
);

CREATE TABLE DOCENTE (
    id_docente      SERIAL PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    correo          VARCHAR(100) NOT NULL UNIQUE,
    departamento    VARCHAR(100),
    id_usuario      INT          NOT NULL UNIQUE,
    CONSTRAINT fk_docente_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIOS(id_usuario) ON DELETE CASCADE
);

CREATE TABLE MATERIA (
    id_materia      SERIAL PRIMARY KEY,
    nombre_materia  VARCHAR(150) NOT NULL,
    codigo_materia  VARCHAR(20)  NOT NULL UNIQUE,
    creditos        INT          NOT NULL,
    id_carrera      INT          NOT NULL,
    CONSTRAINT fk_materia_carrera FOREIGN KEY (id_carrera) REFERENCES CARRERA(id_carrera)
);

-- ============================================================
-- TABLAS DE CAMPUS
-- ============================================================

CREATE TABLE TORRE (
    id_torre        SERIAL PRIMARY KEY,
    nombre_torre    VARCHAR(100) NOT NULL,
    descripcion     VARCHAR(200)
);

CREATE TABLE PISO (
    id_piso         SERIAL PRIMARY KEY,
    numero_piso     INT          NOT NULL,
    descripcion     VARCHAR(200),
    id_torre        INT          NOT NULL,
    CONSTRAINT fk_piso_torre FOREIGN KEY (id_torre) REFERENCES TORRE(id_torre) ON DELETE CASCADE
);

CREATE TABLE AULA (
    id_aula         SERIAL PRIMARY KEY,
    codigo_aula     VARCHAR(20)  NOT NULL UNIQUE,
    capacidad       INT          NOT NULL,
    tipo_aula       VARCHAR(50),
    estado          VARCHAR(20)  NOT NULL DEFAULT 'DISPONIBLE'
                    CHECK (estado IN ('DISPONIBLE','OCUPADA','MANTENIMIENTO')),
    id_piso         INT          NOT NULL,
    CONSTRAINT fk_aula_piso FOREIGN KEY (id_piso) REFERENCES PISO(id_piso) ON DELETE CASCADE
);

CREATE TABLE UBICACION (
    id_ubicacion    SERIAL PRIMARY KEY,
    coordenada_x    DECIMAL(10,6) NOT NULL,
    coordenada_y    DECIMAL(10,6) NOT NULL,
    referencia      VARCHAR(200),
    id_aula         INT           NOT NULL UNIQUE,
    CONSTRAINT fk_ubicacion_aula FOREIGN KEY (id_aula) REFERENCES AULA(id_aula) ON DELETE CASCADE
);

-- ============================================================
-- TABLA DE HORARIO
-- ============================================================

CREATE TABLE HORARIO (
    id_horario  SERIAL PRIMARY KEY,
    dia_semana  VARCHAR(15) NOT NULL
                CHECK (dia_semana IN ('Lunes','Martes','Miércoles','Jueves','Viernes','Sábado')),
    hora_inicio TIME NOT NULL,
    hora_fin    TIME NOT NULL
);

-- ============================================================
-- TABLA DE ASIGNACION
-- ============================================================

CREATE TABLE ASIGNACION (
    id_asignacion   SERIAL PRIMARY KEY,
    periodo         VARCHAR(20)  NOT NULL,
    materia         VARCHAR(100) NOT NULL,
    estado          VARCHAR(15)  NOT NULL DEFAULT 'ACTIVA'
                    CHECK (estado IN ('ACTIVA','INACTIVA','CANCELADA')),
    id_docente      INT          NOT NULL,
    id_aula         INT          NOT NULL,
    id_horario      INT          NOT NULL,
    CONSTRAINT fk_asignacion_docente  FOREIGN KEY (id_docente)  REFERENCES DOCENTE(id_docente),
    CONSTRAINT fk_asignacion_aula     FOREIGN KEY (id_aula)     REFERENCES AULA(id_aula),
    CONSTRAINT fk_asignacion_horario  FOREIGN KEY (id_horario)  REFERENCES HORARIO(id_horario),
    CONSTRAINT uq_asignacion_aula_horario UNIQUE (id_aula, id_horario, periodo)
);

-- ============================================================
-- TABLAS DE NAVEGACIÓN
-- ============================================================

CREATE TABLE RUTA (
    id_ruta             SERIAL PRIMARY KEY,
    distancia_metros    DECIMAL(8,2),
    tiempo_minutos      INT,
    fecha_consulta      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_estudiante       INT          NOT NULL,
    id_aula_origen      INT          NOT NULL,
    id_aula_destino     INT          NOT NULL,
    CONSTRAINT fk_ruta_estudiante FOREIGN KEY (id_estudiante)   REFERENCES ESTUDIANTE(id_estudiante),
    CONSTRAINT fk_ruta_origen     FOREIGN KEY (id_aula_origen)  REFERENCES AULA(id_aula),
    CONSTRAINT fk_ruta_destino    FOREIGN KEY (id_aula_destino) REFERENCES AULA(id_aula),
    CONSTRAINT chk_ruta_aulas_distintas CHECK (id_aula_origen <> id_aula_destino)
);

-- ============================================================
-- TABLAS DE INTERACCIÓN Y TRAZABILIDAD
-- ============================================================

CREATE TABLE CONSULTA (
    id_consulta     SERIAL PRIMARY KEY,
    fecha_consulta  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo_consulta   VARCHAR(50)  NOT NULL,
    id_estudiante   INT          NOT NULL,
    id_aula         INT          NOT NULL,
    CONSTRAINT fk_consulta_estudiante FOREIGN KEY (id_estudiante) REFERENCES ESTUDIANTE(id_estudiante),
    CONSTRAINT fk_consulta_aula       FOREIGN KEY (id_aula)       REFERENCES AULA(id_aula)
);

CREATE TABLE HISTORIAL (
    id_historial    SERIAL PRIMARY KEY,
    fecha_registro  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_estudiante   INT          NOT NULL,
    id_consulta     INT          NOT NULL,
    CONSTRAINT fk_historial_estudiante FOREIGN KEY (id_estudiante) REFERENCES ESTUDIANTE(id_estudiante),
    CONSTRAINT fk_historial_consulta   FOREIGN KEY (id_consulta)   REFERENCES CONSULTA(id_consulta) ON DELETE CASCADE
);

CREATE TABLE NOTIFICACION (
    id_notificacion SERIAL PRIMARY KEY,
    titulo          VARCHAR(100) NOT NULL,
    mensaje         TEXT         NOT NULL,
    fecha_envio     TIMESTAMP    DEFAULT CURRENT_TIMESTAMP,
    estado          VARCHAR(15)  NOT NULL DEFAULT 'ENVIADA'
                    CHECK (estado IN ('ENVIADA','LEIDA','ELIMINADA')),
    id_usuario      INT          NOT NULL,
    CONSTRAINT fk_notificacion_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIOS(id_usuario) ON DELETE CASCADE
);

CREATE TABLE REPORTE_SOPORTE (
    id_reporte          SERIAL PRIMARY KEY,
    tipo_fallo          VARCHAR(100) NOT NULL,
    descripcion         TEXT         NOT NULL,
    estado              VARCHAR(50)  NOT NULL DEFAULT 'Abierto',
    fecha_reporte       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_resolucion    TIMESTAMP    NULL,
    id_estudiante       INT          NOT NULL,
    CONSTRAINT fk_reporte_estudiante FOREIGN KEY (id_estudiante) REFERENCES ESTUDIANTE(id_estudiante)
);

-- ============================================================
-- ÍNDICES DE OPTIMIZACIÓN
-- ============================================================

CREATE INDEX idx_usuarios_correo         ON USUARIOS(correo);
CREATE INDEX idx_estudiante_codigo       ON ESTUDIANTE(codigo_estudiantil);
CREATE INDEX idx_materia_codigo          ON MATERIA(codigo_materia);
CREATE INDEX idx_aula_codigo             ON AULA(codigo_aula);
CREATE INDEX idx_asignacion_docente      ON ASIGNACION(id_docente);
CREATE INDEX idx_asignacion_aula         ON ASIGNACION(id_aula);
CREATE INDEX idx_consulta_estudiante     ON CONSULTA(id_estudiante);
CREATE INDEX idx_historial_estudiante    ON HISTORIAL(id_estudiante);
CREATE INDEX idx_notificacion_usuario    ON NOTIFICACION(id_usuario);
CREATE INDEX idx_reporte_estudiante      ON REPORTE_SOPORTE(id_estudiante);

-- ============================================================
-- SEEDS BÁSICOS
-- ============================================================

INSERT INTO ROL (nombre_rol, descripcion) VALUES
    ('Estudiante',    'Usuario que consulta horarios, aulas y rutas dentro del campus'),
    ('Docente',       'Profesor responsable de materias y aulas asignadas'),
    ('Administrador', 'Gestiona usuarios, infraestructura y reportes del sistema');

-- ============================================================
-- FIN DEL SCRIPT DDL
-- ============================================================
