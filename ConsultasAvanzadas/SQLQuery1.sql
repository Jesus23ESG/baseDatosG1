--Funciones de agregado y agrupacion
--utilizar base de datos

use NORTHWND

--funciones ed agregado

--seleccionar el numero de total de ordenes de compra

--count(*)

select count(*) as 'Numero de ordenes' from Orders;

select count(*) from Customers

--count(campo)

select count(Region) from Customers;

--seleccionar el maximo numeri de productos pedidos
select max(Quantity) as cantidad from [Order Details]

--seleccionar el minimo de productos 
select min(Quantity) as cantidad from [Order Details]

--seleccionar el total de la cantidad de pedidos
select sum(UnitPrice) from [Order Details];

--seleccionar el total de dinero que e vendido


--seleccionar el numero de productos por categoria

select CategoryID, count(*) as 'numero de productos' 
from Products group by CategoryID;

--seleccionnar el total de productos por nombre de categoria
select c.CategoryID, count(*) as 'total' 
from Categories as c
inner join Products p
on c.CategoryID = p.CategoryID
where c.CategoryName in ('Beverages', 'confections')
group by c.CategoryName;