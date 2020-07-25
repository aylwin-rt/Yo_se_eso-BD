SET NOCOUNT ON
GO

USE master
GO

IF EXISTS (SELECT * FROM sysdatabases WHERE NAME='YoSeEso')
		DROP DATABASE YoSeEso
GO

CREATE DATABASE YoSeEso
GO

USE YoSeEso
GO

 CREATE TABLE Universidad(
	idUniversidad INT IDENTITY(1,1) NOT NULL,
	nombreUniversidad VARCHAR(200) NOT NULL,
	distrito VARCHAR(150) NULL,
	ciudad VARCHAR(150) NULL,
	ruc CHAR(11) NULL,
	pais VARCHAR(50) NULL,
	CONSTRAINT PK_Universidad PRIMARY KEY (idUniversidad)
 )
 GO


 CREATE TABLE Usuario(	
	idUsuario INT IDENTITY(1,1) NOT NULL,
	nombres VARCHAR(100) NOT NULL,
	apellidos VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	contrasenya VARCHAR(50) NOT NULL,
	idUniversidad INT NULL,
	rol VARCHAR(20) NULL,
	CONSTRAINT PK_Usuario PRIMARY KEY (idUsuario),
	CONSTRAINT FK_Usuario FOREIGN KEY (idUniversidad) REFERENCES Universidad (idUniversidad)
)
GO

 CREATE TABLE Pregunta(
	idPregunta INT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR(200) NULL,
	fecha DATETIME,
	tema VARCHAR(50),
	idUsuario INT NOT NULL,
	rutaImagen VARCHAR(150) NULL,
	CONSTRAINT PK_Pregunta PRIMARY KEY (idPregunta),
	CONSTRAINT FK_Pregunta FOREIGN KEY (idUsuario) REFERENCES Usuario (idUsuario)
 )
 GO

 CREATE TABLE Respuesta(
	idRespuesta INT IDENTITY(1,1) NOT NULL,
	nombre VARCHAR (200) NULL,
	fecha DATETIME,
	idUsuario INT NOT NULL,
	rutaImagen VARCHAR(150) NULL,
	idPregunta INT NULL,
	CONSTRAINT PK_Respuesta PRIMARY KEY (idRespuesta),
	CONSTRAINT FK_Respuesta_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario (idUsuario),
	CONSTRAINT FK_Respuesta_Pregunta FOREIGN KEY (idPregunta) REFERENCES Pregunta (idPregunta)
 )
 GO
   
INSERT INTO Usuario(nombres,apellidos,email,contrasenya) VALUES ('Aylwin Edithson','Rivera Trujillo','aylwin.rt@gmail.com','1234')
INSERT INTO Usuario(nombres,apellidos,email,contrasenya) VALUES ('Albert Alejandro','Rivera Trujillo','chefsito1999@gmail.com','12345')
INSERT INTO Usuario(nombres,apellidos,email,contrasenya) VALUES ('Adrian Renato','Rivera Trujillo','ema.renato@gmail.com','4321')
INSERT INTO Usuario(nombres,apellidos,email,contrasenya) VALUES ('Betsi Analy','Llagenta Bernal','tu_llaguenta@gmail.com','111')



INSERT INTO Pregunta(nombre,fecha,tema,idUsuario,rutaImagen) VALUES ('5+5 esta operación se realiza sumando',GETDATE(),'Suma',1,'Images/Image1.jpg')
INSERT INTO Pregunta(nombre,fecha,tema,idUsuario,rutaImagen) VALUES ('100-1 Esta operación se realiza restando',GETDATE(),'Resta','Images/Image2.jpg')
INSERT INTO Pregunta(nombre,fecha,tema,idUsuario,rutaImagen) VALUES ('6x6 Esta operación se realiza multiplicando',GETDATE(),'Multiplicación',1,'Images/Image3v')
INSERT INTO Pregunta(nombre,fecha,tema,idUsuario,rutaImagen) VALUES ('50/10 Esta operación se realiza dividiendo',GETDATE(),'División',1,'Images/Image4.jpg')

--SELECT * FROM PREGUNTA


GO

CREATE PROCEDURE [dbo].[spAutenticarCredenciales]
@email varchar(100),
@contrasenya varchar(100),
@Resultado varchar(100) output
as
DECLARE @Id varchar(100)
IF EXISTS(SELECT TOP 1 u.idUsuario FROM usuario u WHERE u.email=@email AND u.contrasenya=@contrasenya)
	BEGIN
		set @Id = (SELECT TOP 1 u.idUsuario FROM usuario u WHERE u.email=@email AND u.contrasenya=@contrasenya)
		Select @Resultado=CONVERT(varchar(10), @Id)
		--SELECT CONVERT(VARCHAR(10),@Id)
	END
ELSE
	BEGIN
		SELECT @Resultado=''
	END
GO

--SELECT TOP 1 idUsuario FROM usuario u WHERE u.email='aylwin.rt@gmail.com' AND u.contrasenya='1234'
--EXECUTE [spAutenticarCredenciales] 'aylwin.rt@gmail.com','1234'
--SELECT * FROM Usuario

CREATE PROCEDURE [dbo].[spObtenerDatosPersonales]
@idUsuario VARCHAR(50)
as
 select idUsuario,nombres,apellidos,email,contrasenya,idUniversidad,rol from Usuario
 where idUsuario = @idUsuario
GO

--EXECUTE[spObtenerDatosPersonales] '1'

CREATE PROCEDURE [dbo].[spGrabarUsuario]
@nombres varchar(100),
@apellidos varchar(100),
@email varchar(100),
@contrasenya varchar(50)
--,
--@idUniversidad int,
--@rol varchar(20)
as
 insert into Usuario(nombres,apellidos,email,contrasenya) values(@nombres,@apellidos,@email,@contrasenya)
GO

--EXECUTE [spGrabarUsuario] 'Jorge Arturo','Perez Ortiz','japo1202@hotmail.com','JAF'

CREATE PROCEDURE [dbo].[spObtenerPreguntas]
as
 select idPregunta,nombre,fecha,tema,(Usuario.nombres+' '+Usuario.apellidos) as nombreUsuario,rutaImagen from Pregunta inner join Usuario ON Pregunta.idUsuario=Usuario.idUsuario
GO

CREATE procedure [dbo].[spObtenerPreguntasPorCodigo]
@idUsuario int
as
 select idPregunta,nombre,fecha,tema,(Usuario.nombres+' '+Usuario.apellidos) as nombreUsuario,rutaImagen from Pregunta inner join Usuario ON Pregunta.idUsuario=Usuario.idUsuario
 where Usuario.idUsuario= @idUsuario
GO

create procedure [dbo].[spEliminarPregunta]
@idPregunta int
as
 delete from Pregunta
 where idPregunta = @idPregunta

GO

CREATE procedure [dbo].[spActualizarPregunta]
@idPregunta int,
@nombre varchar(200),
@tema varchar(50),
@idUsuario int,
@rutaImagen varchar(150)
as
 update Pregunta set nombre = @nombre,
				  tema = @tema,
				  idUsuario= @idUsuario,
				  rutaImagen= @rutaImagen
				  --rutaImagen = ''
				  where idPregunta = @idPregunta

GO

--EXECUTE [dbo].[spActualizarPregunta] 5,'20+20 esta operación se realiza sumando','Suma','1',null

CREATE procedure [dbo].[spGrabarPregunta]
@nombre varchar(200),
@tema varchar(50),
@idUsuario int,
@rutaImagen varchar(150)
as
 insert into Pregunta(nombre,fecha,tema,idUsuario,rutaImagen) values(@nombre,GETDATE(),@tema,@idUsuario,@rutaImagen)
 
 EXECUTE [dbo].[spGrabarPregunta] '2x10','Multiplicación','2',null

--SELECT * FROM Usuario
--SELECT * FROM Pregunta
--SELECT * FROM Respuesta
--SELECT * FROM UsuarioPregunta
