create database garden;
use garden;
-- tabla tipo_telefono

create table tipo_telefono(
id int primary key auto_increment,
nombre varchar(20) not null
);

-- tabla tipo de pago

create table tipo_pago(
id int primary key auto_increment,
nombre varchar(50) not null
);

-- tabla de tipo_direccion

create table tipo_direccion(
id int primary key auto_increment,
nombre varchar(20) not null,
descripcion text
);

-- tabla gama

create table gama_producto(
id varchar(50) primary key,
descripcion text,
descripcionHtml text,
imagen varchar(256)
);


-- tabal linea_producto

create table linea_producto(
id smallint(6) primary key auto_increment,
nombre varchar(100) not null,
descripcion text
);


-- tabla estado

create table estado(
id int primary key auto_increment,
nombre varchar(25) not null
);

-- tabla tipo

create table cargo(
id int primary key auto_increment,
nombre varchar(50) not null
);



-- Tabla pais
create table pais(
id int primary key auto_increment,
nombre varchar(150) not null
);


-- tabla region

create table region(
id int primary key auto_increment,
nombre varchar(150) not null,
idPais int,
foreign key(idPais)references pais(id)
);

-- Tabla Ciudad

create table ciudad(
id int primary key auto_increment,
nombre varchar(125) not null,
codPostal varchar(11) not null unique,
idRegion int,
foreign key(idRegion) references region(id)
);

-- Tablas proveedores

create table proveedor(
id int primary key auto_increment,
nombre varchar(100) not null,
nit varchar(13 ) unique not null,
correo varchar(200) not null unique,
idCiudad int,
foreign key(idCiudad)references ciudad(id)
);

-- tabla telefono proveedor

create table proveedor_telefono(
id int primary key auto_increment,
telefono varchar(50),
tipoTelefono int,
idProveedor int,
foreign key(tipoTelefono)references tipo_telefono(id),
foreign key(idProveedor)references proveedor(id)
);



-- tabla producto

create table producto(
id varchar(15) primary key,
nombre varchar(70) not null unique,
dimensiones varchar(25),
descripcion varchar(255),
precioVenta double(15,2) not null,
precioProveedor double(15,2) not null,
idProveedor int,
idGama varchar(50),
foreign key(idProveedor)references proveedor(id),
foreign key(idGama)references gama_producto(id)

);

create table bodega(
id int primary key auto_increment,
nombre varchar(100) not null,
idCiudad int,
foreign key(idCiudad)references ciudad(id)
);

create table productoBodega(
idBodega int,
idProducto varchar(15),
cantidad smallint(6) not null,
foreign key(idBodega)references bodega(id),
foreign key(idProducto)references producto(id)
);


create table oficina(
id varchar(10) primary key,
nombre varchar(50)
);

create table oficina_telefono(
id int primary key auto_increment,
telefono varchar(50),
tipoTelefono int,
idOficina varchar(10),
foreign key(tipoTelefono)references tipo_telefono(id),
foreign key(idOficina)references oficina(id)
);



-- tabla empleado

create table empleado(
id int(11) primary key auto_increment,
nombre varchar(50) not null,
apellido1 varchar(100) not null,
apellido2 varchar(100),
extension varchar(10) not null,
email varchar(100) not null,
idOficina varchar(10),
idJefe int(11),
idCargo int,
foreign key(idOficina)references oficina(id),
foreign key(idJefe)references empleado(id),
foreign key(idCargo)references cargo(id)

);

-- tabla empleado_direccion

create table empleado_direccion(
id int primary key auto_increment,
ciudad int,
direccion varchar(100),
tipoDireccion int,
idEmpleado int(11),
idCiudad int,
foreign key(tipoDireccion) references tipo_direccion(id),
foreign key(idEmpleado) references empleado(id),
foreign key(idCiudad)references ciudad(id)
);

-- tabla cliente



create table cliente(
id int(11) primary key auto_increment,
nombre varchar(100) not null,
apellido1 varchar(100) not null,
apellido2 varchar(100),
limiteCredito decimal(15,2),
idEmpleado int(11),
foreign key(idEmpleado)references empleado(id)
);

-- tabla direccion_cliente

create table cliente_direccion(
id int primary key auto_increment,
ciudad int,
direccion varchar(100),
tipoDireccion int,
idCliente int(11),
idCiudad int,
foreign key(idCliente)references cliente(id),
foreign key(tipoDireccion) references tipo_direccion(id),
foreign key(idCiudad)references ciudad(id)
);

-- tabla contacto cliente

create table cliente_contacto(
id int primary key auto_increment,
nombre varchar(100) not null,
apellido1 varchar(100) not null,
apellido2 varchar(100),
correo varchar(100) unique,
idCliente int,
foreign key (idCliente) references cliente(id)
);

-- tabla telefono_cliente

create table cliente_telefono(
id int primary key auto_increment,
telefono varchar(50),
tipoTelefono int,
idCliente int,
foreign key(tipoTelefono)references tipo_telefono(id),
foreign key(idCliente)references cliente(id)
);

-- tabla pedido

create table pedido(
id int(11) primary key auto_increment,
fechaPedido date not null,
fechaEsperada date not null,
fechaEntrega date,
comentario text,
idCliente int(11),
idEstado int,
foreign key(idCliente) references cliente(id),
foreign key(idEstado) references estado(id)
);

create table detalle_pedido(
idPedido int(11),
idProducto varchar(15),
cantidad int(11) not null,
idLineaProducto smallint(6),
primary key(idPedido,idProducto),
foreign key(idPedido)references pedido(id),
foreign key(idProducto)references producto(id),
foreign key(idLineaProducto)references linea_producto(id)
);

-- tabla pago

create table pago(
id int primary key auto_increment,
fecha date not null,
total decimal(15,2),
idTipo int,
idCliente int(11),
foreign key(idTipo)references tipo_pago(id),
foreign key(idCliente) references cliente(id)
);
show tables;

INSERT INTO tipo_telefono (nombre)
VALUES ('Celular'),
       ('Fijo'),
       ('Casa'),
       ('Oficina');

-- Insert data into the tipo_pago table

INSERT INTO tipo_pago (nombre)
VALUES ('Efectivo'),
       ('Tarjeta de Crédito'),
       ('Débito'),
       ('Transferencia Bancaria');
       
INSERT INTO tipo_direccion (nombre, descripcion)
VALUES ('Domicilio', 'Lugar de residencia habitual'),
       ('Oficina', 'Lugar de trabajo'),
       ('Facturación', 'Dirección para enviar facturas'),
       ('Envío', 'Dirección para recibir pedidos');      
       

INSERT INTO gama_producto (id, descripcion, descripcionHtml, imagen) VALUES 
('SEM', 'Semillas', '<p>Productos para el cultivo de semillas.</p>', 'imagenes/productos/semillas.jpg'),
('HER', 'Herramientas', '<p>Herramientas para el cuidado de plantas.</p>', 'imagenes/productos/herramientas.jpg'),
('MAC', 'Macetas', '<p>Macetas de diferentes tamaños y estilos.</p>', 'imagenes/productos/macetas.jpg'),
('DEC', 'Decoración', '<p>Elementos decorativos para jardines.</p>', 'imagenes/productos/decoracion.jpg'),
('FLO', 'Flores', '<p>Flores variadas y vivas.</p>', 'imagenes/productos/flores.jpg'),
('VER', 'Verduras', '<p>Verduras frescas y nutritivas.</p>', 'imagenes/productos/verduras.jpg'),
('ARO', 'Hierbas Aromáticas', '<p>Hierbas aromáticas para aromatizar y embellecer el jardín.</p>', 'imagenes/productos/hierbasAromaticas.jpg'),
('FRU', 'Frutas', '<p>Frutas para decorar y compartir.</p>', 'imagenes/productos/frutas.jpg');
      
-- Insert data into the linea_producto table
select * from producto;
INSERT INTO linea_producto (nombre, descripcion)
VALUES ('Flores', 'Plantas ornamentales para darle color a tu jardín.'),
       ('Verduras', 'Cultiva tus propias verduras frescas y saludables.'),
       ('Aromáticas', 'Hierbas aromáticas para realzar el sabor de tus platos.'),
       ('Frutales', 'Disfruta del sabor de tus propias frutas frescas.');

-- Insert data into the estado table

INSERT INTO estado (nombre)
VALUES ('Pendiente'), ('En Proceso'), ('Enviado'), ('Entregado'), ('Cancelado');

-- Insert data into the cargo table

INSERT INTO cargo (nombre)
VALUES ('Vendedor'), ('Jardinero'), ('Administrativo'), ('Gerente de Tienda'), ('Auxiliar de Bodega');

-- Insert data into the pais table (assuming you only manage data for one country)

INSERT INTO pais (nombre)
VALUES ('Colombia');

-- Insert data into the region table (assuming a few regions within your country)

INSERT INTO region (nombre, idPais)
VALUES 
('Antioquia', 1),
('Atlántico', 1),
('Bolívar', 1),
('Boyacá', 1),
('Caldas', 1);

-- Insert data into the ciudad table (a few example cities within your assumed country and regions)

INSERT INTO ciudad (nombre, codPostal, idRegion)
VALUES 
('Medellín', '050001', 1),
('Barranquilla', '080001', 2),
('Cartagena de Indias', '130001', 3),
('Tunja', '150001', 4),
('Manizales', '170001', 5);

-- Insert data into the proveedor table (example providers)

INSERT INTO proveedor (nombre, nit, correo, idCiudad)
VALUES 
('Jardinería del Valle', '1234567890', 'info@jardineradelvalle.com', 1),
('Agroinversiones Los Andes', '9876543210', 'entas@agroinversioneslosandes.com', 2),
('Soluciones Ambientales', '3456789012', 'contacto@solucionesambientales.com.co', 3),
('Vivero El Paraíso', '8765432190', 'info@viveroelparaiso.com', 4);

INSERT INTO proveedor_telefono (telefono, tipoTelefono, idProveedor)
VALUES ('3125678901', 1, 1),
       ('3135678901', 2, 1),
       ('3145678901', 3, 1),
       ('3205678901', 4, 1),
       ('3126789012', 1, 2),
       ('3136789012', 2, 2),
       ('3146789012', 3, 2),
       ('3206789012', 4, 2),
       ('3127890123', 1, 3),
       ('3137890123', 2, 3),
       ('3147890123', 3, 3),
       ('3207890123', 4, 3),
       ('3128901234', 1, 4),
       ('3138901234', 2, 4),
       ('3148901234', 3, 4),
       ('3208901234', 4, 4);
       
INSERT INTO producto (id, nombre, dimensiones, descripcion, precioVenta, precioProveedor, idProveedor, idGama)
VALUES 
('PRD001', 'Semilla de Tomate', '10x10x10', 'Semilla de tomate para cultivo', 5000.00, 3000.00, 1, 'SEM'),
('PRD002', 'Herramienta de Jardinería', '20x10x5', 'Herramienta para cuidar tu jardín', 20000.00, 15000.00, 2, 'HER'),
('PRD003', 'Maceta para Plantas', '15x15x10', 'Maceta para plantas ornamentales', 8000.00, 5000.00, 3, 'MAC'),
('PRD004', 'Decoración para Jardín', '30x20x10', 'Decoración para darle un toque especial a tu jardín', 30000.00, 20000.00, 4, 'DEC'),
('PRD005', 'Flores de Colores', '10x10x10', 'Flores de colores para darle color a tu jardín', 10000.00, 7000.00, 1, 'SEM'),
('PRD006', 'Verduras Frescas', '20x10x5', 'Verduras frescas para tu cocina', 15000.00, 10000.00, 2, 'VER'),
('PRD007', 'Hierbas Aromáticas', '15x15x10', 'Hierbas aromáticas para realzar el sabor de tus platos', 12000.00, 8000.00, 3, 'ARO'),
('PRD008', 'Frutas Frescas', '30x20x10', 'Frutas frescas para disfrutar', 25000.00, 18000.00, 4, 'FRU');

INSERT INTO bodega (nombre, idCiudad)
VALUES ('Bodega Medellín', 1),
       ('Bodega Bogotá', 2),
       ('Bodega Cali', 3),
       ('Bodega Cartagena', 4),
       ('Bodega Barranquilla', 5);

INSERT INTO productoBodega (idBodega, idProducto, cantidad)
VALUES (1, 'PRD001', 100),
       (1, 'PRD002', 200),
       (1, 'PRD003', 150),
       (1, 'PRD004', 50),
       (2, 'PRD001', 120),
       (2, 'PRD002', 180),
       (2, 'PRD003', 130),
       (2, 'PRD004', 70),
       (3, 'PRD001', 80),
       (3, 'PRD002', 250),
       (3, 'PRD003', 170),
       (3, 'PRD004', 60),
       (4, 'PRD001', 110),
       (4, 'PRD002', 190),
       (4, 'PRD003', 140),
       (4, 'PRD004', 80),
       (5, 'PRD001', 90),
       (5, 'PRD002', 220),
       (5, 'PRD003', 160),
       (5, 'PRD004', 90);
       
       
INSERT INTO oficina (id, nombre)
VALUES ('OF001', 'Oficina Medellín'),
       ('OF002', 'Oficina Bogotá'),
       ('OF003', 'Oficina Cali'),
       ('OF004', 'Oficina Cartagena'),
       ('OF005', 'Oficina Barranquilla');
       
INSERT INTO oficina_telefono (telefono, tipoTelefono, idOficina)
VALUES 
('3125678901', 1, 'OF001'),
('3135678901', 2, 'OF001'),
('3145678901', 3, 'OF001'),
('3205678901', 4, 'OF001'),
('3126789012', 1, 'OF002'),
('3136789012', 2, 'OF002'),
('3146789012', 3, 'OF002'),
('3206789012', 4, 'OF002'),
('3127890123', 1, 'OF003'),
('3137890123', 2, 'OF003'),
('3147890123', 3, 'OF003'),
('3207890123', 4, 'OF003'),
('3128901234', 1, 'OF004'),
('3138901234', 2, 'OF004'),
('3148901234', 3, 'OF004'),
('3208901234', 4, 'OF004'),
('3129012345', 1, 'OF005'),
('3139012345', 2, 'OF005'),
('3149012345', 3, 'OF005'),
('3209012345', 4, 'OF005');       
       
       
-- Insert data into the empleado table
INSERT INTO empleado (nombre, apellido1, apellido2, extension, email, idOficina, idJefe, idCargo)
VALUES 
('Juan', 'Pérez', 'Gómez', '100', 'juan.perez@garden.com', 'OF001', 1, 2),
('María', 'García', 'Ramírez', '200', 'maria.garcia@garden.com', 'OF002', 2, 3),
('Carlos', 'López', 'Hernández', '300', 'carlos.lopez@garden.com', 'OF003', 3, 4),
('Ana', 'Sánchez', 'Díaz', '400', 'ana.sanchez@garden.com', 'OF004', 4, 5),
('Pedro', 'Martínez', 'Rodríguez', '500', 'pedro.martinez@garden.com', 'OF005', 5, 1);

-- Insert data into the empleado_direccion table
INSERT INTO empleado_direccion (idEmpleado, idCiudad, direccion, tipoDireccion)
VALUES 
(1, 1, 'Calle 10 # 20-30', 1),
(2, 2, 'Carrera 15 # 30-40', 1),
(3, 3, 'Calle 20 # 40-50', 1),
(4, 4, 'Carrera 25 # 50-60', 1),
(5, 5, 'Calle 30 # 60-70', 1);       

-- Insert data into the cliente table
INSERT INTO cliente (id, nombre, apellido1, apellido2, limiteCredito, idEmpleado)
VALUES 
(1, 'Juan', 'Pérez', 'Gómez', 100000.00, 1),
(2, 'María', 'García', 'Ramírez', 50000.00, 2),
(3, 'Carlos', 'López', 'Hernández', 200000.00, 3),
(4, 'Ana', 'Sánchez', 'Díaz', 150000.00, 4),
(5, 'Pedro', 'Martínez', 'Rodríguez', 250000.00, 5);

-- Insert data into the cliente_direccion table
INSERT INTO cliente_direccion (id, ciudad, direccion, tipoDireccion, idCliente, idCiudad)
VALUES 
(1, 1, 'Calle 10 # 20-30', 1, 1, 1),
(2, 2, 'Carrera 15 # 30-40', 1, 2, 2),
(3, 3, 'Calle 20 # 40-50', 1, 3, 3),
(4, 4, 'Carrera 25 # 50-60', 1, 4, 4),
(5, 5, 'Calle 30 # 60-70', 1, 5, 5);

-- Insert data into the cliente_contacto table
INSERT INTO cliente_contacto (nombre, apellido1, apellido2, correo, idCliente)
VALUES 
('Juan', 'Pérez', 'Gómez', 'juan.perez@cliente.com', 1),
('María', 'García', 'Ramírez', 'maria.garcia@cliente.com', 2),
('Carlos', 'López', 'Hernández', 'carlos.lopez@cliente.com', 3),
('Ana', 'Sánchez', 'Díaz', 'ana.sanchez@cliente.com', 4),
('Pedro', 'Martínez', 'Rodríguez', 'pedro.martinez@cliente.com', 5);

-- Insert data into the cliente_telefono table
INSERT INTO cliente_telefono (telefono, tipoTelefono, idCliente)
VALUES 
('1234567890', 1, 1),
('9876543210', 1, 2),
('4567890123', 1, 3),
('7890123456', 1, 4),
('2345678901', 1, 5);

-- Insert data into the pedido table
INSERT INTO pedido (id, fechaPedido, fechaEsperada, fechaEntrega, comentario, idCliente, idEstado)
VALUES 
(1, '2024-05-29', '2024-06-03', NULL, 'Pedido de prueba', 1, 1),
(2, '2024-05-30', '2024-06-05', NULL, 'Pedido de prueba 2', 2, 1),
(3, '2024-05-31', '2024-06-07', NULL, 'Pedido de prueba 3', 3, 1),
(4, '2024-06-01', '2024-06-10', NULL, 'Pedido de prueba 4', 4, 1),
(5, '2024-06-02', '2024-06-12', NULL, 'Pedido de prueba 5', 5, 1);

INSERT INTO detalle_pedido(idPedido, idProducto, cantidad, idLineaProducto)
VALUES 
(1, 'PRD001', 2, 1),
(1, 'PRD002', 1, 2),
(2, 'PRD003', 3, 3),
(2, 'PRD004', 2, 4),
(3, 'PRD005', 1, 1),
(3, 'PRD006', 2, 2),
(4, 'PRD007', 1, 3),
(4, 'PRD008', 3, 4),
(5, 'PRD001', 1, 1),
(5, 'PRD002', 2, 2);


INSERT INTO pago(fecha, total, idTipo, idCliente)
VALUES 
('2024-05-29', 100.00, 1, 1),
('2024-05-30', 200.00, 2, 2),
('2024-05-31', 300.00, 3, 3),
('2024-06-01', 400.00, 1, 4),
('2024-06-02', 500.00, 2, 5);
select * from pago join cliente on cliente.id = pago.id;
       show tables;
drop database garden;
select * from linea_producto;


