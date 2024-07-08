
-- Sellecionar todas las ordenes que fueron emitidas por los
-- empleados Nancy Davolio, Anne Dodsworth y Andrew Fuller

select * from Orders
where EmployeeID = 1 
or EmployeeID = 9 
or EmployeeID = 2;

select * from Orders
where EmployeeID in(1,9,2);

-- Seleccionar todas las ordenes, dividiendo la fecha de orden en, año, mes y dia 
select orderDate as 'Fecha de orden', 
year(OrderDate) as 'Año', 
month (OrderDate) as 'Mes', 
day(OrderDate) as 'Día' 
from Orders;

-- Seleccionar todos los nombres de los empleados
select concat(FirstName,' ' ,LastName) as 'Nombre Completo' 
from Employees;

-- Seleccionar todos los productos donde la existencia sea mayor o igual a 40
-- y el precio sea menor a 19
select ProductName as 'Nombre del prodcuto', 
UnitPrice as 'Precio', 
UnitsInStock as 'Existencia' 
from Products
where UnitsInStock >= 40
and  UnitPrice < 19;

-- Seleccionar todas las ordenes realizadas de abril a Agosto de 1996

select OrderID, CustomerID, EmployeeID, OrderDate 
from Orders
where OrderDate>= '1996-04-01' and OrderDate<='1996-08-31';

select OrderID, CustomerID, EmployeeID, OrderDate 
from Orders
where OrderDate between '1996-04-01' and '1996-08-31';

-- Seleccionar todas las ordenes entre 1996 y 1998
select * from Orders
where year(OrderDate) BETWEEN '1996' and '1998';

-- Seleccionar todas las ordenes de 1996 y 1999

select * from 
orders
where year(OrderDate) in ('1996', '1999')


-- Seleccionar todos los productos que comiencen con c

select * 
from 
Products
where ProductName like 'c%';

select * 
from 
Products
where ProductName like 'ca%';

-- Sellecionar todos los productos que terminen con s
select * 
from 
Products
where ProductName like '%s';

-- Seleccionar todos los productos que el nombre del produto contenga la palabra no
Select * 
from Products
where ProductName like '%no%';

-- Seleccionar todos los productos que contengan las letras a o n

select * from 
Products 
where ProductName like '%[AN]%'

select * from 
Products 
where ProductName like '%A%'
or ProductName like '%N%';

-- Seleccionar todos los productos que comiencen entre la letra A y N
select * from 
Products 
where ProductName like '[A-N]%';

-- Sellecionar todas las ordenes que fueron emitidas por los
-- empleados Nancy Davolio, Anne Dodsworth y Andrew Fuller (inner join)

select o.OrderID as 'Numero de Orden',
o.OrderDate as 'Fecha de Orden', 
concat(FirstName, ' ', LastName) as 'Nombre'
FROM 
Employees as e
INNER JOIN 
orders as o
on e.EmployeeID = o.EmployeeID
where e.FirstName in ('Nancy', 'Anne', 'Andrew')
and e.LastName in ('Davolio', 'Dodsworth', 'Fuller');


-- Crear base de datos
create database pruebaxyz;
--utilizar base de datos
use pruebaxyz;

-- Crear una tabla a partir de una consulta con cero registros

select top 0 * 
into pruebaxyz.dbo.products2
from Northwind.dbo.Products;

-- Agrega un constraint a la tabla products2
alter table products2
add constraint pk_products2
primary key(productid);

alter table products2
drop constraint pk_products2


select * from products2

-- llenar una tabla a partir de una consulta

insert into pruebaxyz.dbo.products2 (ProductName, SupplierID,
CategoryID,QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder,
ReorderLevel, Discontinued )
select ProductName, SupplierID,
CategoryID,QuantityPerUnit, UnitPrice, UnitsInStock, UnitsOnOrder,
ReorderLevel, Discontinued 
from northwind.dbo.Products;

-- Ejercicio 1: Obtener el nombre del cliente y el nombre del empleado 
-- del representante de ventas de cada pedido.

-- Nombre cliente (Customers)
-- Nombre del Empleado (Employees)
-- Pedido

use NORTHWND;

select o.customerId, o.Employeeid, o.orderid, o.orderdate 
from 
orders as o;

SELECT c.CompanyName as 'Nombre del cliente',
concat(e.FirstName, ',',e.LastName) as 'Nombre del Empleado', 
o.OrderID, o.orderdate, (od.Quantity * od.UnitPrice) as 'Importe'
FROM CUSTOMERS as c
INNER JOIN
Orders as o
ON o.CustomerID = c.customerid
INNER JOIN Employees as e
ON o.EmployeeID = e.EmployeeID
INNER JOIN [Order Details] AS od
ON od.OrderID = o.OrderID
-- where year(OrderDate) in ('1996', '1998');
where year(OrderDate) = '1996' or 
year(OrderDate) = '1998';

-- selecionar cuantas ordenes se han realizado en 1996 y 1998

SELECT count(*) as 'Total de Ordenes'
FROM CUSTOMERS as c
INNER JOIN
Orders as o
ON o.CustomerID = c.customerid
INNER JOIN Employees as e
ON o.EmployeeID = e.EmployeeID
INNER JOIN [Order Details] AS od
ON od.OrderID = o.OrderID
-- where year(OrderDate) in ('1996', '1998');
where year(OrderDate) = '1996' or 
year(OrderDate) = '1998';

--Ejercicio 2: Mostrar el nombre del producto, 
-- el nombre del proveedor 
-- y el precio unitario de cada producto.

SELECT p.ProductName as 'Nombre de Producto',
s.CompanyName as 'Nombre del Proveedor',
p.UnitPrice as 'Precio Unitario'
From Products as p
INNER JOIN Suppliers AS s
ON p.SupplierID = s.SupplierID

--Ejercicio 5: Mostrar el nombre del proveedor, el nombre del contacto y el teléfono del contacto para cada proveedor.
select CompanyName, ContactName, Phone 
from Suppliers

--Ejercicio 6: Listar el nombre del producto, la categoría del producto y el nombre del proveedor para cada producto.
select p.ProductName as 'nombre del producto', s.CompanyName as 'nombre del proveedor', c.CategoryName as 'categoria'
from Products as p
inner join Suppliers as s 
on p.SupplierID = s.SupplierID
inner join Categories as c
on c.CategoryID = p.CategoryID

--Ejercicio 7: Obtener el nombre del cliente, el ID del pedido, el nombre del producto y la cantidad del producto para cada detalle del pedido.
select CompanyName as 'NombreCliente', o.OrderID as 'IdPedido', p.ProductName as 'NombreProducto', od.Quantity as 'CantidadProducto'
from Customers as c
inner join orders as o
on c.CustomerID = o.CustomerID
inner join [Order Details] as od
on o.OrderID = od.OrderID
inner join Products as p
on p.ProductID = od.ProductID

--Ejercicio 8: Obtener el nombre del empleado, el nombre del territorio y la región del territorio para cada empleado que tiene asignado un territorio.
select concat(e.FirstName, ' ', e.LastName) as 'NombreEmpleado', t.TerritoryDescription 'NombreTerritorio', r.RegionDescription as 'RegionTerritorio'
from Employees as e
inner join EmployeeTerritories as et
on e.EmployeeID = et.EmployeeID
inner join Territories as t
on t.TerritoryID = et.TerritoryID
inner join region as r
on r.RegionID = t.RegionID;
--Ejercicio 9: Mostrar el nombre del cliente, el nombre del transportista y el nombre del país del transportista para cada pedido enviado por un transportista.
select c.CompanyName as 'NombreCliente', sh.CompanyName as 'NombreTransportista', o.ShipCountry as 'PaísTransportista'
from Customers as c
inner join Orders as o
on c.CustomerID = o.CustomerID
inner join Shippers as sh
on sh.ShipperID = o.ShipVia;
--Ejercicio 10: Obtener el nombre del producto, el nombre de la categoría y la descripción de la categoría para cada producto que pertenece a una categoría.
select p.ProductName as 'NombreProducto', c.CategoryName as 'NombreCategoría', c.Description as 'DescripciónCategiría'
from Products as p
inner join Categories as c
on c.CategoryID = p.CategoryID;

--Ejercicio 11. Seleccionar el total de ordenes hechas por cada uno de los proveedores 

select s.CompanyName as 'Proveedor', count(*)  as 'Total de Ordenes'
from Suppliers as s 
INNER JOIN Products as p
ON s.SupplierID = p.SupplierID
INNER JOIN [Order Details] as od 
ON od.ProductID = p.ProductID
group by s.CompanyName

--Ejercicio 12. Seleccionar el total de dinero que he vendido por proveedor del ultimo trimestre de 1996

select s.CompanyName as 'Proveedor', sum(od.UnitPrice * od.Quantity) as 'Total de Ventas $'
from Suppliers as s
INNER JOIN products as p
on s.SupplierID = p.SupplierID
INNER JOIN [Order Details] as od
on od.ProductID = p.ProductID
INNER JOIN Orders AS o
on o.OrderID = od.OrderID
where o.OrderDate between '1996-09-01' and '1996-12-31'
group by s.CompanyName
order by 'Total de Ventas $' desc


select  sum(od.UnitPrice * od.Quantity) as 'Total de Ventas $'
FROM  [Order Details] as od
inner join orders as o
on o.OrderID = od.OrderID
where o.OrderDate between '1996-09-01' and '1996-12-31'
order by 'Total de Ventas $' desc


select sum(unitprice *quantity) as 'Total de Ventas'
from [Order Details];

--Ejercicio 13. Seleccionar el total de dinero vendido por categoria

select c.categoryname, 
sum(od.Quantity * od.UnitPrice) as 'Total de ventas'
from [Order Details] as od
INNER JOIN Products as p 
on od.ProductID = p.ProductID
INNER JOIN categories as c 
on c.CategoryID = p.CategoryID
group by c.categoryname 
order by 2 desc;


select c.categoryname, 
sum(od.Quantity * od.UnitPrice) as 'Total de ventas'
from [Order Details] as od
INNER JOIN Products as p 
on od.ProductID = p.ProductID
INNER JOIN categories as c 
on c.CategoryID = p.CategoryID
group by c.categoryname 
order by sum(od.Quantity * od.UnitPrice) desc;

select c.categoryname, 
sum(od.Quantity * od.UnitPrice) as 'Total de ventas'
from [Order Details] as od
INNER JOIN Products as p 
on od.ProductID = p.ProductID
INNER JOIN categories as c 
on c.CategoryID = p.CategoryID
group by c.categoryname 
order by 'Total de ventas' desc;




--Ejercicio 14. Seleccionar el total de dinero vendido por categoria y dentro por producto
select c.CategoryName as 'NombreCategoria', sum(od.Quantity * od.UnitPrice) as 'Total'
from [Order Details] as od
    inner join Products as p
    on od.ProductID = p.ProductID
    inner join Categories as c
    on c.CategoryID = p.CategoryID
GROUP by  c.CategoryName, p.ProductName;



