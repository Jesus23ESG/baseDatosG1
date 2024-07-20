use NORTHWND
go

--crear un sp que reciba como parametro de entrada el nombre de una tabla y
--visualice  todos sus registros (spu_mostrar_datos_tabla)

create or alter proc spu_mostrar_datos_tabla
@tabla varchar (1000)
as
begin
--sql dinamico
 declare @sql nvarchar(MAX);
 set @sql = 'select * from ' + @tabla;
 exec(@sql)
end;
go

select * from Categories


create or alter procedure spu_mostrar_datos_tabla2
@tabla varchar (1000)
as
begin
--sql dinamico
 declare @sql nvarchar(MAX);
 set @sql = 'select * from ' + @tabla;
 exec sp_executesq1 @sql
end;
go

