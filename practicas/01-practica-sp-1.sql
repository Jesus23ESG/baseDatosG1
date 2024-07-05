--crear un sp que solicite un id de una categoria y devuelva el promedio de los precios de sus productos

create or alter proc sp_solicitar_promedio_prod
@catego int -- parametro de entrada
as
begin

select avg(UnitPrice) as 'Promedio de los precios de los productos'
from Products
where CategoryID = @catego;
end
go

exec sp_solicitar_promedio_prod 2

exec sp_solicitar_promedio_prod @catego = 5