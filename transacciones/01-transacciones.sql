use NORTHWND

--Transaccion: las transacciones en SQL SERVER son fundamentales para 
--asegurar la consistencia y la integridad de los datos en una base
--de datos

--Una transaccion es una unidad de trabajop que se ejecuta de manera 
--completamente exitosa o no se ejecuta en absoluto

--sigue el principio ACID:
	--Atomicidad: toda la transaccion se completa o no se realiza nada
	--concistencia: la transaccion lleva la base de datos de un estado valido
	--a otro.
	--Aislamiento: Las transacciones concurrentes no interfieren entre si
	--Durabilidad: una vez que una transaccion se completa los cambios son permanentes 

	--comandos a utilizar_
	   --Begin transaction: Inicia una transaccion
	   --Commit Transaction: confirma todos los cambios realizados durante la transaccion
	   --Rollback Transaction: Revierte todos los cambios realizados durante la transaccion
	   
	   select * from Categories;
	   GO

	   --delete from categories 
	   --where CategoryID in (10,12)

	   begin transaction;

	   insert into Categories(CategoryName, Description)
	   values('Los remediales', 'Estara muy bien')
	   go

	   rollback transaction 
	   commit transaction

	   create database Pruebatransacciones

	   use Pruebatransacciones

	   create table empleado(
	   emplid int not null,
	   nombre varchar(50) not null,
	   salario money not null,
	   constraint pk_epleado
	   primary key (emplid),
	   constraint chk_salaatio
	   check(salario>0.0 and salario <50000)

	   );
	   go

	   create or alter proc spu_agregar_empleado
	   --Parametros de entrada
	   @emplid int, 
	   @nombre varchar(50),
	   @salario money
	   as 
		begin
		  begin try
			begin transaction;
			--intsera en la tabla empleados
			insert into empleado(emplid, nombre, salario)
			values(@emplid,@nombre,@salario);
			--se confirma la transaccion si todo va bien
			commit transaction;
		  end try
		  begin catch
		    Rollback transaction;
			--obtener el error
			declare @mensajeError nvarchar(4000)
			set @mensajeError = error_message();
			print @mensajeError;
		  end catch;
		end;
	go

	exec spu_agregar_empleado 1,'Monico',21000.0
	go

	exec spu_agregar_empleado 2,'Toribio',66000.0
	go

	select * from empleado