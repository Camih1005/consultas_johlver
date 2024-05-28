create database garden;
use garden;


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

-- 

create table bodega(
id int primary key auto_increment,
nombre varchar(100) not null,
idCiudad int,
foreign key(idCiudad)references ciudad(id)
);

create table productoBodega(
idBodega int,
idProducto int,
cantidad int not null,
precioVenta int not null,

foreign key(idBodega)references bodega(id),
foreign key(idProducto)references producto(id)
)
