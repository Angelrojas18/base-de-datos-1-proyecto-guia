create database PRACTICA3BD1;
GO

USE PRACTICA3BD1;
GO

CREATE TABLE _clientes(
Idclientes int primary key,
nombre varchar(150),
telefono varchar(20)
);

CREATE TABLE _empleados(
IdEmpleado int primary key,
nombre varchar(150),
cargo  varchar(100),
telefono varchar(20)
);

CREATE TABLE _pedidos(
IDpedido int primary key,
estado varchar(100), 
fecha date,
Idclientes int foreign key references clientes(Idclientes)
);

CREATE TABLE _platos(
 idproducto int primary key,
nombre varchar(150),
categoria  varchar(100),
disponibilidad  varchar(100)

);
CREATE TABLE _mesas(
IDmesa int primary key,
capacidad int,
estado varchar(15),
numero int
);


 CREATE TABLE _detallepedido(
cantidad int,
precio decimal(10,2),
subtotal decimal(10,2),
idproducto int foreign key references platos(idproducto),
IDpedido int foreign key references pedidos(IDpedido),
 idmesa int foreign key references mesas(IDmesa)
);


insert into clientes values (1,'ANGEL','809-531-4287');

insert into empleados values (2, 'pedro','camarero','809-555-0102');

insert into pedidos values (7,'disponible','2026-3-17',1);

insert into platos values (5,'PIZZA','COMIDA', 'AGOTADO');

insert into mesas values (8, 25 ,'DISPONIBLE', 3);

insert into detallepedido values (4,50.7,6.99,5,7,8);


SELECT 
c.nombre AS cliente,
p.fecha AS fecha,
D.cantidad AS cantidad,
D.precio AS precio
from clientes c
inner join pedidos p on c.idclientes = p.idclientes
inner join detallepedido d on p.IDpedido = D.IDpedido;

SELECT 
 c.nombre AS Clientes, 
p.IDpedido AS pedidos, 
d.cantidad AS Cantidad, 
d.precio AS Precio
FROM clientes c
LEFT JOIN pedidos p ON c.Idclientes = p.Idclientes
LEFT JOIN detallepedido d ON p.IDpedido = d.IDpedido;

go
create view _cliente_pedidos AS
SELECT 
c.nombre AS cliente,
p.fecha AS fecha,
D.cantidad AS cantidad,
D.precio AS precio
from clientes c
inner join pedidos p on c.idclientes = p.idclientes
inner join detallepedido d on p.IDpedido = D.IDpedido;

go
 create view _pedido_detalle AS 
 SELECT 
 c.nombre AS Clientes, 
p.IDpedido AS pedidos, 
d.cantidad AS Cantidad, 
d.precio AS Precio
FROM clientes c
LEFT JOIN pedidos p ON c.Idclientes = p.Idclientes
LEFT JOIN detallepedido d ON p.IDpedido = d.IDpedido;

GO

select Idclientes, count(IDpedido) AS cantidad_de_pedidos
from pedidos
group by Idclientes;

go
create view cantidadpedidos_clientes
AS
select Idclientes, count(IDpedido) AS cantidadpedidos
from pedidos
group by Idclientes;
go

CREATE PROCEDURE insertarcliente
@idclientes int,
@nombre varchar(150),
@telefono varchar(100)
AS
BEGIN

INSERT INTO clientes(Idclientes,nombre,telefono)
VALUES(@idclientes,@nombre,@telefono);

SELECT * FROM clientes
WHERE Idclientes = @idclientes;

END
go

exec insertarcliente 1,'juan perez', '8095551234';
go

CREATE PROCEDURE Actualizarcliente
@idclientes int,
@telefono varchar(25),
@TotalRegistros INT OUTPUT
AS
BEGIN

UPDATE clientes
SET telefono = @telefono
WHERE idclientes = @idclientes;

SELECT @TotalRegistros = COUNT(*)
FROM clientes;

END
go
create table historial(
idclientes int,
nombre varchar(150),
telefono varchar(20),
fechaCambio datetime


);
go

CREATE TRIGGEr historial
ON clientes
AFTER UPDATE
AS
BEGIN

INSERT INTO historial(idclientes,nombre,fechaCambio,telefono)
SELECT idclientes,nombre,telefono, GETDATE()
FROM inserted;

END
go


CREATE FUNCTION candidasderegistrosdetabla(@nombre varchar(100), @totalderegistros int)
RETURNS @resultado TABLE(
nombretabla varchar(20),
totalderegistros int
)
AS
BEGIN
insert into @resultado
select 'clientes' , count(*) from _clientes;

insert into @resultado
select 'pedidos' , count(*) from _pedidos;

insert into @resultado
select 'empleados' , count(*) from _empleados

insert into @resultado
select 'platos' , count(*) from _platos;

insert into @resultado
select 'mesas' , count(*) from _mesas;

insert into @resultado
select 'detallepedidos' , count(*) from _detallepedido;

RETURN
END
go

CREATE FUNCTION multiplicacion(@numero1 int, @numero2 int)
RETURNS int
AS
BEGIN

DECLARE @Resultado int

set  @Resultado = @numero1 * @numero2

RETURN @Resultado

END
go

select dbo.multiplicacion(3, 6) as resultado;
go

select * from candidasderegistrosdetabla();

go