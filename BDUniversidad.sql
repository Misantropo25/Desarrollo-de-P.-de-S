-- Base de datos ejemplo
-- Jair Almanza
-- 8/8/2022

use master
go

if DB_ID('BDUniversidad') is not null
	drop database BDUniversidad
go

create database BDUniversidad
go

use BDUniversidad
go

-- crear tablas
if OBJECT_ID('TEscuela') is not null
	drop table TEscuela 
	-- Siempre se dropea para evitar problemas
create table TEscuela 
(
	CodEscuela char(3) primary key, 
	Escuela varchar(50),
	Facultad varchar(50)
)
go

if OBJECT_ID('TAlumno') is not null
	drop table TAlumno
	-- Siempre se dropea para evitar problemas
go

create table TAlumno 
(
	CodAlumno char(5) primary key, 
	Apellido varchar(50),
	Nombres varchar(50),
	LugarNac varchar(50),
	FechaNac datetime,
	CodEscuela char(3),
	foreign key (CodEscuela) references TEscuela
)
go

-- Insercion de datos
insert into TEscuela values('E01','Sistemas','Ingenieria')
insert into TEscuela values('E02','Civil','Ingenieria')
insert into TEscuela values('E03','Industrial','Ingenieria')
insert into TEscuela values('E04','Ambiental','Ingenieria')
insert into TEscuela values('E05','Arquitectura','Ingenieria')
go

insert into TAlumno values('A0001','Almanza','Jair','Cusco','2001-7-25 10:34:09 AM','E01')
insert into TAlumno values('A0002','Arteaga','Kevin','Arequipa','1983-4-1 6:23:12 PM ','E02')
insert into TAlumno values('A0003','Barrio','John','Cusco','2003-1-13 5:21:23 AM','E01')
insert into TAlumno values('A0004','Garcia','Alan','Lima','1999-2-12 7:12:23 AM','E03')
insert into TAlumno values('A0005','Valdivia','Juan','Tacna','1998-8-28 9:32:12 AM','E04')
go






