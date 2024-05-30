CREATE DATABASE garden1;
USE garden1;

-- tabla tipo_telefono
CREATE TABLE tipo_telefono(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL
);

-- tabla tipo de pago
CREATE TABLE tipo_pago(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

-- tabla de tipo_direccion
CREATE TABLE tipo_direccion(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    descripcion TEXT
);

-- tabla gama_producto
CREATE TABLE gama_producto(
    id VARCHAR(50) PRIMARY KEY,
    descripcion TEXT,
    descripcionHtml TEXT,
    imagen VARCHAR(256)
);

-- tabla linea_producto
CREATE TABLE linea_producto(
    id SMALLINT(6) PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT
);

-- tabla estado
CREATE TABLE estado(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL
);

-- tabla cargo
CREATE TABLE cargo(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla pais
CREATE TABLE pais(
    id INT PRIMARY KEY ,
    nombre VARCHAR(150) NOT NULL
);

-- tabla region
CREATE TABLE region(
    id INT PRIMARY KEY ,
    nombre VARCHAR(150) NOT NULL,
    idPais INT,
    FOREIGN KEY(idPais) REFERENCES pais(id)
);

-- Tabla Ciudad
CREATE TABLE ciudad(
    id INT PRIMARY KEY ,
    nombre VARCHAR(125) NOT NULL,
    codPostal VARCHAR(11) NOT NULL UNIQUE,
    idRegion INT,
    FOREIGN KEY(idRegion) REFERENCES region(id)
);

-- Tablas proveedores
CREATE TABLE proveedor(
    id INT PRIMARY KEY ,
    nombre VARCHAR(100) NOT NULL,
    nit VARCHAR(13 ) UNIQUE NOT NULL,
    correo VARCHAR(200) NOT NULL UNIQUE,
    idCiudad INT,
    FOREIGN KEY(idCiudad) REFERENCES ciudad(id)
);

-- tabla telefono proveedor
CREATE TABLE proveedor_telefono(
    id INT PRIMARY KEY ,
    telefono VARCHAR(50),
    tipoTelefono INT,
    idProveedor INT,
    FOREIGN KEY(tipoTelefono) REFERENCES tipo_telefono(id),
    FOREIGN KEY(idProveedor) REFERENCES proveedor(id)
);

-- tabla producto
CREATE TABLE producto(
    id VARCHAR(15) PRIMARY KEY,
    nombre VARCHAR(70) NOT NULL UNIQUE,
    dimensiones VARCHAR(25),
    descripcion VARCHAR(255),
    precioVenta DOUBLE(15,2) NOT NULL,
    precioProveedor DOUBLE(15,2) NOT NULL,
    idProveedor INT,
    idGama VARCHAR(50),
    FOREIGN KEY(idProveedor) REFERENCES proveedor(id),
    FOREIGN KEY(idGama) REFERENCES gama_producto(id)
);

-- tabla bodega
CREATE TABLE bodega(
    id INT PRIMARY KEY ,
    nombre VARCHAR(100) NOT NULL,
    idCiudad INT,
    FOREIGN KEY(idCiudad) REFERENCES ciudad(id)
);

-- tabla productoBodega
CREATE TABLE productoBodega(
    idBodega INT,
    idProducto VARCHAR(15),
    cantidad SMALLINT(6) NOT NULL,
    FOREIGN KEY(idBodega) REFERENCES bodega(id),
    FOREIGN KEY(idProducto) REFERENCES producto(id)
);

-- tabla oficina
CREATE TABLE oficina(
    id VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(50)
);

-- tabla oficina_telefono
CREATE TABLE oficina_telefono(
    id INT PRIMARY KEY ,
    telefono VARCHAR(50),
    tipoTelefono INT,
    idOficina VARCHAR(10),
    FOREIGN KEY(tipoTelefono) REFERENCES tipo_telefono(id),
    FOREIGN KEY(idOficina) REFERENCES oficina(id)
);

-- tabla empleado
CREATE TABLE empleado(
    id INT(11) PRIMARY KEY ,
    nombre VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(100) NOT NULL,
    apellido2 VARCHAR(100),
    extension VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    idOficina VARCHAR(10),
    idJefe INT(11),
    idCargo INT,
    FOREIGN KEY(idOficina) REFERENCES oficina(id),
    FOREIGN KEY(idJefe) REFERENCES empleado(id),
    FOREIGN KEY(idCargo) REFERENCES cargo(id)
);

-- tabla empleado_direccion
CREATE TABLE empleado_direccion(
    id INT PRIMARY KEY ,
    ciudad INT,
    direccion VARCHAR(100),
    tipoDireccion INT,
    idEmpleado INT(11),
    idCiudad INT,
    FOREIGN KEY(tipoDireccion) REFERENCES tipo_direccion(id),
    FOREIGN KEY(idEmpleado) REFERENCES empleado(id),
    FOREIGN KEY(idCiudad) REFERENCES ciudad(id)
);

-- tabla cliente
CREATE TABLE cliente(
    id INT(11) PRIMARY KEY ,
    nombre VARCHAR(100) NOT NULL,
    apellido1 VARCHAR(100) NOT NULL,
    apellido2 VARCHAR(100),
    limiteCredito DECIMAL(15,2),
    idEmpleado INT(11),
    FOREIGN KEY(idEmpleado) REFERENCES empleado(id)
);

-- tabla direccion_cliente
CREATE TABLE cliente_direccion(
    id INT PRIMARY KEY ,
    ciudad INT,
    direccion VARCHAR(100),
    tipoDireccion INT,
    idCliente INT(11),
    idCiudad INT,
    FOREIGN KEY(idCliente) REFERENCES cliente(id),
    FOREIGN KEY(tipoDireccion) REFERENCES tipo_direccion(id),
    FOREIGN KEY(idCiudad) REFERENCES ciudad(id)
);

-- tabla contacto cliente
CREATE TABLE cliente_contacto(
    id INT PRIMARY KEY ,
    nombre VARCHAR(100) NOT NULL,
    apellido1 VARCHAR(100) NOT NULL,
    apellido2 VARCHAR(100),
    correo VARCHAR(100) UNIQUE,
    idCliente INT,
    FOREIGN KEY (idCliente) REFERENCES cliente(id)
);

-- tabla telefono_cliente
CREATE TABLE cliente_telefono(
    id INT PRIMARY KEY ,
    telefono VARCHAR(50),
    tipoTelefono INT,
    idCliente INT,
    FOREIGN KEY(tipoTelefono) REFERENCES tipo_telefono(id),
    FOREIGN KEY(idCliente) REFERENCES cliente(id)
);

-- tabla pedido
CREATE TABLE pedido(
    id INT(11) PRIMARY KEY ,
    fechaPedido DATE NOT NULL,
    fechaEsperada DATE NOT NULL,
    fechaEntrega DATE,
    comentario TEXT,
    idCliente INT(11),
    idEstado INT,
    FOREIGN KEY(idCliente) REFERENCES cliente(id),
    FOREIGN KEY(idEstado) REFERENCES estado(id)
);

-- tabla detalle_pedido
CREATE TABLE detalle_pedido(
    idPedido INT(11),
    idProducto VARCHAR(15),
    cantidad INT(11) NOT NULL,
    idLineaProducto SMALLINT(6),
    PRIMARY KEY(idPedido, idProducto),
    FOREIGN KEY(idPedido) REFERENCES pedido(id),
    FOREIGN KEY(idProducto) REFERENCES producto(id),
    FOREIGN KEY(idLineaProducto) REFERENCES linea_producto(id)
);

-- tabla pago
CREATE TABLE pago(
    id INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    total DECIMAL(15,2),
    idTipo INT,
    idCliente INT(11),
    FOREIGN KEY(idTipo) REFERENCES tipo_pago(id),
    FOREIGN KEY(idCliente) REFERENCES cliente(id)
);

-- tabla oficina_direccion
CREATE TABLE oficina_direccion(
    id INT PRIMARY KEY ,
    direccion VARCHAR(100),
    tipoDireccion INT,
    idOficina VARCHAR(10),
    idCiudad INT,
    FOREIGN KEY(idOficina) REFERENCES oficina(id),
    FOREIGN KEY(tipoDireccion) REFERENCES tipo_direccion(id),
    FOREIGN KEY(idCiudad) REFERENCES ciudad(id)
);

-- Insert data into tipo_telefono table
INSERT INTO tipo_telefono (nombre) VALUES ('Celular'), ('Fijo'), ('Casa'), ('Oficina');

-- Insert data into tipo_pago table
INSERT INTO tipo_pago (nombre) VALUES ('Efectivo'), ('Tarjeta de Crédito'), ('Débito'), ('Transferencia Bancaria');

-- Insert data into tipo_direccion table
INSERT INTO tipo_direccion (nombre, descripcion) VALUES 
('Domicilio', 'Lugar de residencia habitual'),
('Oficina', 'Lugar de trabajo'),
('Facturación', 'Dirección para enviar facturas'),
('Envío', 'Dirección para recibir pedidos');

-- Insert data into gama_producto table
INSERT INTO gama_producto (id, descripcion, descripcionHtml, imagen) VALUES 
('SEM', 'Semillas', '<p>Productos para el cultivo de semillas.</p>', 'imagenes/productos/semillas.jpg'),
('HER', 'Herramientas', '<p>Herramientas para el cuidado de plantas.</p>', 'imagenes/productos/herramientas.jpg'),
('MAC', 'Macetas', '<p>Macetas de diferentes tamaños y estilos.</p>', 'imagenes/productos/macetas.jpg'),
('DEC', 'Decoración', '<p>Elementos decorativos para jardines.</p>', 'imagenes/productos/decoracion.jpg'),
('FLO', 'Flores', '<p>Flores variadas y vivas.</p>', 'imagenes/productos/flores.jpg'),
('VER', 'Verduras', '<p>Verduras frescas y nutritivas.</p>', 'imagenes/productos/verduras.jpg'),
('ARO', 'Hierbas Aromáticas', '<p>Hierbas aromáticas para aromatizar y embellecer el jardín.</p>', 'imagenes/productos/hierbasAromaticas.jpg'),
('FRU', 'Frutas', '<p>Frutas para decorar y compartir.</p>', 'imagenes/productos/frutas.jpg');

-- Insert data into linea_producto table
INSERT INTO linea_producto (nombre, descripcion) VALUES 
('Flores', 'Plantas ornamentales para darle color a tu jardín.'),
('Verduras', 'Cultiva tus propias verduras frescas y saludables.'),
('Aromáticas', 'Hierbas aromáticas para realzar el sabor de tus platos.'),
('Frutales', 'Disfruta del sabor de tus propias frutas frescas.');

-- Insert data into estado table
INSERT INTO estado (nombre) VALUES ('Pendiente'), ('Procesado'), ('Enviado'), ('Entregado'), ('Cancelado');

-- Insert data into cargo table
INSERT INTO cargo (nombre) VALUES ('Gerente'), ('Vendedor'), ('Contador'), ('Jardinero');

-- Insert data into pais table
INSERT INTO pais (id,nombre) VALUES 
(1,'Argentina'), (2,'Brasil'), (3,'Colombia'), (4,'España'), (5,'Francia'), (6,'Italia'), (7,'Alemania');

-- Insert data into region table
INSERT INTO region (id,nombre, idPais) VALUES 
-- Regiones de Argentina
(1,'Buenos Aires', 1), (2,'Córdoba', 1), (3,'Santa Fe', 1),
-- Regiones de Brasil
(4,'São Paulo', 2), (5,'Río de Janeiro', 2), (6,'Bahía', 2),
-- Regiones de Colombia
(7,'Antioquia', 3), (8,'Bogotá', 3), (9,'Valle del Cauca', 3),
-- Regiones de España
(10,'Cataluña', 4), (11,'Madrid', 4), (12,'Andalucía', 4),
-- Regiones de Francia
(13,'Île-de-France', 5), (14,'Provenza-Alpes-Costa Azul', 5),
-- Regiones de Italia
(15,'Lombardía', 6), (16,'Toscana', 6),
-- Regiones de Alemania
(17,'Baviera', 7), (18,'Baden-Wurtemberg', 7);

-- Insert data into ciudad table
INSERT INTO ciudad (id,nombre, codPostal, idRegion) VALUES 
-- Ciudades de Argentina
(1,'Buenos Aires', '1000', 1), (2,'Córdoba', '5000', 2), (3,'Rosario', '2000', 3),
-- Ciudades de Brasil
(4,'São Paulo', '01000-000', 4), (5,'Río de Janeiro', '20000-000', 5), (6,'Salvador', '40000-000', 6),
-- Ciudades de Colombia
(7,'Medellín', '050001', 7), (8,'Bogotá', '110111', 8), (9,'Cali', '760001', 9),
-- Ciudades de España
(10,'Barcelona', '08001', 10), (11,'Madrid', '28001', 11), (12,'Sevilla', '41001', 12),
-- Ciudades de Francia
(13,'París', '75001', 13), (14,'Marsella', '13001', 14),
-- Ciudades de Italia
(15,'Milán', '20100', 15), (16,'Florencia', '50100', 16),
-- Ciudades de Alemania
(17,'Múnich', '80331', 17), (18,'Stuttgart', '70173', 18);

-- Insert data into proveedor table
INSERT INTO proveedor (id,nombre, nit, correo, idCiudad) VALUES 
(1,'Viveros Buenos Aires', '1112223334', 'contacto@viverosbuenosaires.com', 1),
(2,'Flores Córdoba', '2223334445', 'ventas@florescordoba.com', 2),
(3,'Jardines Rosario', '3334445556', 'info@jardinesrosario.com', 3),
(4,'Plantas São Paulo', '4445556667', 'info@plantassaopaulo.com', 4),
(5,'Verde Río', '5556667778', 'contacto@verderio.com', 5),
(6,'Florería Salvador', '6667778889', 'ventas@floreriasalvador.com', 6),
(7,'Jardinería Medellín', '7778889990', 'info@jardineriamedellin.com', 7),
(8,'Plantas Bogotá', '8889990001', 'info@plantasbogota.com', 8),
(9,'Flores Cali', '9990001112', 'ventas@florescali.com', 9),
(10,'Viveros Barcelona', '1122334455', 'info@viverosbarcelona.com', 10),
(11,'Florería Madrid', '2233445566', 'ventas@floreriamadrid.com', 11),
(12,'Jardines Sevilla', '3344556677', 'contacto@jardinessevilla.com', 12),
(13,'Plantas París', '4455667788', 'info@plantasparis.com', 13),
(14,'Verde Marsella', '5566778899', 'ventas@verdemarsella.com', 14),
(15,'Fiori Milano', '6677889900', 'info@fiorimilano.com', 15),
(16,'Giardini Firenze', '7788990011', 'contacto@giardinifirenze.com', 16),
(17,'Grün München', '8899001122', 'info@grunmuenchen.com', 17),
(18,'Garten Stuttgart', '9900112233', 'ventas@gartenstuttgart.com', 18);

INSERT INTO proveedor_telefono (id, telefono, tipoTelefono, idProveedor) VALUES 
(1, '1111111111', 1, 1), 
(2, '2222222222', 2, 1),
(3, '3333333333', 1, 2), 
(4, '4444444444', 2, 2),
(5, '5555555555', 1, 3), 
(6, '6666666666', 2, 3),
(7, '7777777777', 1, 4), 
(8, '8888888888', 2, 4),
(9, '9999999999', 1, 5), 
(10, '0000000000', 2, 5),
(11, '1111222233', 1, 6), 
(12, '2222333344', 2, 6),
(13, '3333444455', 1, 7), 
(14, '4444555566', 2, 7),
(15, '5555666677', 1, 8), 
(16, '6666777788', 2, 8),
(17, '7777888899', 1, 9), 
(18, '8888999900', 2, 9),
(19, '1231231234', 1, 10), 
(20, '2342342345', 2, 10),
(21, '3453453456', 1, 11), 
(22, '4564564567', 2, 11),
(23, '5675675678', 1, 12), 
(24, '6786786789', 2, 12),
(25, '7897897890', 1, 13), 
(26, '8908908901', 2, 13),
(27, '9019019012', 1, 14), 
(28, '1234567890', 2, 14),
(29, '2345678901', 1, 15), 
(30, '3456789012', 2, 15),
(31, '4567890123', 1, 16), 
(32, '5678901234', 2, 16),
(33, '6789012345', 1, 17), 
(34, '7890123456', 2, 17),
(35, '8901234567', 1, 18), 
(36, '9012345678', 2, 18);


-- Insert data into producto table
INSERT INTO producto (id, nombre, dimensiones, descripcion, precioVenta, precioProveedor, idProveedor, idGama) VALUES 
('PRD001', 'Semilla Girasol', '10x10x10', 'Semillas de girasol para plantar en tu jardín', 5000.00, 3000.00, 1, 'SEM'),
('PRD002', 'Maceta de Barro', '15x15x15', 'Maceta de barro artesanal para tus plantas', 10000.00, 7000.00, 2, 'MAC'),
('PRD003', 'Tijeras de Poda', '20x5x5', 'Tijeras de poda profesional para jardinería', 20000.00, 15000.00, 3, 'HER'),
('PRD004', 'Abono Orgánico', '50x30x30', 'Abono orgánico para mejorar la salud de tus plantas', 15000.00, 10000.00, 4, 'HER'),
('PRD005', 'Planta São Paulo', '30x20x10', 'Planta típica de São Paulo', 30000.00, 20000.00, 4, 'SEM'),
('PRD006', 'Maceta Río', '20x15x15', 'Maceta típica de Río de Janeiro', 15000.00, 10000.00, 5, 'MAC'),
('PRD007', 'Flor Salvador', '25x10x5', 'Flor típica de Salvador', 18000.00, 12000.00, 6, 'FLO'),
('PRD008', 'Jardín Medellín', '20x20x15', 'Jardín típico de Medellín', 25000.00, 18000.00, 7, 'HER'),
('PRD009', 'Planta Bogotá', '15x15x10', 'Planta típica de Bogotá', 12000.00, 8000.00, 8, 'SEM'),
('PRD010', 'Flor Cali', '30x10x5', 'Flor típica de Cali', 22000.00, 17000.00, 9, 'FLO'),
('PRD011', 'Planta Barcelona', '10x10x10', 'Planta típica de Barcelona', 6000.00, 3500.00, 10, 'SEM'),
('PRD012', 'Flor Madrid', '20x10x5', 'Flor típica de Madrid', 16000.00, 12000.00, 11, 'FLO'),
('PRD013', 'Jardín Sevilla', '30x20x10', 'Jardín típico de Sevilla', 28000.00, 20000.00, 12, 'HER'),
('PRD014', 'Planta París', '20x20x10', 'Planta típica de París', 24000.00, 18000.00, 13, 'SEM'),
('PRD015', 'Maceta Marsella', '25x25x20', 'Maceta típica de Marsella', 20000.00, 15000.00, 14, 'MAC'),
('PRD016', 'Flor Milán', '15x15x5', 'Flor típica de Milán', 14000.00, 10000.00, 15, 'FLO'),
('PRD017', 'Jardín Florencia', '40x30x20', 'Jardín típico de Florencia', 32000.00, 25000.00, 16, 'HER'),
('PRD018', 'Planta Múnich', '20x20x15', 'Planta típica de Múnich', 26000.00, 20000.00, 17, 'SEM'),
('PRD019', 'Maceta Stuttgart', '30x30x20', 'Maceta típica de Stuttgart', 22000.00, 16000.00, 18, 'MAC');

-- Insert data into bodega table
INSERT INTO bodega (id,nombre, idCiudad) VALUES 
(1,'Bodega Buenos Aires', 1), 
(2,'Bodega São Paulo', 4), 
(3,'Bodega Bogotá', 8), 
(4,'Bodega Barcelona', 10), 
(5,'Bodega París', 13), 
(6,'Bodega Milán', 15), 
(7,'Bodega Múnich', 17);

-- Insert data into productoBodega table
INSERT INTO productoBodega (idBodega, idProducto, cantidad) VALUES 
(1, 'PRD001', 50), (1, 'PRD002', 30),
(2, 'PRD005', 60), (2, 'PRD006', 40),
(3, 'PRD009', 70), (3, 'PRD010', 50),
(4, 'PRD011', 80), (4, 'PRD012', 60),
(5, 'PRD014', 90), (5, 'PRD015', 70),
(6, 'PRD016', 100), (6, 'PRD017', 80),
(7, 'PRD018', 110), (7, 'PRD019', 90);

-- Insert data into oficina table
INSERT INTO oficina (id, nombre) VALUES 
('OF1', 'Oficina Central'), 
('OF2', 'Oficina Regional Norte'), 
('OF3', 'Oficina Regional Sur');

INSERT INTO oficina_telefono (id, telefono, tipoTelefono, idOficina) VALUES 
(1, '123456789', 1, 'OF1'), 
(2, '987654321', 2, 'OF1'),
(3, '456789123', 1, 'OF2'), 
(4, '789123456', 2, 'OF2'),
(5, '321654987', 1, 'OF3'), 
(6, '654987321', 2, 'OF3');


-- Insert data into empleado table
INSERT INTO empleado (id,nombre, apellido1, apellido2, extension, email, idOficina, idJefe, idCargo) VALUES 
(1,'Juan', 'Pérez', 'González', '101', 'juan.perez@example.com', 'OF1', NULL, 1),
(2,'María', 'López', 'Hernández', '102', 'maria.lopez@example.com', 'OF1', 1, 2),
(3,'Carlos', 'Martínez', 'Díaz', '103', 'carlos.martinez@example.com', 'OF2', 1, 3),
(4,'Ana', 'García', 'Sánchez', '104', 'ana.garcia@example.com', 'OF3', 1, 4);

-- Insert data into empleado_direccion table
INSERT INTO empleado_direccion (id,direccion, tipoDireccion, idEmpleado, idCiudad) VALUES 
(1, 'Calle Falsa 123', 1, 1, 1), (2, 'Avenida Siempre Viva 742', 2, 1, 1),
(3, 'Calle 456', 1, 2, 2), (4, 'Avenida 789', 2, 2, 2),
(5, 'Calle Real 987', 1, 3, 3), (6, 'Avenida Principal 654', 2, 3, 3),
(7, 'Calle Mayor 321', 1, 4, 4), (8, 'Avenida Central 123', 2, 4, 4);

-- Insert data into cliente table
INSERT INTO cliente (id,nombre, apellido1, apellido2, limiteCredito, idEmpleado) VALUES 
(1,'Laura', 'Fernández', 'Jiménez', 50000.00, 2),
(2,'Pedro', 'Rodríguez', 'Morales', 30000.00, 2),
(3,'Lucía', 'Ramírez', 'Gómez', 40000.00, 3),
(4,'Jorge', 'Díaz', 'Martín', 60000.00, 3);

-- Insert data into cliente_direccion table
INSERT INTO cliente_direccion (id, direccion, tipoDireccion, idCliente, idCiudad) VALUES 
(1, 'Calle A 123', 1, 1, 1), (2, 'Avenida B 456', 2, 1, 1),
(3, 'Calle C 789', 1, 2, 2), (4, 'Avenida D 012', 2, 2, 2),
(5, 'Calle E 345', 1, 3, 3), (6, 'Avenida F 678', 2, 3, 3),
(7, 'Calle G 901', 1, 4, 4), (8, 'Avenida H 234', 2, 4, 4);

-- Insert data into cliente_contacto table
INSERT INTO cliente_contacto (id,nombre, apellido1, apellido2, correo, idCliente) VALUES 
(1,'Laura', 'Fernández', 'Jiménez', 'laura.fernandez@example.com', 1),
(2,'Pedro', 'Rodríguez', 'Morales', 'pedro.rodriguez@example.com', 2),
(3,'Lucía', 'Ramírez', 'Gómez', 'lucia.ramirez@example.com', 3),
(4,'Jorge', 'Díaz', 'Martín', 'jorge.diaz@example.com', 4);

INSERT INTO cliente_telefono (id, telefono, tipoTelefono, idCliente) VALUES 
(1, '111222333', 1, 1), 
(2, '222333444', 2, 1),
(3, '333444555', 1, 2), 
(4, '444555666', 2, 2),
(5, '555666777', 1, 3), 
(6, '666777888', 2, 3),
(7, '777888999', 1, 4), 
(8, '888999000', 2, 4);


-- Insert data into pedido table
INSERT INTO pedido (id,fechaPedido, fechaEsperada, fechaEntrega, comentario, idCliente, idEstado) VALUES 
(1,'2023-01-01', '2023-01-10', '2023-01-09', 'Entrega rápida', 1, 4),
(2,'2023-02-01', '2023-02-10', '2023-02-09', 'Entrega sin problemas', 2, 4),
(3,'2023-03-01', '2023-03-10', '2023-03-09', 'Entrega satisfactoria', 3, 4),
(4,'2023-04-01', '2023-04-10', '2023-04-09', 'Entrega rápida y eficiente', 4, 4);

-- Insert data into detalle_pedido table
INSERT INTO detalle_pedido (idPedido, idProducto, cantidad, idLineaProducto) VALUES 
(1, 'PRD001', 5, 1), (1, 'PRD002', 3, 2),
(2, 'PRD003', 10, 3), (2, 'PRD004', 7, 4),
(3, 'PRD005', 2, 1), (3, 'PRD006', 4, 2),
(4, 'PRD007', 6, 3), (4, 'PRD008', 8, 4);

-- Insert data into pago table
INSERT INTO pago (fecha, total, idTipo, idCliente) VALUES 
('2023-01-01', 50000.00, 1, 1), ('2023-02-01', 30000.00, 2, 2),
('2023-03-01', 40000.00, 3, 3), ('2023-04-01', 60000.00, 4, 4);

INSERT INTO oficina_direccion (id,idCiudad, direccion, idOficina, tipoDireccion) VALUES 
(1,1, 'Calle Oficina Central 123', 'OF1', 1),
(2,4, 'Avenida Oficina Regional Norte 456', 'OF2', 1),
(3,8, 'Boulevard Oficina Regional Sur 789', 'OF3', 1);

drop database garden1;

select * from oficina_direccion;
show tables;
use garden1;
-- 1 Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

select f.id,c.nombre from oficina as f 
join oficina_direccion as od on f.id = od.idOficina 
join ciudad as c on c.id = od.idCiudad; 

-- 2 Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

SELECT ciudad.nombre AS Ciudad, oficina_telefono.telefono AS Telefono
FROM ciudad
INNER JOIN region ON ciudad.idRegion = region.id
INNER JOIN pais ON region.idPais = pais.id
INNER JOIN oficina ON ciudad.nombre = oficina.nombre
INNER JOIN oficina_telefono ON oficina.id = oficina_telefono.idOficina
WHERE pais.nombre = 'España';

SELECT * FROM oficina_telefono as ot join oficina_direccion as od on ot.idOficina = od.idOficina;

select * from ciudad;

select c.nombre,r.nombre,c.id from oficina_direccion as od join ciudad as c on od.idCiudad = c.id join oficina_telefono as ot on od.idOficina = ot.idOficina join region as r on c.idRegion = r.id;