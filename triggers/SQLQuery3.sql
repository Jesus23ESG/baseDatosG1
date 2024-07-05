Create database Pruebatriggers;
Go

Use Pruebatriggers;
Go

 Create table Empleado(
 Idempleado int not null primary key, 
 NombreEmplado varchar(30) not null,
 Apellido1 varchar(15) not null,
 Apellido2 varchar(15) null,
 Salario money not null
 );
 Go

 Create or alter trigger tg_1
 on Empleado 
 after insert
 as 
 begin
	print 'Se ejecuto el trigger tg_1, en el evento insert'
 end;
 Go

 select * from Empleado

 insert into Empleado 
 values(2, 'Rocio', 'Cruz', 'Cervantes', 80000)
 Go
	
drop trigger tg_1;
Go

create or alter trigger tg_2
on empleado
after insert 
as
begin
	select * from inserted;
	select * from deleted;
end;
Go

create or alter trigger tg_3
on empleado 
after deleted
as 
begin
	select * from inserted;
	select * from deleted;
end;
Go
 
 insert into Empleado 
 values(2, 'Rocio', 'Cruz', 'Cervantes', 80000)
 Go

 delete empleado 
 where Idempleado = 2;

create or alter trigger tg_4
on empleado 
after update
as 
begin
	select * from inserted;
	select * from deleted;
end;
Go

select * from Empleado;

update Empleado
set NombreEmplado = 'Pancracio', 
salario = 10000
where idempleado = 1;
go

create or alter trigger tg_5
on Empleado 
after insert, delete
as 
begin
	if exists (select 1 from inserted)
	begin
	print 'se realizo un insert'
	end
	else if exists (select 1 from deleted)and 
	not exists(select 1 from inserted)
	begin 
	print 'se realizo un delete' 
	end
 end;
Go

insert into Empleado
values (2, 'Leslie', 'Jimenez', 'Neri')


delete from Empleado
where Idempleado = 2