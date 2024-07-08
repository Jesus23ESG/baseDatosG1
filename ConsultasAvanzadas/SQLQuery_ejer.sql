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


select * from Producto
select * from Categoria
select * from proveedor

--consultas con inner join

select c.idcatego, p.idcatego, c.nombre,p.nombre, p.precio, (p.precio * p.existencia) as importe
from categoria as c
inner join Producto as p
on c.idcatego= p.idcatego

select *, (p.precio * p.existencia) as importe
from categoria as c
inner join Producto as p
on c.idcatego= p.idcatego



--categoria
--idcatego
--nombre

--producto
--precio
--existencia
--nombre

select c.idcategoria, c.nombre, p.nombre, p.existencia, p.precio, (p.precio*p.existencia) as importe
from
(select idcategoria, nombre from Categoria) as c
inner join
(select precio, existencia, idcategoria, nombre from Producto) as p
on c.idcategoria = p.idcategoria;



--left join
select c.nombre, p.nombre, p.precio, p.existencia from Categoria as c 
left join Producto as p 
on c.idcategoria = p.idcategoria
where p.idcategoria is null;

--left join con tablas derivadas
select c.nombre, p.nombre, p.precio, p.existencia
from 
(select nombre, idcategoria from Categoria) as c
left join
(select nombre, precio, existencia, idcategoria from Producto) as p
on p.idcategoria = c.idcategoria
where p.idcategoria is null;



--right join
select * from Categoria as c 
right join Producto as p 
on c.idcategoria = p.idcategoria;



--full join
select * from Categoria as c 
full join Producto as p 
on c.idcategoria = p.idcategoria;



--COnvinaciones entre inner join, left join, right join 
select * from Categoria as c 
full join Producto as p 
on c.idcategoria = p.idcategoria
inner join Proveedor as pr
on pr.idProv = p.proveedor;