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

CREATE table cliente
(
    clienteid int not null IDENTITY(1,1),
    clientebk nchar(5) not null,
    empresa NVARCHAR(40) not null,
    ciudad NVARCHAR(15) not null,
    region NVARCHAR(15) not null,
    pais NVARCHAR(15) not null, 
    CONSTRAINT pk_cliente
    PRIMARY key(clienteid)
)

create proc sp_etl_carga_cliente
AS
BEGIN 

insert into etlempresa.dbo.cliente
select CustomerID, UPPER(CompanyName) AS 'Empresa', UPPER(city) as Ciudad,
upper (isnull(nc.region, 'SIN REGION'))as Region, UPPER(country ) as pais 
from NORTHWND.dbo.Customers as nc 
left join etlempresa.dbo.cliente etle 
on nc.CustomerID = etle.clientebk
where etle.clientebk is null;



select * from NORTHWND.dbo.Customers
inner join etlempresa.dbo.cliente as cl 
on nc.CustomerID = etle.clientebk
where etle.clientebk is null;

UPDATE cl
set cl.empresa = UPPER(c.CompanyName),
cl.ciudad = UPPER(c.city)
cl.pais = UPPER(c.Country)
cl.region = UPPER(ISNULL(c.region, 'sin region'))
from NORTHWND.dbo.Customers as nc 
left join etlempresa.dbo.cliente etle 
on nc.CustomerID = etle.clientebk

SELECT * FROM NORTHWND.dbo.Customers
where CustomerID = 'CLIB1'

UPDATE NORTHWND.dbo.Customers
SET CompanyName = 'pepsi'
where CustomerID = 15

SELECT * FROM etlempresa.dbo.cliente
where cliente = 'CLIB1'

TRUNCATE table etlempresa.dbo.cliente