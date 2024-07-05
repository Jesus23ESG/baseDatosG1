use NORTHWND

select ProductName, UnitPrice, UnitsInStock,
Discontinued,
CASE Discontinued
when 0 then 'No Disponible'
when 1 then 'Disponible'
else 'No existente'
end as 'Disponibilidad'
from Products


select ProductName, UnitPrice, UnitsInStock,
Discontinued,
disponiblidad = CASE Discontinued
when 0 then 'No Disponible'
when 1 then 'Disponible'
else 'No existente'
end
from Products

select ProductName, UnitsInStock, UnitPrice,
case
when UnitPrice >=1 and UnitPrice<18 then 'Producto Barato'
when UnitPrice >=18 and UnitPrice<=50 then 'Producto medio Barato'
when UnitPrice between 51 and 100 then 'Producto Caro'
else 'Carisimo'
end as 'Categoria Precios'
from Products
where ProductID in (29, 38);

use AdventureWorks2019;

select BusinessEntityID,
SalariedFlag
from HumanResources.Employee
order by
 Case SalariedFlag  
 when 1 then BusinessEntityID
 END DESC,
 Case
 when SalariedFlag = 0 then BusinessEntityID
 end ASC;


 SELECT BusinessEntityID,
    LastName,
    TerritoryName,
    CountryRegionName
FROM Sales.vSalesPerson
WHERE TerritoryName IS NOT NULL
ORDER BY
        CASE CountryRegionName
        WHEN 'United States' then TerritoryName
        ELSE CountryRegionName
        END

-- ISNULL

SELECT v.AccountNumber,
       v.Name,
      v.PurchasingWebServiceURL as 'PurchasingWebServiceURL'
FROM
   [Purchasing].[Vendor] as v;

SELECT v.AccountNumber,
       v.Name,
      ISNULL(v.PurchasingWebServiceURL, 'El Viernes no van a pasar')
      as 'PurchasingWebServiceURL'
FROM
   [Purchasing].[Vendor] as v;

SELECT v.AccountNumber,
       v.Name,
      v.PurchasingWebServiceURL as 'PurchasingWebServiceURL'
FROM
   [Purchasing].[Vendor] as v;

   use AdventureWorks2019
   select IIF(1=1, 'VERDADERO', 'FALSO') AS 'RESULTADO'

   CREATE VIEW vista_genero
   as
select e.LoginID, e.JobTitle, e.Gender, IIF(e.Gender='F', 'MUJER','HOMBRE') AS 'SEXO'
FROM HumanResources.Employees AS e;

select UPPER(JobTitle) as [Titulo]
from vista_genero
where SEXO = 'MUJER'


--Merge

select OBJECT_ID(N'tempdb..#StudentsC1')
IF OBJECT_ID (N'tempdb..#StudentsC1') is not NULL
begin
    drop table #StudentsC1;
end

CREATE TABLE #StudentsC1(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);

INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)




IF OBJECT_ID(N'tempdb..#StudentsC2') is not NULL
begin
drop table #StudentsC2
END


CREATE TABLE #StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);


INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rendón',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora Ríos',0)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto García Morales',1)

select * from #StudentsC1
select * from #StudentsC2

select * from 
#StudentsC1 as s1
inner join #StudentsC2 as s2
on s1.StudentID = s2.StudentID

insert into #StudentsC2(StudentID, StudentName, StudentStatus)
select s1.StudentID, s1.StudentID, s1.StudentStatus
from 
#StudentsC1 as s1
left join #StudentsC2 as s2
on s1.StudentID = s2.StudentID
where s2.StudentID is null

update s2 
set s2.studentName = s1.studentName,
s2.StudentStatus = s1.StudentStatus
from 
#StudentsC1 as s1
inner join #StudentsC2 as s2
on s1.StudentID = s2.StudentID