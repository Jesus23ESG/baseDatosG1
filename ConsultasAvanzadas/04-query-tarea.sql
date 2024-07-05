

CREATE DATABASE pruebacargadinamica;
USE pruebacargadinamica;

SELECT TOP 0 EmployeeID, FirstName, LastName, [Address], HomePhone, Country
INTO pruebacargadinamica.dbo.empleado
FROM NORTHWND.dbo.Employees;

INSERT INTO pruebacargadinamica.dbo.empleado (FirstName, LastName, [Address], HomePhone, Country )
SELECT FirstName, LastName, [Address], HomePhone, Country
FROM NORTHWND.dbo.Employees;

SELECT * FROM pruebacargadinamica.dbo.empleado;

select top 0 EmployeeID, FirstName + ' ' + LastName as 'nombre completo',[Address], HomePhone, Country 
into pruebacargadinamica.dbo.dim_empleado
from NORTHWND.dbo.Employees;

insert into pruebacargadinamica.dbo.dim_empleado ([nombre completo],[Address],HomePhone, Country)
select FirstName + ' ' + LastName as ['nombre completo'],[Address],HomePhone,Country 
from NORTHWND.dbo.Employees;

select * from pruebacargadinamica.dbo.dim_empleado;
