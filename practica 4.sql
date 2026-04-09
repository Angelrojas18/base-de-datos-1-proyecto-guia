use RESTAURANTEBD;
go

create role DB_Administrador;
create role Encargado_de_Caja;
create role Auditor;
go

grant select,insert,update,delete on schema:: dbo to DB_Administrador;
grant select on schema:: dbo to Auditor;
grant select on Clientes to Encargado_de_Caja;
go

create user Angel for login Angellogin;
create user maria for login marialogin;
create user juan for login Juanlogin;
create user manuel for login manuellogin;
create user marcos for login marcoslogin;
create user pedro for login pedrologin;
go

alter role DB_Administrador add member Angel;
alter role DB_Administrador add member maria;

alter role auditor add member juan;
alter role auditor add member manuel;

alter role Encargado_de_Caja ADD member marcos;
alter role Encargado_de_Caja ADD member pedro;
go

grant select,insert,update,delete on _clientes to DB_Administrador;
grant select,insert,update,delete on _pedidos to DB_Administrador;
grant select,insert,update,delete on _platos to DB_Administrador;
go

grant select,delete on _clientes to Angel;

grant alter any user to maria;

grant select on _clientes to juan;

grant select,insert on _pedido to marcos;

--permiso a lectura al procedimiento insertar clientes
grant select  on object:: insertarcliente TO DB_Administrador;
--permiso a ejecucion de fundio de cantidad de registro de una tabla
grant execute on object:: candidasderegistrosdetabla to DB_Administrador;
go

use master;
go

create login Angellogin 
with password = 'Angel123';
create login marialogin 
with password = 'maria123';
create login Juanlogin 
with password = 'juan123';
create login manuellogin 
with password = 'manuel123';
create login marcoslogin 
with password = 'marcos123';
create login pedrologin 
with password = 'pedro123';
go

SET LANGUAGE Spanish;
GO