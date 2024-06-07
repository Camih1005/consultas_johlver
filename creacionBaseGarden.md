create database TallerCamilo;
use TallerCamilo;


create table departamento(
id int primary key,
nombre varchar(50) not null
);

create table ciudad(
id int primary key,
nombre varchar(50),
idDepartamento int,
foreign key(idDepartamento)references departamento(id)
);

CREATE TABLE tipo_direccion(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    descripcion TEXT
);


create table tipo_telefono(
id int primary key auto_increment,
tipo varchar(20) not null
);

create table marca_vehiculo(
id int primary key auto_increment,
nombre varchar(25) not null
);

create table taller(
id int primary key auto_increment,
direccion varchar(100) not null,
idCiudad int,
foreign key(idCiudad)references ciudad(id)
);

create table cliente(
id int primary key,
nombre varchar(50) not null,
apellido1 varchar(50) not null,
apellido2 varchar(50),
email varchar(50) not null
);

CREATE TABLE cliente_direccion(
id INT PRIMARY KEY ,
direccion VARCHAR(100),
tipoDireccion INT,
idCliente INT,
idCiudad INT,
FOREIGN KEY(idCliente) REFERENCES cliente(id),
FOREIGN KEY(tipoDireccion) REFERENCES tipo_direccion(id),
FOREIGN KEY(idCiudad) REFERENCES ciudad(id)
);

create table telefono_cliente(
id int primary key auto_increment,
telefono varchar(13) not null,
idCliente int,
idTipo int,
foreign key(idCliente)references cliente(id),
foreign key(idTipo) references tipo_telefono(id)
);

create table vehiculo(
id int primary key auto_increment,
placa varchar(6) unique not null,
modelo varchar(50) not null,
kilometraje int,
año int not null,
idCliente int,
idMarca int,
foreign key(idCliente)references cliente(id),
foreign key(idMarca)references marca_vehiculo(id)
);

create table servicio(
id int primary key,
nombre varchar(60) not null,
descripcion text not null,
precio double(15,2) not null
);

create table reparacion(
id int primary key auto_increment,
fechaIngreso date not null,
fechaEsperada date not null,
fechaEntrega date not null,
descripcion text,
Total double(15,2) not null 
);

create table reparacion_servicio(
id int primary key auto_increment,
idReparacion int,
idServicio int,
foreign key(idReparacion)references reparacion(id),
foreign key (idservicio) references servicio(id)
);

create table cargo(
id int primary key auto_increment,
nombre varchar(50) not null
);

create table empleado(
id int primary key,
nombre varchar(50) not null,
apellido1 varchar(50) not null,
apellido2 varchar(50),
idTaller int,
idCargo int,
foreign key(idTaller)references taller(id),
foreign key(idCargo)references cargo(id)
);

CREATE TABLE empleado_direccion(
id INT PRIMARY KEY ,
ciudad INT,
direccion VARCHAR(100),
tipoDireccion INT,
idEmpleado INT,
idCiudad INT,
FOREIGN KEY(tipoDireccion) REFERENCES tipo_direccion(id),
FOREIGN KEY(idEmpleado) REFERENCES empleado(id),
FOREIGN KEY(idCiudad) REFERENCES ciudad(id)
);


create table telefono_empleado(
id int primary key auto_increment,
telefono varchar(13) not null,
idEmpleado int,
idTipo int,
foreign key(idEmpleado)references empleado(id),
foreign key(idTipo) references tipo_telefono(id)
);

create table reparacion_empleado(
idEmpleado int,
idReparacion int,
primary key(idEmpleado,idReparacion),
foreign key(idEmpleado) references empleado(id),
foreign key(idReparacion)references reparacion(id)
);

create table cita(
id int primary key auto_increment,
fecha datetime not null,
idCliente int,
idTaller int,
idServicio int,
foreign key(idCliente) references cliente(id),
foreign key(idTaller) references taller(id),
foreign key(idServicio) references servicio(id)
);

create table facturacion(
id int primary key auto_increment,
fecha date not null,
total double(15,2) not null default 0,
idCliente int,
foreign key(idCliente) references cliente(id)
);

create table factura_detalle(
idFacturacion int,
idReparacion int,
cantidad int not null,
precio double(15,2) not null,
primary key(idFacturacion,idReparacion),
foreign key(idReparacion)references reparacion(id),
foreign key(idFacturacion)references facturacion(id)
);

create table proveedor(
id int primary key auto_increment,
nombre varchar(100) not null,
nit varchar(15) not null unique,
email varchar(60) unique
);
create table contacto_proveedor(
id int primary key auto_increment,
nombre varchar(60) not null,
apellido1 varchar(60) not null,
apellido2 varchar(60),
email varchar(100) not null unique,
idProveedor int,
foreign key(idProveedor)references proveedor(id)
);

create table telefono_contacto(
id int primary key auto_increment,
telefono varchar(13) not null,
idContacto int,
idTipo int,
foreign key(idContacto)references contacto_proveedor(id),
foreign key(idTipo) references tipo_telefono(id)
);

create table orden_compra(
id int primary key auto_increment,
fecha date not null,
idProveedor int,
idEmpleado int,
total int not null,
foreign key(idProveedor)references proveedor(id),
foreign key(idEmpleado) references empleado(id)
);

create table marca_pieza(
id int primary key auto_increment,
nombre varchar(100) not null
);

create table pieza(
id int primary key auto_increment,
nombre varchar(100) not null,
descripcion text,
precio double(15,2) not null,
idMarca int,
foreign key(idMarca)references marca_pieza(id)
);

create table reparacion_pieza(
idReparacion int,
idPieza int,
cantidad int not null,
primary key(idReparacion,idPieza),
foreign key(idPieza)references pieza(id),
foreign key(idReparacion)references reparacion(id)
);

create table proveedor_pieza(
idPieza int,
idProveedor int,
foreign key(idPieza) references pieza(id),
foreign key(idProveedor)references proveedor(id)
);

create table orden_detalle(
idOrdenCompra int,
idPieza int,
cantidad int not null,
precio double(15,2) not null,
primary key(idOrdenCompra,idPieza),
foreign key(idOrdenCompra)references orden_compra(id),
foreign key(idPieza)references pieza(id)
);

create table inventario_taller(
id int primary key auto_increment,
idTaller int,
idPieza int,
cantidad int not null,
foreign key (idPieza) references pieza(id),
foreign key(idTaller)references taller(id)
);

create table ubicacion_pieza_taller(
id varchar(10) primary key,
nombre varchar(50) not null,
descripcion tinytext,
idUbicacion int,
foreign key (idUbicacion) references inventario_taller(id)
);


-- Inserciones para la tabla departamento
INSERT INTO departamento (id, nombre) VALUES
(1, 'Antioquia'),
(2, 'Atlántico'),
(3, 'Bogotá D.C.'),
(4, 'Bolívar');

-- Inserciones para la tabla ciudad
INSERT INTO ciudad (id, nombre, idDepartamento) VALUES
(1, 'Medellín', 1),
(2, 'Barranquilla', 2),
(3, 'Bogotá', 3),
(4, 'Cartagena', 4);

-- Inserciones para la tabla tipo_direccion
INSERT INTO tipo_direccion (nombre, descripcion) VALUES
('Casa', 'Dirección residencial'),
('Trabajo', 'Dirección del lugar de trabajo'),
('Otros', 'Otro tipo de dirección');

-- Inserciones para la tabla tipo_telefono
INSERT INTO tipo_telefono (tipo) VALUES
('Casa'),
('Trabajo'),
('Móvil'),
('Otro');

-- Inserciones para la tabla marca_vehiculo
INSERT INTO marca_vehiculo (nombre) VALUES
('Chevrolet'),
('Ford'),
('Toyota'),
('Nissan');

-- Inserciones para la tabla taller
INSERT INTO taller (direccion, idCiudad) VALUES
('Calle 10 #20-30', 1),
('Av. Circunvalar #50-60', 3),
('Cra. 15 #30-40', 4);

-- Inserciones para la tabla cliente
INSERT INTO cliente (id, nombre, apellido1, apellido2, email) VALUES
(1, 'Juan', 'Perez', 'Gomez', 'juan@example.com'),
(2, 'Maria', 'Rodriguez', 'Lopez', 'maria@example.com');

-- Inserciones para la tabla cliente_direccion
INSERT INTO cliente_direccion (id, direccion, tipoDireccion, idCliente, idCiudad) VALUES
(1, 'Calle 20 #30-40', 1, 1, 1),
(2, 'Cra. 50 #60-70', 2, 1, 3),
(3, 'Av. Principal #10-20', 1, 2, 4);

-- Inserciones para la tabla telefono_cliente
INSERT INTO telefono_cliente (telefono, idCliente, idTipo) VALUES
('123456789', 1, 3),
('987654321', 1, 4),
('5555555', 2, 3);

-- Inserciones para la tabla vehiculo
INSERT INTO vehiculo (placa, modelo, kilometraje, año, idCliente, idMarca) VALUES
('ABC123', 'Spark', 10000, 2022, 1, 1),
('XYZ789', 'Corolla', 5000, 2023, 2, 3);

-- Inserciones para la tabla servicio
INSERT INTO servicio (id, nombre, descripcion, precio) VALUES
(1, 'Cambio de aceite', 'Cambio de aceite y filtro', 50000),
(2, 'Revisión de frenos', 'Revisión y ajuste de frenos', 60000);

-- Inserciones para la tabla reparacion
INSERT INTO reparacion (id, fechaIngreso, fechaEsperada, fechaEntrega, descripcion, Total) VALUES
(1, '2024-06-01', '2024-06-02', '2024-06-03', 'Reparación de motor', 80000),
(2, '2024-06-02', '2024-06-03', '2024-06-04', 'Reparación de frenos', 70000);

-- Inserciones para la tabla reparacion_servicio
INSERT INTO reparacion_servicio (idReparacion, idServicio) VALUES
(1, 1),
(1, 2),
(2, 2);

-- Inserciones para la tabla cargo
INSERT INTO cargo (nombre) VALUES
('Mecánico'),
('Recepcionista'),
('Gerente');

-- Inserciones para la tabla empleado
INSERT INTO empleado (id, nombre, apellido1, apellido2, idTaller, idCargo) VALUES
(1, 'Pedro', 'Martinez', 'López', 1, 1),
(2, 'Ana', 'González', 'Perez', 1, 2),
(3, 'Carlos', 'García', 'Ruiz', 2, 1);

-- Inserciones para la tabla empleado_direccion
INSERT INTO empleado_direccion (id, ciudad, direccion, tipoDireccion, idEmpleado, idCiudad) VALUES
(1, 1, 'Calle 40 #50-60', 1, 1, 1),
(2, 3, 'Av. Principal #100-110', 2, 2, 3),
(3, 3, 'Cra. 70 #80-90', 1, 3, 3);

-- Inserciones para la tabla telefono_empleado
INSERT INTO telefono_empleado (telefono, idEmpleado, idTipo) VALUES
('7777777', 1, 3),
('8888888', 2, 4),
('9999999', 3, 3);

-- Inserciones para la tabla reparacion_empleado
INSERT INTO reparacion_empleado (idEmpleado, idReparacion) VALUES
(1, 1),
(2, 1),
(3, 2);

-- Inserciones para la tabla cita
INSERT INTO cita (fecha, idCliente, idTaller, idServicio) VALUES
('2024-06-10 08:00:00', 1, 1, 1),
('2024-06-11 09:00:00', 2, 1, 2);

-- Inserciones para la tabla facturacion
INSERT INTO facturacion (fecha, total, idCliente) VALUES
('2024-06-03', 80000, 1),
('2024-06-04', 70000, 2);

-- Inserciones para la tabla factura_detalle
INSERT INTO factura_detalle (idFacturacion, idReparacion, cantidad, precio) VALUES
(1, 1, 1, 80000),
(2, 2, 1, 70000);

-- Inserciones para la tabla proveedor
INSERT INTO proveedor (nombre, nit, email) VALUES
('Autopartes S.A.', '123456789-1', 'info@autopartes.com'),
('Repuestos XYZ', '987654321-2', 'info@repuestosxyz.com');

-- Inserciones para la tabla contacto_proveedor
INSERT INTO contacto_proveedor (nombre, apellido1, email, idProveedor) VALUES
('José', 'Pérez', 'jose@example.com', 1),
('María', 'González', 'maria@example.com', 2);

-- Inserciones para la tabla telefono_contacto
INSERT INTO telefono_contacto (telefono, idContacto, idTipo) VALUES
('1111111', 1, 3),
('2222222', 1, 4),
('3333333', 2, 3);

-- Inserciones para la tabla orden_compra
INSERT INTO orden_compra (fecha, idProveedor, idEmpleado, total) VALUES
('2024-06-05', 1, 1, 150000),
('2024-06-06', 2, 3, 120000);

-- Inserciones para la tabla marca_pieza
INSERT INTO marca_pieza (nombre) VALUES
('Bosch'),
('Motorcraft'),
('Denso');

-- Inserciones para la tabla pieza
INSERT INTO pieza (nombre, descripcion, precio, idMarca) VALUES
('Filtro de aceite', 'Filtro de aceite para motor', 50000, 1),
('Pastillas de freno', 'Pastillas de freno delanteras', 60000, 2),
('Bujía', 'Bujía de encendido', 20000, 3);

-- Inserciones para la tabla reparacion_pieza
INSERT INTO reparacion_pieza (idReparacion, idPieza, cantidad) VALUES
(1, 1, 1),
(1, 3, 4),
(2, 2, 2),
(2, 3, 2);

-- Inserciones para la tabla proveedor_pieza
INSERT INTO proveedor_pieza (idPieza, idProveedor) VALUES
(1, 1),
(2, 2),
(3, 1);

-- Inserciones para la tabla orden_detalle
INSERT INTO orden_detalle (idOrdenCompra, idPieza, cantidad, precio) VALUES
(1, 1, 2, 100000),
(1, 3, 4, 80000),
(2, 2, 3, 150000);

-- Inserciones para la tabla inventario_taller
INSERT INTO inventario_taller (idTaller, idPieza, cantidad) VALUES
(1, 1, 10),
(1, 2, 5),
(2, 3, 8);

-- Inserciones para la tabla ubicacion_pieza_taller
INSERT INTO ubicacion_pieza_taller (id, nombre, descripcion, idUbicacion) VALUES
('Z1', 'Estantería 1', 'Ubicación de filtros de aceite', 1),
('Z2', 'Estante 2', 'Ubicación de pastillas de freno', 2),
('Z3', 'Rack 3', 'Ubicación de bujías', 3);


select * from inventario_taller;
show tables;
