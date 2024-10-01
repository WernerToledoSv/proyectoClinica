CREATE TABLE lugar (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    horainicio TIME NOT NULL,
    horafin TIME NOT NULL,
    fecha DATE NOT NULL
);

CREATE TABLE rol (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    descripcion TEXT 
);

CREATE TYPE est_users AS ENUM ('disponible', 'no disponible');
CREATE TYPE ty_sexo AS ENUM ('m', 'f');

CREATE TABLE usuario (
    id SERIAL PRIMARY KEY,
    idrol INT,
    idlugar INT,
    username VARCHAR(100) NOT NULL UNIQUE,
    password TEXT NOT NULL,
    nombres VARCHAR(255) NOT NULL,
    apellidos VARCHAR(255) NOT NULL,
    sexo ty_sexo NOT NULL,
    cel VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    fechaingreso DATE NOT NULL,
    estado est_users DEFAULT 'disponible',

    CONSTRAINT fk_idrol_user FOREIGN KEY (idrol) REFERENCES rol(id),
    CONSTRAINT fk_idlugar_user FOREIGN KEY (idlugar) REFERENCES lugar(id)
);

CREATE TABLE enfermero (
    id SERIAL PRIMARY KEY,
    idrol INT,
    username VARCHAR(100) NOT NULL UNIQUE,
    password TEXT NOT NULL,
    nombres VARCHAR(255) NOT NULL,
    apellidos VARCHAR(255) NOT NULL,
    sexo ty_sexo NOT NULL,
    cel VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    profesion TEXT,
    numerojunta VARCHAR(100),
    fechaingreso DATE,
    estado est_users DEFAULT 'disponible',

    CONSTRAINT fk_idrol_nurse FOREIGN KEY (idrol) REFERENCES rol(id)
);

CREATE TABLE doctor (
    id SERIAL PRIMARY KEY,
    idrol INT,
    username VARCHAR(100) NOT NULL UNIQUE,
    password TEXT NOT NULL,
    nombres VARCHAR(255) NOT NULL,
    apellidos VARCHAR(255) NOT NULL,
    sexo ty_sexo NOT NULL,
    cel VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    profesion TEXT,
    numerojunta VARCHAR(100),
    fechaingreso DATE,
    estado est_users DEFAULT 'disponible',

    CONSTRAINT fk_idrol_doctor FOREIGN KEY (idrol) REFERENCES rol(id)
);

CREATE TABLE paciente (
    id SERIAL PRIMARY KEY,
    nombres VARCHAR(255) NOT NULL,
    apellidos VARCHAR(255) NOT NULL,
    edad INT NOT NULL,
    sexo ty_sexo NOT NULL,
    cel VARCHAR(50) NOT NULL,
    direccion TEXT
);

CREATE TABLE tipoconsulta (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    estado est_users DEFAULT 'disponible'
);

CREATE TYPE est_cita AS ENUM ('citado', 'enfermeria', 'esperando doctor', 'esperando lentes', 'esperando receta', 'finalizado');
CREATE TABLE cita (
    id SERIAL PRIMARY KEY,
    idpaciente INT,
    idtipoconsulta INT,
    idusuario INT,
    fechacita DATE NOT NULL,
    horacita TIME NOT NULL,
    estado est_cita DEFAULT 'citado',

    CONSTRAINT fk_idpaciente_cita FOREIGN KEY (idpaciente) REFERENCES paciente(id),
    CONSTRAINT fk_idtipoconsulta_cita FOREIGN KEY (idtipoconsulta) REFERENCES tipoconsulta(id),
    CONSTRAINT fk_idusuario_cita FOREIGN KEY (idusuario) REFERENCES usuario(id)
);

CREATE TABLE historialmedico (
    id SERIAL PRIMARY KEY,
    idcita INT,
    idenfermero INT,
    iddoctor INT,
    temperatura REAL,
    peso REAL,
    presion VARCHAR(15),
    glucosa REAL,
    latidos VARCHAR(15),
    padecimiento TEXT,
    diagnostico TEXT,

    CONSTRAINT fk_idcita_hismedico FOREIGN KEY (idcita) REFERENCES cita(id),
    CONSTRAINT fk_idenfermero_hismedico FOREIGN KEY (idenfermero) REFERENCES enfermero(id),
    CONSTRAINT fk_iddoctor_hismedico FOREIGN KEY (iddoctor) REFERENCES doctor(id)
);

CREATE TABLE tipomedida (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL
);

CREATE TABLE medicamento (
    id SERIAL PRIMARY KEY,
    idtipomedida INT,
    nombre VARCHAR NOT NULL,
    descripcion TEXT,
    laboratorio VARCHAR NOT NULL,
    cantidad INT NOT NULL,
    estado est_users DEFAULT 'disponible',

    CONSTRAINT fk_idtipomed_medicamento FOREIGN KEY (idtipomedida) REFERENCES tipomedida(id)
);

CREATE TYPE est_receta AS ENUM ('no entregado', 'entregado');
CREATE TABLE receta (
    id SERIAL PRIMARY KEY,
    idhistorialmedico INT,
    idmedicamento INT,
    dosis INT NOT NULL,
    frecuencia VARCHAR(150) NOT NULL,
    duracion VARCHAR(100) NOT NULL, 
    estado est_receta DEFAULT 'no entregado',

    CONSTRAINT fk_idhistorialmedico_receta FOREIGN KEY (idhistorialmedico) REFERENCES historialmedico(id),
    CONSTRAINT fk_idmedicamento_receta FOREIGN KEY (idmedicamento) REFERENCES medicamento(id)
);

CREATE TABLE proveedor (
    id SERIAL PRIMARY KEY,
    nombres VARCHAR NOT NULL,
    apellidos VARCHAR NOT NULL,
    cel VARCHAR(50) NOT NULL,
    email VARCHAR,
    nombreempresa VARCHAR,
    estado est_users DEFAULT 'disponible'
);

CREATE TYPE accion_inventario AS ENUM ('in', 'out');
CREATE TABLE inventario (
    id SERIAL PRIMARY KEY,
    idmedicamento INT,
    idproveedor INT,
    idreceta INT,
    descripcion TEXT,
    precio TEXT,
    cantidadunidad REAL NOT NULL,
    fechaingreso DATE NOT NULL,
    fechaexpira DATE,
    accion accion_inventario NOT NULL
);

CREATE TABLE loginrecords (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    fechalogin TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    token VARCHAR(255) NOT NULL,
    ipaddress VARCHAR(100), 
    status VARCHAR(50),
    dispositivo VARCHAR(255), 
    navegador VARCHAR(255),
    metodoauth VARCHAR(50)
);
