-- Procedimientos almacenados
-- Jair Almanza
-- 8/8/2022

--PA para TEscuela
use BDUniversidad 
go

--Listar
if OBJECT_ID('spListarEscuela') is not null
	drop proc spListarEscuela
go

create proc spListarEscuela
as 
begin
	select CodEscuela,Escuela,Facultad from TEscuela 
end
go

exec spListarEscuela
go

--Agregar
if OBJECT_ID('spAgregarEscuela') is not null
	drop proc spAgregarEscuela
go

create proc spAgregarEscuela
@CodEscuela char(3), @Escuela varchar(50), @Facultad varchar(50)
as 
begin
	-- CodEscuela no puede ser duplicado
	if not exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		-- Escuela no puede ser duplicado
			if not exists(select Escuela from TEscuela where Escuela = @Escuela)
				begin
					insert into TEscuela values(@CodEscuela,@Escuela,@Facultad)
					select CodError = 0, Mensaje='Se inserto correctamente escuela'
				end
			else select CodError = 1, Mensaje = 'Error: Escuela duplicada'
	else select CodError = 1, Mensaje = 'Error: CodEscuela duplicado'	

end
go

exec spAgregarEscuela 'E06','Medicina','Ciencias de la salud'
go

-- Actividad: Implementar Eliminar, Actualizar y Buscar
-- Presentado para el dia miercoles 10 de agosto por el AV

-- Eliminar
if OBJECT_ID('spEliminarEscuela') is not null
	drop proc spEliminarEscuela
go

create proc spEliminarEscuela
@CodEscuela char(3)
as begin
	--CodEscuela debe existir
	if exists(select CodEscuela from TEscuela where CodEscuela = @CodEscuela)
		begin
			delete from TEscuela where CodEscuela=@CodEscuela
			select CodError = 0, Mensaje = 'Se elimino la escuela de manera satisfactoria'
		end
	else select CodError = 1, Mensaje = 'Error: El CodEscuela no existe'
end
go

exec spEliminarEscuela @CodEscuela = 'E06';
go

select * from TEscuela

-- Actualizar 
if OBJECT_ID('spActualizarEscuela') is not null
	drop proc spActualizarEscuela
go
create proc spActualizarEscuela
@CodEscuela char(3), @Escuela varchar(50), @Facultad varchar(50)
as begin
	--CodEscuela debe existir
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			update TEscuela set Escuela = @Escuela, Facultad = @Facultad where CodEscuela = @CodEscuela
			select CodError = 0, Mensaje = 'Escuela actualizada correctamente'
		end
	else select CodError = 1, Mensaje = 'Error: El CodEscuela no existe'
end
go

exec spActualizarEscuela @CodEscuela = 'E04', @Escuela = 'Economia', @Facultad = 'CEAC';
go

select * from TEscuela

-- Buscar
if OBJECT_ID('spBuscarEscuela') is not null
	drop proc spBuscarEscuela
go
create proc spBuscarEscuela
@CodEscuela char(3)
as begin
	--CodEscuela debe existir
	if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
		begin
			select CodEscuela,Escuela,Facultad from TEscuela where CodEscuela=@CodEscuela
			select CodError = 0, Mensaje = 'Se encontro correctamente escuela'
		end
	else select CodError = 1, Mensaje = 'Error: CodEscuela no existe'
end
go

exec spBuscarEscuela @CodEscuela = 'E04';
go



--PA para TAlumno

-- Listar
if OBJECT_ID('spListarAlumno') is not null
	drop proc spListarAlumno
go

create proc spListarAlumno
as 
begin
	select CodEscuela,Apellido,Nombres,LugarNac,FechaNac from TAlumno
end
go

exec spListarAlumno
go

--Agregar
if OBJECT_ID('spAgregarAlumno') is not null
	drop proc spAgregarAlumno
go

create proc spAgregarAlumno
@CodAlumno char(5), @Apellido varchar(50), @Nombres varchar(50),@LugarNac varchar(50),@FechaNac datetime,@CodEscuela char(3)
as 
begin
	-- CodAlumno no puede ser duplicado
	if not exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		-- El CodEscuela debe existir
			if exists(select Escuela from TEscuela where CodEscuela = @CodEscuela)
					begin
						insert into TAlumno values(@CodAlumno,@Apellido,@Nombres,@LugarNac,@FechaNac,@CodEscuela)
						select CodError = 0, Mensaje='Se inserto correctamente el Alumno'
					end
			else select CodError = 1, Mensaje = 'Error: El CodEscuela no existe'
	else select CodError = 1, Mensaje = 'Error: El CodAlumno ya existe'	
end
go

exec spAgregarAlumno 'A0006','Palermo','Sofia','La Paz','2000-3-21 10:34:09 AM','E04'
go

-- delete from TAlumno where CodAlumno = 'A0006'



-- Eliminar
if OBJECT_ID('spEliminarAlumno') is not null
	drop proc spEliminarAlumno
go

create proc spEliminarAlumno
@CodAlumno char(5)
as begin
	--CodAlumno debe existir
	if exists(select CodAlumno from TAlumno where CodAlumno = @CodAlumno)
		begin
			delete from TAlumno where CodAlumno=@CodAlumno
			select CodError = 0, Mensaje = 'Se elimino el Alumno de manera satisfactoria'
		end
	else select CodError = 1, Mensaje = 'Error: El CodAlumno no existe'
end
go

exec spEliminarAlumno @CodAlumno = 'A0006';
go

Select * from TAlumno


-- Actualizar 
if OBJECT_ID('spActualizarAlumno') is not null
	drop proc spActualizarAlumno
go
create proc spActualizarAlumno
@CodAlumno char(5), @Apellido varchar(50), @Nombres varchar(50),@LugarNac varchar(50),@FechaNac datetime,@CodEscuela char(3)
as begin
	--CodAlumno debe existir
	if exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		--CodEscuela debe existir
		if exists(select CodEscuela from TEscuela where CodEscuela=@CodEscuela)
			begin
				update TAlumno set Apellido = @Apellido, Nombres = @Nombres, LugarNac=@LugarNac, FechaNac=@FechaNac, CodEscuela=@CodEscuela where CodAlumno = @CodAlumno
				select CodError = 0, Mensaje = 'Alumno actualizado correctamente'
			end
		else select CodError = 1, Mensaje = 'Error: El CodEscuela no existe'
	else select CodError = 1, Mensaje = 'Error: El CodAlumno no existe'
end
go

exec spActualizarAlumno @CodAlumno = 'A0001', @Apellido = 'Almanza', @Nombres = 'Jair', @LugarNac = 'Cusco',@FechaNac ='2001-7-25',@CodEscuela='E03';
go

select * from TAlumno

-- Buscar
if OBJECT_ID('spBuscarAlumno') is not null
	drop proc spBuscarAlumno
go
create proc spBuscarAlumno
@CodAlumno char(5)
as begin
	--CodAlumno debe existir
	if exists(select CodAlumno from TAlumno where CodAlumno=@CodAlumno)
		begin
			select CodAlumno,Apellido,Nombres,LugarNac,FechaNac,CodEscuela from TAlumno where CodAlumno=@CodAlumno
			select CodError = 0, Mensaje = 'Se encontro correctamente el alumno'
		end
	else select CodError = 1, Mensaje = 'Error: CodAlumno no existe'
end
go

exec spBuscarAlumno @CodAlumno = 'A0004';
go