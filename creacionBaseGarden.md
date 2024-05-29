create database garden;
use garden;

-- tabla tipo_telefono

create table tipo_telefono(
id int primary key auto_increment,
nombre varchar(20) not null
);



-- tabla de tipo_direccion

create table tipo_direccion(
id int primary key auto_increment,
nombre varchar(20) not null,
descripcion text
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

-- tabla gama

create table gama_producto(
id varchar(50) primary key,
descripcion text,
descripcionHtml text,
imagen varchar(256)
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

create table linea_producto(
id smallint(6) primary key,
nombre varchar(100) not null,
descripcion text
);

-- tabla estado

create table estado(
id int(3) primary key,
nombre varchar(25) not null
);


-- tabla tipo

create table tipo(
id int primary key auto_increment,
nombre varchar(50) not null
);









-- tabla cliente



create table cliente(
id int(11) primary key auto_increment,
nombre varchar(100) not null,
apellido1 varchar(100) not null,
apellido2 varchar(100),
idEmpleado int(11),




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
id int(11) primary key,
fechaPedido date not null,
fechaEsperada date not null,
fechaEntrega date,
comentario text,
idCliente int(11),
idEstado int(3),
foreign key(idCliente) references cliente(id),
foreign key(idEstado) references estado(id)
);

create table detalle_pedido(
idPedido int primary key auto_increment,
idProducto varchar(15),
cantidad int(11) not null,
idLineaProducto smallint(6),
foreign key(idPedido)references pedido(id),
foreign key(idProducto)references producto(id),
foreign key(idLineaProducto)references linea_producto(id)
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
idPuesto int,
foreign key(idOficina)references oficina(id),
foreign key(idJefe)references empleado(id),
foreign key(idPuesto)references puesto(id)

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


show tables;

drop database garden;


