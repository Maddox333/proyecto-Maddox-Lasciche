-- ============================================================
-- SIGAU — Sistema de Información y Gestión Académica Universitaria
-- Script DDL — Creación de tablas en 3FN
-- Motor: MySQL 8.0
-- Autor: Maddox Lasciche
-- ============================================================

-- ============================================================
-- LIMPIEZA PREVIA
-- ============================================================
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS REPORTE_SOPORTE;
DROP TABLE IF EXISTS NOTIFICACION;
DROP TABLE IF EXISTS HISTORIAL;
DROP TABLE IF EXISTS CONSULTA;
DROP TABLE IF EXISTS RUTA;
DROP TABLE IF EXISTS UBICACION;
DROP TABLE IF EXISTS ASIGNACION;
DROP TABLE IF EXISTS AULA;
DROP TABLE IF EXISTS PISO;
DROP TABLE IF EXISTS TORRE;
DROP TABLE IF EXISTS MATERIA;
DROP TABLE IF EXISTS DOCENTE;
DROP TABLE IF EXISTS CARRERA;
DROP TABLE IF EXISTS ADMINISTRADOR;
DROP TABLE IF EXISTS ESTUDIANTE;
DROP TABLE IF EXISTS USUARIOS;
DROP TABLE IF EXISTS ROL;

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- TABLAS DE SEGURIDAD Y USUARIOS
-- ============================================================

CREATE TABLE ROL (
    id_rol      INT AUTO_INCREMENT PRIMARY KEY,
    nombre_rol  VARCHAR(50)  NOT NULL UNIQUE,
    descripcion VARCHAR(200)
) ENGINE=InnoDB;

CREATE TABLE USUARIOS (
    id_usuario      INT AUTO_INCREMENT PRIMARY KEY,
    correo          VARCHAR(100) NOT NULL UNIQUE,
    contrasena      VARCHAR(255) NOT NULL,
    fecha_registro  DATE         NOT NULL DEFAULT (CURRENT_DATE),
    activo          BOOLEAN      NOT NULL DEFAULT TRUE,
    id_rol          INT          NOT NULL,
    CONSTRAINT fk_usuarios_rol FOREIGN KEY (id_rol) REFERENCES ROL(id_rol)
) ENGINE=InnoDB;

-- ============================================================
-- TABLAS ACADÉMICAS
-- ============================================================

CREATE TABLE CARRERA (
    id_carrera          INT AUTO_INCREMENT PRIMARY KEY,
    nombre_carrera      VARCHAR(150) NOT NULL,
    facultad            VARCHAR(150) NOT NULL,
    duracion_semestres  INT          NOT NULL
) ENGINE=InnoDB;

CREATE TABLE ESTUDIANTE (
    id_estudiante       INT AUTO_INCREMENT PRIMARY KEY,
    nombre              VARCHAR(100) NOT NULL,
    codigo_estudiantil  VARCHAR(20)  NOT NULL UNIQUE,
    semestre            INT          NOT NULL,
    id_usuario          INT          NOT NULL UNIQUE,
    id_carrera          INT          NOT NULL,
    CONSTRAINT fk_estudiante_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIOS(id_usuario),
    CONSTRAINT fk_estudiante_carrera FOREIGN KEY (id_carrera) REFERENCES CARRERA(id_carrera)
) ENGINE=InnoDB;

CREATE TABLE ADMINISTRADOR (
    id_admin    INT AUTO_INCREMENT PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL,
    cargo       VARCHAR(100),
    id_usuario  INT          NOT NULL UNIQUE,
    CONSTRAINT fk_admin_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIOS(id_usuario)
) ENGINE=InnoDB;

CREATE TABLE DOCENTE (
    id_docente      INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    correo          VARCHAR(100) NOT NULL UNIQUE,
    departamento    VARCHAR(100),
    id_usuario      INT          NOT NULL UNIQUE,
    CONSTRAINT fk_docente_usuario FOREIGN KEY (id_usuario) REFERENCES USUARIOS(id_usuario)
) ENGINE=InnoDB;

CREATE TABLE MATERIA (
    id_materia      INT AUTO_INCREMENT PRIMARY KEY,
    nombre_materia  VARCHAR(150) NOT NULL,
    codigo_materia  VARCHAR(20)  NOT NULL UNIQUE,
    creditos        INT          NOT NULL,
    id_carrera      INT          NOT NULL,
    CONSTRAINT fk_materia_carrera FOREIGN KEY (id_carrera) REFERENCES CARRERA(id_carrera)
) ENGINE=InnoDB;

-- ============================================================
-- TABLAS DE CAMPUS
-- ============================================================

CREATE TABLE TORRE (
    id_torre        INT AUTO_INCREMENT PRIMARY KEY,
    nombre_torre    VARCHAR(100) NOT NULL,
    descripcion     VARCHAR(200)
) ENGINE=InnoDB;

CREATE TABLE PISO (
    id_piso         INT AUTO_INCREMENT PRIMARY KEY,
    numero_piso     INT          NOT NULL,
    descripcion     VARCHAR(200),
    id_torre        INT          NOT NULL,
    CONSTRAINT fk_piso_torre FOREIGN KEY (id_torre) REFERENCES TORRE(id_torre)
) ENGINE=InnoDB;

CREATE TABLE AULA (
    id_aula         INT AUTO_INCREMENT PRIMARY KEY,
    codigo_aula     VARCHAR(20)  NOT NULL UNIQUE,
    capacidad       INT          NOT NULL,
    tipo_aula       VARCHAR(50),
    disponible      BOOLEAN      NOT NULL DEFAULT TRUE,
    id_piso         INT          NOT NULL,
    CONSTRAINT fk_aula_piso FOREIGN KEY (id_piso) REFERENCES PISO(id_piso)
) ENGINE=InnoDB;

CREATE TABLE UBICACION (
    id_ubicacion    INT AUTO_INCREMENT PRIMARY KEY,
    coordenada_x    DECIMAL(10,6) NOT NULL,
    coordenada_y    DECIMAL(10,6) NOT NULL,
    referencia      VARCHAR(200),
    id_aula         INT           NOT NULL UNIQUE,
    CONSTRAINT fk_ubicacion_aula FOREIGN KEY (id_aula) REFERENCES AULA(id_aula)
) ENGINE=InnoDB;

-- ============================================================
-- TABLA DE ASIGNACION (HORARIO)
-- ============================================================

CREATE TABLE ASIGNACION (
    id_asignacion   INT AUTO_INCREMENT PRIMARY KEY,
    dia_semana      VARCHAR(20)  NOT NULL,
    hora_inicio     TIME         NOT NULL,
    hora_fin        TIME         NOT NULL,
    id_materia      INT          NOT NULL,
    id_docente      INT          NOT NULL,
    id_aula         INT          NOT NULL,
    id_estudiante   INT          NOT NULL,
    CONSTRAINT fk_asignacion_materia    FOREIGN KEY (id_materia)    REFERENCES MATERIA(id_materia),
    CONSTRAINT fk_asignacion_docente    FOREIGN KEY (id_docente)    REFERENCES DOCENTE(id_docente),
    CONSTRAINT fk_asignacion_aula       FOREIGN KEY (id_aula)       REFERENCES AULA(id_aula),
    CONSTRAINT fk_asignacion_estudiante FOREIGN KEY (id_estudiante) REFERENCES ESTUDIANTE(id_estudiante)
) ENGINE=InnoDB;

-- ============================================================
-- TABLAS DE NAVEGACIÓN
-- ============================================================

CREATE TABLE RUTA (
    id_ruta             INT AUTO_INCREMENT PRIMARY KEY,
    distancia_metros    DECIMAL(8,2),
    tiempo_minutos      INT,
    fecha_consulta      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_estudiante       INT          NOT NULL,
    id_aula_origen      INT          NOT NULL,
    id_aula_destino     INT          NOT NULL,
    CONSTRAINT fk_ruta_estudiante FOREIGN KEY (id_estudiante)   REFERENCES ESTUDIANTE(id_estudiante),
    CONSTRAINT fk_ruta_origen     FOREIGN KEY (id_aula_origen)  REFERENCES AULA(id_aula),
    CONSTRAINT fk_ruta_destino    FOREIGN KEY (id_aula_destino) REFERENCES AULA(id_aula)
) ENGINE=InnoDB;

-- ============================================================
-- TABLAS DE INTERACCIÓN Y TRAZABILIDAD
-- ============================================================

CREATE TABLE CONSULTA (
    id_consulta     INT AUTO_INCREMENT PRIMARY KEY,
    fecha_consulta  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo_consulta   VARCHAR(50)  NOT NULL,
    id_estudiante   INT          NOT NULL,
    id_aula         INT          NOT NULL,
    CONSTRAINT fk_consulta_estudiante FOREIGN KEY (id_estudiante) REFERENCES ESTUDIANTE(id_estudiante),
    CONSTRAINT fk_consulta_aula       FOREIGN KEY (id_aula)       REFERENCES AULA(id_aula)
) ENGINE=InnoDB;

CREATE TABLE HISTORIAL (
    id_historial    INT AUTO_INCREMENT PRIMARY KEY,
    fecha_registro  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_estudiante   INT          NOT NULL,
    id_consulta     INT          NOT NULL,
    CONSTRAINT fk_historial_estudiante FOREIGN KEY (id_estudiante) REFERENCES ESTUDIANTE(id_estudiante),
    CONSTRAINT fk_historial_consulta   FOREIGN KEY (id_consulta)   REFERENCES CONSULTA(id_consulta)
) ENGINE=InnoDB;

CREATE TABLE NOTIFICACION (
    id_notificacion INT AUTO_INCREMENT PRIMARY KEY,
    titulo          VARCHAR(150) NOT NULL,
    mensaje         TEXT         NOT NULL,
    tipo            VARCHAR(50)  NOT NULL,
    leida           BOOLEAN      NOT NULL DEFAULT FALSE,
    fecha_envio     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_estudiante   INT          NOT NULL,
    CONSTRAINT fk_notificacion_estudiante FOREIGN KEY (id_estudiante) REFERENCES ESTUDIANTE(id_estudiante)
) ENGINE=InnoDB;

CREATE TABLE REPORTE_SOPORTE (
    id_reporte          INT AUTO_INCREMENT PRIMARY KEY,
    tipo_fallo          VARCHAR(100) NOT NULL,
    descripcion         TEXT         NOT NULL,
    estado              VARCHAR(50)  NOT NULL DEFAULT 'Abierto',
    fecha_reporte       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_resolucion    TIMESTAMP    NULL,
    id_estudiante       INT          NOT NULL,
    CONSTRAINT fk_reporte_estudiante FOREIGN KEY (id_estudiante) REFERENCES ESTUDIANTE(id_estudiante)
) ENGINE=InnoDB;

-- ============================================================
-- ÍNDICES DE OPTIMIZACIÓN
-- ============================================================

CREATE INDEX idx_usuarios_correo         ON USUARIOS(correo);
CREATE INDEX idx_estudiante_codigo       ON ESTUDIANTE(codigo_estudiantil);
CREATE INDEX idx_materia_codigo          ON MATERIA(codigo_materia);
CREATE INDEX idx_aula_codigo             ON AULA(codigo_aula);
CREATE INDEX idx_asignacion_estudiante   ON ASIGNACION(id_estudiante);
CREATE INDEX idx_asignacion_aula         ON ASIGNACION(id_aula);
CREATE INDEX idx_consulta_estudiante     ON CONSULTA(id_estudiante);
CREATE INDEX idx_historial_estudiante    ON HISTORIAL(id_estudiante);
CREATE INDEX idx_notificacion_estudiante ON NOTIFICACION(id_estudiante);
CREATE INDEX idx_reporte_estudiante      ON REPORTE_SOPORTE(id_estudiante);

-- ============================================================
-- FIN DEL SCRIPT DDL
-- ============================================================