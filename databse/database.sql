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

-- CREACIÓN DE DIMENSIONES

-- Creación de tabla: dimensión vehículo

CREATE TABLE [dbo].[TBL_DIM_VEHICULO](
[SK_DIM_VEHICULO] [int] IDENTITY(1,1) NOT NULL,
[NOMBRE_VEHICULO] [nvarchar](255) NULL,
[DT_FECHA_ACTUALIZACION] [datetime] DEFAULT GETDATE()
);

-- Creación de tabla: dimensión ips

CREATE TABLE [dbo].[TBL_DIM_IPS](
[SK_DIM_IPS] [int] IDENTITY(1,1) NOT NULL,
[NOMBRE_IPS] [nvarchar](255) NULL,
[DT_FECHA_ACTUALIZACION] [datetime] DEFAULT GETDATE()
);

-- Creación de tabla: dimensión rips

CREATE TABLE [dbo].[TBL_DIM_RIPS](
[SK_DIM_RIPS] [int] IDENTITY(1,1) NOT NULL,
[DESCRIPCION_RIPS] [nvarchar](255) NULL,
[DT_FECHA_ACTUALIZACION] [datetime] DEFAULT GETDATE()
);

-- Creación de tabla: dimensión relación usuario

CREATE TABLE [dbo].[TBL_DIM_RELACION_USUARIO](
[SK_DIM_RELACION] [int] IDENTITY(1,1) NOT NULL,
[NOMBRE_RELACION] [nvarchar](255) NULL,
[DT_FECHA_ACTUALIZACION] [datetime] DEFAULT GETDATE()
);

-- Creación de tabla: dimensión eps

CREATE TABLE [dbo].[TBL_DIM_EPS](
[SK_DIM_EPS] [int] IDENTITY(1,1) NOT NULL,
[NOMBRE_EPS] [nvarchar](255) NULL,
[DT_FECHA_ACTUALIZACION] [datetime] DEFAULT GETDATE()
);

-- Creación de tabla: dimensión tipo afiliación

CREATE TABLE [dbo].[TBL_DIM_AFILIACION](
[SK_DIM_AFILIACION] [int] IDENTITY(1,1) NOT NULL,
[NOMBRE_AFILIACION] [nvarchar](255) NULL,
[DT_FECHA_ACTUALIZACION] [datetime] DEFAULT GETDATE()
);

-- CONSULTAS PARA INGESTAR LAS DIMENSIONES

-- Consulta para ingestar la dimensión de tipo de vehículo

SELECT DISTINCT(TIPO_DE_VEHICULO) AS TIPO_VEHICULO FROM [ACCIDENTES_BUCARAMANGA].[dbo].[ACCIDENTES_RAW]
ORDER BY 1;

-- Consulta para verificar la ingesta en la tabla de dimensión vehículo

SELECT SK_DIM_VEHICULO, NOMBRE_VEHICULO FROM [ACCIDENTES_BUCARAMANGA].[dbo].[TBL_DIM_VEHICULO]

-- Consulta para ingestar la dimensión de ips

SELECT DISTINCT(IPS) AS IPS FROM [ACCIDENTES_BUCARAMANGA].[dbo].[ACCIDENTES_RAW]
ORDER BY 1;

-- Consulta para verificar la ingesta en la tabla de dimensión ips

SELECT SK_DIM_IPS, NOMBRE_IPS FROM [ACCIDENTES_BUCARAMANGA].[dbo].[TBL_DIM_IPS]

-- Consulta para ingestar la dimensión de rips

SELECT DISTINCT(DESCRIPCION_RIPS) AS DESCRIPCION_RIPS FROM [ACCIDENTES_BUCARAMANGA].[dbo].[ACCIDENTES_RAW]
ORDER BY 1;

-- Consulta para verificar la ingesta en la tabla de dimensión rips

SELECT SK_DIM_RIPS, DESCRIPCION_RIPS FROM [ACCIDENTES_BUCARAMANGA].[dbo].[TBL_DIM_RIPS]

-- Consulta para ingestar la dimensión de relación usuario

SELECT DISTINCT(TIPO_ACTOR_VIAL) AS TIPO_ACTOR_VIAL FROM [ACCIDENTES_BUCARAMANGA].[dbo].[ACCIDENTES_RAW]
ORDER BY 1;

-- Consulta para verificar la ingesta en la tabla de dimensión relación usuario

SELECT SK_DIM_RELACION, NOMBRE_RELACION FROM [ACCIDENTES_BUCARAMANGA].[dbo].[TBL_DIM_RELACION_USUARIO]

-- Consulta para ingestar la dimensión de tipo de eps

SELECT DISTINCT(EPS_USUARIO) AS EPS_USUARIO FROM [ACCIDENTES_BUCARAMANGA].[dbo].[ACCIDENTES_RAW]
ORDER BY 1;

-- Consulta para verificar la ingesta en la tabla de dimensión eps

SELECT SK_DIM_EPS, NOMBRE_EPS FROM [ACCIDENTES_BUCARAMANGA].[dbo].[TBL_DIM_EPS]

-- Consulta para ingestar la dimensión de afiliación

SELECT DISTINCT(TIPO_AFILIACION) AS TIPO_AFILIACION FROM [ACCIDENTES_BUCARAMANGA].[dbo].[ACCIDENTES_RAW]
ORDER BY 1;

-- Consulta para verificar la ingesta en la tabla de dimensión afiliación

SELECT SK_DIM_AFILIACION, NOMBRE_AFILIACION FROM [ACCIDENTES_BUCARAMANGA].[dbo].[TBL_DIM_AFILIACION]
