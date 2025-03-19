CREATE DATABASE LCS1_Principal;
USE LCS1_Principal;

CREATE TABLE flotilla (
    flotillaId INT PRIMARY KEY,
    nombreEmpresa VARCHAR(100),
    gestorFlotilla VARCHAR(100),
    fechaCreacion DATE
);

CREATE TABLE vehiculo (
    vehiculoId INT PRIMARY KEY,
    flotillaId INT,
    tipo VARCHAR(50),
    modelo VARCHAR(50),
    marca VARCHAR(50),
    anio INT,
    estado VARCHAR(20),
    fechaVerificacion DATE
);

CREATE TABLE documento (
    documentoId INT PRIMARY KEY,
    vehiculoId INT,
    tipo VARCHAR(50),
    fechaVencimiento DATE,
    estado VARCHAR(20),
    rutaArchivo VARCHAR(255)
);
/*-----------------------------------------------------------------------------------------------------------------*/

CREATE DATABASE LCS2_Mantenimiento;
USE LCS2_Mantenimiento;

CREATE TABLE vehiculo (
    vehiculoId INT PRIMARY KEY,
    estado VARCHAR(20),
    fechaVerificacion DATE
);

CREATE TABLE mantenimiento (
    mantenimientoId INT PRIMARY KEY,
    vehiculoId INT,
    fechaServicio DATE,
    tipoServicio VARCHAR(100),
    descripcion VARCHAR(200),
    costo DECIMAL(10, 2),
    estado VARCHAR(20)
);
/*------------------------------------------------------------------------*/

CREATE DATABASE lcs3_Rutas;
USE lcs3_Rutas;

CREATE TABLE vehiculo (
    vehiculoId INT PRIMARY KEY,
    tipo VARCHAR(50),
    modelo VARCHAR(50),
    marca VARCHAR(50),
    anio INT
);

CREATE TABLE conductor (
    conductorId INT PRIMARY KEY,
    nombre VARCHAR(100),
    numeroLicencia VARCHAR(50),
    vencimientoLicencia DATE,
    estado VARCHAR(20)
);

CREATE TABLE ruta (
    rutaId INT PRIMARY KEY,
    vehiculoId INT,
    conductorId INT,
    horaInicio DATETIME,
    horaFin DATETIME,
    distancia DECIMAL(10, 2),
    ubicacionInicio VARCHAR(100),
    ubicacionFin VARCHAR(100),
    estado VARCHAR(20)
);

CREATE TABLE transaccionCombustible (
    transaccionId INT PRIMARY KEY,
    vehiculoId INT,
    conductorId INT,
    monto DECIMAL(10, 2),
    cantidad DECIMAL(10, 2),
    tipoCombustible VARCHAR(20),
    fechaTransaccion DATETIME,
    ubicacion VARCHAR(100)
);

#--------------------------------------------------------------------------------------------------------------------
#--------------------------------------------------------------------------------------------------------------------

USE sistemagestionflotillas;
SELECT * FROM mantenimiento INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/mantenimiento.txt' FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT * FROM flotilla INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/flotilla.txt' FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT * FROM vehiculo INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/vehiculo.txt' FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT * FROM documento INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/documento.txt' FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT * FROM conductor INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/conductor.txt' FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT * FROM ruta INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ruta.txt' FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT * FROM transaccioncombustible INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/transaccioncombustible.txt' FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';


#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use lcs1_principal;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/documento.txt'
INTO TABLE documento
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/flotilla.txt'
INTO TABLE flotilla
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/vehiculo.txt'
INTO TABLE vehiculo
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

use sistemagestionflotillas;
SELECT vehiculoId, estado, fechaVerificacion
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/vehiculo_lcs2.txt'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM vehiculo;

SELECT vehiculoId, tipo, modelo, marca, anio
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/vehiculo_lcs3.txt'
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
FROM vehiculo;

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

use lcs2_mantenimiento;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/mantenimiento.txt'
INTO TABLE mantenimiento
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/vehiculo_lcs2.txt'
INTO TABLE vehiculo
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

#---------------------------------------------------------------------------------------------------------------------

use lcs3_rutas;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/conductor.txt'
INTO TABLE conductor
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ruta.txt'
INTO TABLE ruta
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/transaccioncombustible.txt'
INTO TABLE transaccioncombustible
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

use lcs3_rutas;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/vehiculo_lcs3.txt'
INTO TABLE vehiculo
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

SELECT @@secure_file_priv;

#--------------------------------------------------------------------------------------------------------------------

SELECT 
    r.rutaId,
    r.horaInicio,
    r.horaFin,
    r.distancia,
    r.ubicacionInicio,
    r.ubicacionFin,
    r.estado AS estado_ruta,
    c.nombre AS nombre_conductor,
    c.numeroLicencia,
    v.tipo AS tipo_vehiculo,
    v.modelo,
    v.marca,
    v.anio
FROM 
    LCS3_Rutas.ruta r
JOIN 
    LCS3_Rutas.conductor c
ON 
    r.conductorId = c.conductorId
JOIN 
    LCS1_Principal.vehiculo v
ON 
    r.vehiculoId = v.vehiculoId
WHERE 
    r.estado = 'Completada'
ORDER BY 
    r.horaInicio DESC;
    
    
#--------------------------------------------------------------------------------------------------------------------

SELECT 
    c.conductorId,
    c.nombre,
    c.numeroLicencia,
    c.estado AS estado_conductor,
    v.tipo AS tipo_vehiculo,
    v.modelo,
    v.marca
FROM 
    LCS3_Rutas.conductor c
JOIN 
    LCS1_Principal.vehiculo v
ON 
    c.conductorId = v.vehiculoId
WHERE 
    c.estado = 'Activo';
    
#--------------------------------------------------------------------------------------------------------------------

