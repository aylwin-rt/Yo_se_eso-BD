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

 CREATE TABLE Pregunta(
	idPregunta INT IDENTITY(1,1) NOT NULL,
	Pregunta VARCHAR(200) NOT NULL,
	idImagen VARCHAR(MAX) NULL,
	idUsuario VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Pregunta PRIMARY KEY (idPregunta)
 )
 GO

 CREATE TABLE Respuesta(
	idRespuesta INT IDENTITY(1,1) NOT NULL,
	Respuesta VARCHAR (200) NOT NULL,
	IdImagen VARCHAR(MAX) NULL,
	idUsuario VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Respuesta PRIMARY KEY (idRespuesta)
 )
 GO

 CREATE TABLE Usuario(	
	idUsuario VARCHAR(50) NOT NULL,
	nombres VARCHAR(100) NOT NULL,
	apellidos VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	idPregunta INT NULL,
	idRespuesta INT NOT NULL,
	CONSTRAINT PK_Usuario PRIMARY KEY (idUsuario)
)
GO


 CREATE TABLE UsuarioPregunta(
	idUsuario VARCHAR(50) NOT NULL,
	idPregunta INT NOT NULL,		
	CONSTRAINT PK_UsuarioPregunta PRIMARY KEY (idUsuario,idPregunta),
	CONSTRAINT FK_UsuarioPregunta_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario (idUsuario),
	CONSTRAINT FK_UsuarioPregunta_Pregunta FOREIGN KEY (idPregunta) REFERENCES Pregunta (idPregunta)
)
 GO

  CREATE TABLE UsuarioRespuesta(
	idUsuario VARCHAR(50) NOT NULL,
	idRespuesta INT NOT NULL,		
	CONSTRAINT PK_UsuarioRespuesta PRIMARY KEY (idUsuario,idRespuesta),
	CONSTRAINT FK_UsuarioRespuesta_Usuario FOREIGN KEY (idUsuario) REFERENCES Usuario (idUsuario),
	CONSTRAINT FK_UsuarioRespuesta_Pregunta FOREIGN KEY (idRespuesta) REFERENCES Respuesta (idRespuesta)
)
 GO

  
--INSERT INTO Usuario(IdUsuario,nombres,apellidos,email) VALUES ('aylwin100','Aylwin Edithson','Rivera Trujillo','aylwin.rt@gmail.com')
--INSERT INTO Usuario(IdUsuario,nombres,apellidos,email) VALUES ('LbErT','Albert Alejandro','Rivera Trujillo','chefsito1999@gmail.com')
--INSERT INTO Usuario(IdUsuario,nombres,apellidos,email) VALUES ('Dríviliz','Adrian Renato','Rivera Trujillo','ema.renato@gmail.com')
--INSERT INTO Usuario(IdUsuario,nombres,apellidos,email) VALUES ('Tu_Grinkita','Betsi Analy','Llagenta Bernal','tu_llaguenta@gmail.com')


--INSERT INTO Pregunta (Pregunta) VALUES ('5+5')

 -- CREATE TABLE Foto(
	--idFoto VARCHAR(50) NOT NULL,
	--Foto VARCHAR(MAX),
	--CONSTRAINT PK_Foto PRIMARY KEY (idFoto)
 --)
-- GO

--SELECT * FROM Usuario
--SELECT * FROM Pregunta