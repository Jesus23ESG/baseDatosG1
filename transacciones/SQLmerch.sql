--MERGE INTO <target table> AS TGT
--USING <SOURCE TABLE> AS SRC  
--  ON <merge predicate>
--WHEN MATCHED [AND <predicate>] -- two clauses allowed:  
--  THEN <action> -- one with UPDATE one with DELETE
--WHEN NOT MATCHED [BY TARGET] [AND <predicate>] -- one clause allowed:  
--  THEN INSERT... –- if indicated, action must be INSERT
--WHEN NOT MATCHED BY SOURCE [AND <predicate>] -- two clauses allowed:  
--  THEN <action>; -- one with UPDATE one with DELETE
use NORTHWND

create database mergeEscuelita
CREATE TABLE StudentsC1(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);


INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)

CREATE TABLE StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);

select c1.StudentID, c1.StudentName, c1.StudentStatus
from 
StudentsC1 as c1
left join
StudentsC2 as c2
on c1.StudentID = c2.StudentID
where c2.StudentID is null

insert into StudentsC2
values (1, 'Axel romero', 02)

truncate table Studentsc2

--store procedure que agrega y actualiza los registros knuevos y registros modificados de la tabla c1 a student c2 utilizando consultas con left join y e inner join


create or alter procedure spu_carga_delta_s1_s2
--parametros 
as 
begin
--programacion del store procedure 
	begin transaction;
	begin try
	--ejecutar de forma exitosa
	--insertat nuevos refgistros de la tabla student a student 2
		INSERT INTO StudentsC2(StudentID, StudentName, StudentStatus)
		select c1.StudentID, c1.StudentName, c1.StudentStatus
		from 
		StudentsC1 as c1
		left join
		StudentsC2 as c2
		on c1.StudentID = c2.StudentID
		where c2.StudentID is null
		--se actualiza los registros de la tabla que han tenido algun cambio en la tabla source
		--y se cambian en la tabla target
		update c2
		set c2.studentName = c1.StudentName,
			c2.StudentStatus = c1.StudentSatus
		from 
		StudentsC1 as c1
		left join
		StudentsC2 as c2
		on c1.StudentID = c2.StudentID

		--- 
	end try
	begin catch
	rollback transaction;
	declare @mensajeError varchar(100);
	set @mensajeError = ERROR_MESSAGE();
	print @mensajeError;
	end catch
end

exec spu_carga_delta_s1_s2

select c1.StudentID, c1.StudentName, c1.StudentStatus
from 
StudentsC1 as c1
left join
StudentsC2 as c2
on c1.StudentID = c2.StudentID
where c2.StudentID is null


update StudentsC1
set StudentStatus = 0
where StudentID in (1,4,5)	

insert into StudentsC1
values (6, 'Monico hernandez', 0) ;



------------------------------------------------------------- SP -----------------------------------------------------
--Store procidios que agrega y actiliza los registros nuevos y registros modificados de la tabla StudentC1 a StudentC2 utilizando la funcion merge 

Create or alter procedure spu_carga_delta_s1_s2_merge
--parametros 
as 
begin
--programacion del store procedure 
	begin transaction;
	begin try
		MERGE INTO Studentsc2 AS TGT
		USING (
			select studentid, studentname, studentstatus from StudentsC1
		) AS SRC
		on(
		TGT.studentid = SRC.studentid
		)
		--Para actualizar
		WHEN MATCHED THEN 
		UPDATE
		SET TGT.studentname = SRC.studentname,
		TGT.studentstatus = SRC.studentstatus
		--Para insertar 
		WHEN NOT MATCHED THEN 
		INSERT (studentid, studentname, studentstatus)
		VALUES (SRC.studentid, SRC.studentname, SRC.studentstatus);

COMMIT TRANSACTION; 

   end try
   begin catch
   ROLLBACK TRANSACTION;
   DECLARE @mensajeError varchar(100)
   SET @mensajeError = ERROR_MESSAGE();
   Print @mensajeError;
   end catch;
END;
GO

truncate table studentsc2;

select * from StudentsC1
select * from StudentsC2

exec spu_carga_delta_s1_s2_merge

update StudentsC1 
set StudentName = 'Juana de Arco'
where StudentID = 2

select * from StudentsC2

create or alter spu_limpiar_tabla
@nombreTabla nvarchar(50)
AS 
BEGIN
	DECLARE @sql nvarchar(50)
	set @sql = 'truncate table' + @nombreTabla
	exec(@sql)