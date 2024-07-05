create database pruebajoinsg1;
use pruebajoinsg1;

create table proveedor(
provid int not null identity(1,1),
nombre varchar(50) not null,
limite_credito money not null
constraint pk_proveedor
primary key (provid),
constraint unico_nombrepro
unique(nombre)
);

create table productos (
productid int not null identity(1,1),
nombre varchar(50) not null,
precio money not null,
existencia int not null,
proveedor int ,
constraint pk_producto
primary key(productid),
constraint unico_nombre_proveedor
unique (nombre),
constraint fk_proveedor_producto
foreign key (proveedor)
references proveedor(provid)
)

--agregar registros a las tablas proverdor y producto

insert into proveedor (nombre,limite_credito)
values
('Proveedor1', 5000),
('Proveedor2', 6778),
('Proveedor3', 6788),
('Proveedor4', 5677),
('Proveedor5', 6666);

select * from proveedor;

insert into productos(nombre, precio,existencia, proveedor)
values
('Producto1', 56, 34, 1),
('Producto1', 56.56, 12, 1),
('Producto1', 45.5, 33, 2),
('Producto1', 22.34, 666, 3);

select * from proveedor

