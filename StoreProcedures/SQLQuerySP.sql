--STORE PROCEDURES
use NORTHWND;

CREATE PROCEDURE sp_prueba_g1
AS 
BEGIN
print 'Hola Mundo';
END

--Ejecutar un Store Procedures
EXEC sp_prueba_g1

--Declaracion de variables
DECLARE @n INT
DECLARE @i INT

set @n  = 5 
set @i = 1

print ('el valor de n es:' + cast (@n as varchar))
print ('el valor de n es:' + cast (@i as varchar))


CREATE DATABASE prueba_sp;
use prueba_sp

create proc ps_1
AS
BEGIN



DECLARE @n INT
DECLARE @i INT

set @n  = 5 
set @i = 1

print ('el valor de n es:' + cast (@n as varchar))
print ('el valor de n es:' + cast (@i as varchar))
END

--Ejecutar 10 veces sp_1 solamente si el sentinela es 1

DECLARE @n as int = 10, @i int =1

while @i<=@n
begin 
print(@i);
set @i+=1 
end

--Store procedure con parámetros de entrada
CREATE PROC sp_3
@n int --párametro de entrada
AS
begin
DECLARE @i int =1


IF @n>0
begin 
while @i<=@n
begin 
print(@i);
set @i+=1 
end
end 
else 
BEGIN
print 'el valor de n debe ser mayor a 0'
end 
end 

EXEC sp_3 10
EXEC sp_3 @n=20 


--Store procedure que te de la suma de i
CREATE PROC sp_4
@n int --Párametro de entrada
AS
begin
DECLARE @i int =1
DECLARE @acum int


IF @n>0
begin 
while @i<=@n
begin 
set @acum+=@i
set @i+=1 --set @i + 1
end
print ('La suma de los numero es:' + cast(@acum as varchar))
end

else 
BEGIN
print 'el valor de n debe ser mayor a 0'
end 
end

EXECUTE sp_4 10

--Seleccionar de la base de datos nortwind todas las ordenes de compra para un año determinado

USE NORTHWND;
GO

CREATE PROCEDURE GetOrdersByYear
    @Year INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT OrderDate
	FROM Orders
    WHERE YEAR(OrderDate) = @Year;
END;
GO

EXEC GetOrdersByYear @Year = 1997;

--Crear un sp que muestre el total de ventas para cada cliente por un rango de años

USE NORTHWND;
GO

SELECT * FROM v

CREATE or alter PROCEDURE proc_ordenes_año
    @DatePart INT
AS
BEGIN
    SELECT OrderDate
    FROM Orders
    WHERE YEAR(OrderDate) = @DatePart;
END;
GO
EXECUTE proc_ordenes_año @DatePart = 1887;


--02/07/24
--Parametros salida
create or alter procedure calcular_area
--parametros de entrada
@radio float,
--Parametro de salida
@area float output 
AS
begin 
   SET @area = PI() * @radio * @radio 
end 
go

declare @respuesta float 
exec calcular_area @radio = 22.3, @area =  @respuesta output
print 'el area es: ' + cast(@respuesta as varchar)
GO


create or alter procedure sp_obtenerDatosDelEmpleado
@numeroEmpleado int,
@fullName nvarchar(35) OUTPUT
AS
BEGIN
select @fullName= concat(FirstName, ' ', LastName) from 
Employees
where EmployeeID = @numeroEmpleado;
end;
GO


declare @nombreCompleto nvarchar(35)
exec sp_obtenerDatosDelEmpleado @numeroEmpleado = 3, @fullName = @nombreCompleto output
print @nombreCompleto





create or alter procedure sp_obtenerDatosDelEmpleado3
@numeroEmpleado int,
@fullName nvarchar(35) OUTPUT
AS
BEGIN
select @fullName= concat(FirstName, ' ', LastName)
from 
Employees
where EmployeeID = @numeroEmpleado;

if @fullName is null 
begin 
print 'No existe el empleado'
end
end;
go

declare @nombreCompleto nvarchar(35)
exec sp_obtenerDatosDelEmpleado3 @numeroEmpleado = 3, @fullName = @nombreCompleto output
print @nombreCompleto


--TAREA
Select * from Customers 

create database etlempresa;
use etlempresa; 

CREATE TABLE cliente (
    clienteid INT NOT NULL IDENTITY(1,1),
    clientebk NCHAR(5) NOT NULL,
    empresa NVARCHAR(40) NOT NULL,
    ciudad NVARCHAR(15) NOT NULL,
    region NVARCHAR(15) NOT NULL,
    pais NVARCHAR(15) NOT NULL,
    constraint pk_clienteid primary key (clienteid);

exec sp_etl_carga_cliente

create or alter proc sp_etl_carga_cliente
AS
BEGIN 

insert into etlempresa.dbo.cliente
	select CustomerID, upper(CompanyName) as 'Empresa',upper(city) as 'Ciudad', upper(isnull(nc.Region, 'SIN REGION')) as 'Region', upper(Country) as 'Pais'
	from NORTHWND.dbo.Customers as nc
	left join etlempresa.dbo.cliente as etle
	on nc.CustomerID = etle.clientebk
	where etle.clientebk is null

update cl
	set cl.empresa = upper(c.CompanyName),
	cl.ciudad = upper(c.City),
	cl.pais = upper(c.Country),
	cl.region = upper(isnull(c.Region, 'SIN REGION'))
	from NORTHWND.dbo.Customers as c
	inner join etlempresa.dbo.cliente as cl
	on c.CustomerID = cl.clientebk;

	select * from NORTHWND.dbo.Customers
	where CustomerID = 'CLIB1';

	select * from etlempresa.dbo.cliente
	where clientebk = 'CLIB1';

	update NORTHWND.dbo.Customers 
	set CompanyName = 'Pepsi' where CustomerID = 'CLIB1'

end

truncate table etlempresa.dbo.cliente

create table producto
(
	productoid int not null identity (1,1),
	productobk nchar(5) not null,
	nombreProducto nvarchar(20) not null,
	categoria nvarchar(20) not null,
	precio money not null,
	existencia int not null,
	descontinuado int not null,
	primary key(productoid)
)

select * from NORTHWND.dbo.Products
	select * from NORTHWND.dbo.Categories
	select * from NORTHWND.dbo.Customers
	select * from NORTHWND.dbo.Employees

create or alter proc sp_etl_carga_producto
AS
BEGIN 
insert into etlempresa.dbo.producto
	select p.ProductID, upper(p.ProductName) as 'Nombre Producto',upper(c.CategoryName) as 'categoria', p.UnitPrice as 'precio', p.UnitsInStock as 'Unidades Disponibles', p.Discontinued as 'descontinuado'
	from NORTHWND.dbo.Products as p
	inner join NORTHWND.dbo.Categories as c
	on c.CategoryID = p.CategoryID
	left join etlempresa.dbo.producto as etle
	on p.ProductID = etle.productobk
	where etle.productobk is null

update p
 set
 p.nombreProducto = upper(pr.ProductName),
 p.categoria = upper(c.CategoryName),
 p.precio = upper(pr.UnitPrice),
 p.existencia = upper(pr.UnitsInStock),
 p.descontinuado= UPPER(Discontinued)

 from NORTHWND.dbo.Products as pr
 inner join NORTHWND.dbo.Categories as c
 on c.CategoryID = pr.CategoryID
 inner join etlempresa.dbo.producto as p
 on P.productobk = pr.ProductID
	--set cl.empresa = upper(c.CompanyName),
	--cl.ciudad = upper(c.City),
	--cl.pais = upper(c.Country),
	--cl.region = upper(isnull(c.Region, 'SIN REGION'))
	--from NORTHWND.dbo.Customers as c
	--inner join etlempresa.dbo.cliente as cl
	--on c.CustomerID = cl.clientebk;

	 select * from NORTHWND.dbo.Products
	where ProductID = 2;

	select * from etlempresa.dbo.producto
	where productobk = 2;

	update NORTHWND.dbo.Products 
	set UnitsInStock = 20 where ProductID = 2
end

exec sp_etl_carga_producto
truncate table etlempresa.dbo.producto

create table empleado
(
	empleadoid int not null identity(1,1),
	empleadobk nchar(5) not null,
	nombreCompleto nvarchar(50) not null,
	ciudad nvarchar(50) not null,
	region nvarchar(50) not null,
	pais nvarchar(50) not null,
	primary key (empleadoid)
)

select * from NORTHWND.dbo.Products
	select * from NORTHWND.dbo.Categories
	select * from NORTHWND.dbo.Customers

create or alter proc sp_etl_carga_empleado
AS
BEGIN 
insert into etlempresa.dbo.empleado
 select e.EmployeeID, upper(concat(e.FirstName, ' ', e.LastName)) as 'NombreCompleto', upper(e.City) as 'Ciudad', UPPER(e.Region) as 'region', upper(e.Country) as 'pais'
	from NORTHWND.dbo.Employees as e
	left join etlempresa.dbo.empleado as em
	on e.EmployeeID = em.empleadobk
	where em.empleadobk is null
		--select * from NORTHWND.dbo.Employees

update em
 set
 em.nombreCompleto = upper(CONCAT(e.FirstName,' ', e.LastName)),
 em.ciudad = upper(e.City),
 em.region = UPPER(e.Region),
 em.pais = upper(e.Country)
 from NORTHWND.dbo.Employees as e
 inner join etlempresa.dbo.empleado as em
 on e.EmployeeID = em.empleadobk




end

exec sp_etl_carga_empleado

CREATE TABLE proveedor (
    proveedorid INT NOT NULL IDENTITY(1,1),
    proveedor NCHAR(5) NOT NULL,
    empresa NVARCHAR(100) NOT NULL,
    city NVARCHAR(50) NOT NULL,
    region NVARCHAR(50) NOT NULL,
    country NVARCHAR(50) NOT NULL,
    homepage NVARCHAR(100) NOT NULL,
    PRIMARY KEY (proveedorid)
);







create or alter proc sp_etl_carga_proveedor
AS
BEGIN 
insert into etlempresa.dbo.proveedor
 select s.SupplierID, s.CompanyName as 'compañia',s.City as 'ciudad',s.Region,s.Country, s.HomePage
	from NORTHWND.dbo.Suppliers as s
	left join etlempresa.dbo.proveedor as pr
	on s.SupplierID = pr.proveedor
	where pr.proveedor is null
		--select * from NORTHWND.dbo.Suppliers

update pr
 set
 pr.proveedor = s.CompanyName, 
 pr.city = s.City,
 pr.region = s.Region,
 pr.country = s.Country,
 pr.homepage = s.HomePage
 from NORTHWND.dbo.Suppliers as s
 inner join etlempresa.dbo.proveedor as pr
 on s.SupplierID = pr.proveedor

end

exec sp_etl_carga_proveedor

CREATE TABLE ventas (
    clienteid INT NOT NULL,
    productoid INT NOT NULL,
    empleadoid INT NOT NULL,
    proveedorid INT NOT NULL,
    cantidad INT NOT NULL,
    precio MONEY NOT NULL,
    CONSTRAINT fk_cliente FOREIGN KEY (clienteid) REFERENCES cliente(clienteid),
    CONSTRAINT fk_producto FOREIGN KEY (productoid) REFERENCES producto(productoid),
    CONSTRAINT fk_empleado FOREIGN KEY (empleadoid) REFERENCES empleado(empleadoid),
    CONSTRAINT fk_proveedor FOREIGN KEY (proveedorid) REFERENCES proveedor(proveedorid)
);

create or alter proc sp_etl_carga_ventas
as 
begin
insert into etlempresa.dbo.ventas
select ord.Quantity,ord.UnitPrice
from NORTHWND.dbo.[Order Details] as ord
