-- Crear la base de datos
create database ejercicioexam;

-- Usar la base de datos
use ejercicioexam;
-- Crear las tablas solicitadas
-- Proveedor
CREATE TABLE proveedor(
    idprov int not null IDENTITY(1,1),
    nombre varchar(50) not null,
    limite_credito money not null,
    constraint pk_proveedor
    primary key(idprov),
    constraint unico_nombre_proveedor
    unique(nombre)
);

-- Tabla Categoria
CREATE TABLE categoria(
    idcatego int not null,
    nombre varchar(50) not null,
    constraint pk_categoria
    primary key (idcatego),
    constraint unico_nombre
    unique(nombre)
);

CREATE TABLE Producto(
    idprod int not null,
    nombre varchar(50) not null,
    precio money not null,
    existencia int not null,
    proveedor int,
    idcatego int
    constraint pk_producto
    primary key(idprod),
    constraint fk_producto_prov
    foreign key (proveedor)
    references proveedor(idprov),
    constraint fk_producto_categoria
    foreign key (idcatego)
    references categoria(idcatego)
)


-- Insertar datos en las tablas
insert into proveedor (nombre, limite_credito)
values('Coca-cola', 98777),
      ('Pecsi', 234567),
      ('Hay me Pica', 44566),
      ('Hay me Duele', 45677),
      ('Tengo Miedo', 22344);
	  


insert into categoria
values(1, 'Lacteos'),
(2, 'Linea Blanca'),
(3, 'Dulces'),
(4, 'Vinos'),
(5, 'Abarrotes');
     

select * from proveedor

insert into producto
values(1, 'Mascara', 78.9, 20, 5,5)

insert into producto(proveedor, existencia, idcatego, precio, idprod, nombre)
values(3, 34, 5, 56.7, 2, 'Manita Rascadora')

insert into producto
values (3, 'Tonayan', 1450, 56,4 ,4),
       (4, 'Caramelo', 200, 22,1 ,3),
       (5, 'Terry', 200, 24,4 ,4);


select * from Producto;
select * from Categoria;
select * from proveedor;


-- Consultas con inner join

select c.idcatego, p.idcatego, c.nombre, p.nombre, p.precio, (p.precio * p.existencia) as importe
from categoria as c
INNER JOIN producto as p
on c.idcatego= p.idcatego;


select *, (p.precio * p.existencia) as importe
from categoria as c
INNER JOIN producto as p
on c.idcatego= p.idcatego;


-- Categoria
-- idcatego
-- nombre

--Producto
--precio
--existencia
--nombre

Select c.idcatego, c.nombre, p.nombre, p.existencia, p.precio, (p.precio * p.existencia) as importe
From
( select idcatego, nombre FROM categoria) AS c
INNER JOIN
( select nombre, precio, existencia, idcatego from Producto ) as p
on c.idcatego = p.idcatego;

use NORTHWND

select *
from ( select orderid, orderDate,shipcountry, RequiredDate from   Orders) as o



SELECT * FROM
categoria as c
inner join producto as p
on c.idcatego = p.idcatego
inner join proveedor as pr
on pr.idprov = p.proveedor;


select c.nombre, p.nombre, p.precio, p.existencia
from categoria as c
LEFt JOIN producto as p
on c.idcatego= p.idcatego
where p.idcatego is null;


select c.nombre, p.nombre, p.precio, p.existencia
from ( select nombre, idcatego from categoria) as c
LEFt JOIN ( Select precio, existencia, idcatego, nombre from  producto) as p
on c.idcatego= p.idcatego
where p.idcatego is null;



select c.nombre, p.nombre, p.precio, p.existencia
from categoria as c
right JOIN producto as p
on c.idcatego= p.idcatego

insert into producto
values(6, 'p6', 45.6, 12, 2, null)



select c.nombre, p.nombre, p.precio, p.existencia
from categoria as c
full JOIN producto as p
on c.idcatego= p.idcatego


select *
from categoria as c
full JOIN producto as p
on c.idcatego= p.idcatego;


SELECT * FROM
categoria as c
left join producto as p
on c.idcatego = p.idcatego
inner join proveedor as pr
on pr.idprov = p.proveedor;


SELECT * FROM
categoria as c
left join producto as p
on c.idcatego = p.idcatego
left join proveedor as pr
on pr.idprov = p.proveedor;


SELECT * FROM
categoria as c
right join producto as p
on c.idcatego = p.idcatego
RIGHT join proveedor as pr
on pr.idprov = p.proveedor;


SELECT * FROM
categoria as c
right join producto as p
on c.idcatego = p.idcatego
inner join proveedor as pr
on pr.idprov = p.proveedor;

SELECT * FROM
categoria as c
full join producto as p
on c.idcatego = p.idcatego
inner join proveedor as pr
on pr.idprov = p.proveedor;


