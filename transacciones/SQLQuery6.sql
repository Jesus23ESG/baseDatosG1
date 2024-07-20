create table
idempleado int primary key identity(1,1)
nombre varchar(20)
apellido1 '' 
apellido2 ''
salario money

create or alter proc spu_agregar

@nombre varchar(20) = 'Luis',
@apellido1 varchar(20),
@apellido2 varchar(20),
@salario varchar(20)

as
	begin
		INSERT INTO EMPLEADO(nombre, apellido1, apellido2, salario)
		values(@nombre, @apellido1, @apellido2,@salario);
		end 
		go
exec spu_agregar '','','',''


--realizar un sp que muestre el total de las compras hechas por un cada uno de mis clientes 

create or alter proc spu_consultar_compras_clientes
as
 select c.CompanyName, o.OrderID, o.orderDate, od.quantity,od.unitprice
 inner join orders as o
 on c.CustomerID = o.CustomerID
 inner join[Order Details] as od
 on o.OrderID = od.OrderID