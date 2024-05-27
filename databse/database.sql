-- Crear base de datos
CREATE DATABASE accidentes_bucaramanga;
GO

-- Usar la base de datos recién creada
USE accidentes_bucaramanga;
GO

-- Crear tabla: de datos en crudo
CREATE TABLE ACCIDENTES_RAW (
    EDAD INT,
    SEXO NVARCHAR(10),
    TIPO_DE_VEHICULO NVARCHAR(50),
    TIPO_ACTOR_VIAL NVARCHAR(50),
    FECHA_DE_ACCIDENTE DATE,
    FECHA_DE_INGRESO_IPS DATE,
    HORA_DE_ACCIDENTE TIME,
    HORA_DE_INGRESO_IPS TIME,
    REQUERIMIENTO_DE_CIRUGIA CHAR(2),
    REFERIDO_A_OTRA_IPS CHAR(2),
    POLITRAUMATISMO CHAR(2),
    TIPO_AFILIACION NVARCHAR(50),
    EPS_USUARIO NVARCHAR(255),
    CONDICION_EGRESO NVARCHAR(50),
    COSTOS DECIMAL(18, 2),
    MES NVARCHAR(20),
    IPS NVARCHAR(100),
    AÑO INT,
    TIPO_ADMINISTRADORA NVARCHAR(50),
    CODIGO_RIPS NVARCHAR(50),
    DESCRIPCION_RIPS NVARCHAR(255),
    DIA_SEMANA NVARCHAR(20),
    RANGO_EDAD_AÑOS NVARCHAR(20),
    CURSO_DE_VIDA NVARCHAR(50)
);



-- Crear tabla: relacion_usuario
CREATE TABLE relacion_usuario (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre_relacion NVARCHAR(255) NOT NULL
);
GO

-- Crear tabla: tipo_afiliacion
CREATE TABLE tipo_afiliacion (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre_afiliacion NVARCHAR(255) NOT NULL
);
GO

-- Crear tabla: ips
CREATE TABLE ips (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre_ips NVARCHAR(255) NOT NULL
);
GO

-- Crear tabla: codigo_rips
CREATE TABLE codigo_rips (
    id VARCHAR(50) PRIMARY KEY,
    descripcion NVARCHAR(255) NOT NULL
);
GO

-- Crear tabla: tipo_vehiculo
CREATE TABLE tipo_vehiculo (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre_tipo_vehiculo NVARCHAR(255) NOT NULL
);
GO

-- Crear tabla: eps
CREATE TABLE eps (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre_eps NVARCHAR(255) NOT NULL
);
GO

-- Crear tabla: curso_vida
CREATE TABLE curso_vida (
    id INT PRIMARY KEY IDENTITY(1,1),
    rango_edades NVARCHAR(255) NOT NULL,
    categoria NVARCHAR(255) NOT NULL
);
GO

-- Crear tabla: registro_accidentes
CREATE TABLE registro_accidentes (
    id INT PRIMARY KEY IDENTITY(1,1),
    edad INT NOT NULL,
    sexo CHAR(1) NOT NULL,
	relacion_usuario_id INT NOT NULL,
    tipo_vehiculo_id INT NOT NULL,
    fecha_accidente DATE,
    fecha_ingreso_ips DATE,
    requerimiento_cx BIT NOT NULL,
    referido_otra_ips BIT NOT NULL,
    politraumatismo BIT NOT NULL,
    tipo_afiliacion_id INT NOT NULL,
    eps_id INT NOT NULL,
    condicion_egreso NVARCHAR(255) NOT NULL,
    costo DECIMAL(18, 2) NOT NULL,
    ips_id INT NOT NULL,
    curso_vida_id INT NOT NULL,
    dia_semana NVARCHAR(50) NOT NULL,
    rips_id VARCHAR(50) NOT NULL,
);