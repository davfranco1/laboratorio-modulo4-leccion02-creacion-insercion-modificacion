-- EJERCICIO 1 -- Creación de la base de datos y tablas

create table clientes (
	id_cliente SERIAL primary key,
	nombre VARCHAR (100) not null,
	email VARCHAR (100) unique not null,
	direccion VARCHAR (300) not null,
	telefono INT unique not null,
	pais CHAR (20) not null
	
)

create table empleados (
	id_empleado SERIAL primary key,
	nombre VARCHAR (100) not null,
	cargo CHAR (50) not null,
	email VARCHAR (100) unique not null
	
)

create table proveedores (
	id_proveedor SERIAL primary key,
	nombre VARCHAR (100) not null,
	contacto VARCHAR (100) not null,
	telefono INT unique not null,
	direccion VARCHAR (300) not null
	
)

create table envios (
	id_envio SERIAL primary key,
	id_cliente INT not null,
	foreign key (id_cliente)
		references clientes(id_cliente)
		on update cascade
		on delete restrict,
	id_empleado INT not null,
	foreign key (id_empleado)
		references empleados(id_empleado)
		on update cascade
		on delete restrict,
	id_proveedor INT not null,
	foreign key (id_proveedor)
		references proveedores(id_proveedor)
		on update cascade
		on delete restrict,
	fecha_envio DATE not null,
	estado CHAR (10) not null,
	total INT not null
)

create table detalle_de_envios (
	id_detalle SERIAL primary key,
	id_envio INT not null,
	foreign key (id_envio)
		references envios(id_envio)
		on update cascade
		on delete restrict,	
	producto CHAR (50),
	cantidad INT,
	precio_unitario INT
)

create table regiones (
	id_region SERIAL primary key,
	nombre VARCHAR (100),
	pais CHAR (50)
)

-- EJERCICIO 2 -- Inserción de Datos

-- 1. Inserta al menos **10 clientes** en la tabla `Clientes`.
insert into clientes (nombre, email, direccion, telefono, pais) -- id no lo incluyo porque es serial, se genera automático.
values ('lola','loli9@gmail.com','San Francisco','173389589','ES')


-- 2. Inserta al menos **5 empleados** en la tabla `Empleados`.
insert into empleados (nombre, cargo, email)
values 
('jorge', 'repartidor', 'jorge@logistica.com'),
('maria', 'secretaria', 'maria@logistica.com'),
('jorge', 'repartidor', 'jorge2@logistica.com'),
('david', 'administrativo', 'david@logistica.com'),
('pablo', 'director', 'pablo@logistica.com');


-- 3. Inserta al menos **3 proveedores** en la tabla `Proveedores`.
insert into proveedores (nombre, contacto, telefono, direccion)
values 
('xys', 'jorge', '728982091','Madrid'),
('lyx', 'gabriela', '988982091','Córdoba'),
('swe', 'maria', '258982091','Palencia');

select * from empleados

-- 4. Inserta al menos **8 envíos** en la tabla `Envíos`, asignando envíos a los clientes, empleados y proveedores registrados.
insert into envios (id_cliente, id_empleado, id_proveedor, fecha_envio, estado, total)
values
(8,1,2,'2023-10-30','prep',20),
(8,2,3,'2023-10-30','enviado',10),
(3,3,1,'2023-10-30','recibido',40),
(4,4,2,'2023-10-30','prep',20),
(5,5,3,'2023-10-30','enviado',10),
(6,1,1,'2023-10-30','recibido',60),
(10,2,2,'2023-10-30','enviado',70),
(8,3,3,'2023-10-30','prep',20);

--alter table envios
--add column id_proveedor INT not null;

--alter table envios
--add constraint prueba foreign key (id_proveedor)
--		references proveedores(id_proveedor)
--		on update cascade
--		on delete restrict;


-- 5. Inserta los detalles correspondientes en la tabla `Detalle de Envíos`, asegurando que las cantidades y precios unitarios sean consistentes con los productos y los envíos.
insert into detalle_de_envios (id_envio, producto, cantidad, precio_unitario)
values
(25,'calcetines',1,2),
(26,'gorro',1,2),
(27,'calcetines',1,2),
(28,'gorro',1,2),
(29,'calcetines 2',1,5),
(30,'gorro 2',1,5),
(31,'calcetines 3',2,10),
(32,'gorro',1,5);

select * from envios

-- 6. Inserta al menos **5 regiones** en la tabla `Regiones`.
insert into regiones (nombre, pais)
values
('MAD','ES'),
('PAR','FR'),
('MIL','IT'),
('BCN','ES'),
('ROM','IT');


-- EJERCICIO 3 -- Modificación y Actualización de Datos

-- 1. Actualizar el Estado de un Envío. Actualiza el estado del envío con `id_envio = 3` a "Entregado".
update envios 
set estado = 'Entregado'
where id_envio = 27;  

-- 2. Modificar el Cargo de un Empleado. Cambia el cargo del empleado con `id_empleado = 5` a "Director de Datos".
update empleados
set cargo = 'Director de Datos'
where id_empleado = 5; 

-- 3. Incrementar el Precio Unitario de un Producto. Incrementa en un 10% el precio unitario del producto "Producto A" en la tabla `Detalle_Envíos`.
update detalle_de_envios
set precio_unitario = 2.2
where id_detalle = 9;

-- 4. Actualizar la Dirección de un Cliente. Modifica la dirección del cliente con `id_cliente = 2` a "Nueva Calle B, 123".
update clientes
set direccion = 'Nueva Calle B, 123'
where id_cliente = 2;

-- 5. Cambiar el Proveedor de un Envío. Cambia el proveedor del envío con `id_envio = 4` al proveedor con `id_proveedor = 3`.
update envios
set id_proveedor = 3
where id_envio = 29

select * from detalle_de_envios

-- 6. Actualizar la Cantidad de un Producto en un Envío. Modifica la cantidad del producto "Producto C" en el envío con `id_envio = 2` a 5 unidades.
update detalle_de_envios
set cantidad = 5
where id_detalle = 11

-- 7. Actualizar el Total de un Envío. Incrementa el total del envío con `id_envio = 5` en 50 unidades monetarias.
update envios
set total = 50
where id_envio = 31

select * from envios

-- 8. Modificar el Contacto de un Proveedor. Cambia el contacto del proveedor con `id_proveedor = 2` a "Nuevo Contacto 2".
update proveedores
set contacto = 'Nuevo contacto 2'
where id_proveedor = 2

-- 9. Cambiar el País de un Cliente. Actualiza el país del cliente con `id_cliente = 6` a "Portugal".
update clientes
set pais = 'Portugal'
where id_cliente = 6

-- 10. Actualizar la Fecha de un Envío. Modifica la fecha del envío con `id_envio = 7` a "2024-08-10".
update envios
set fecha_envio = '2024-08-10'
where id_envio = 29

select * from envios

-- EJERCICIO 4 -- Eliminación de datos

-- 1. Añadir una Columna. Añade una columna `fecha_nacimiento` de tipo `DATE` a la tabla `Clientes`.
alter table clientes
add column fecha_nacimiento date;

-- 2. Añadir una Columna. Añade una columna `codigo_postal` de tipo `VARCHAR(10)` a la tabla `Proveedores`.
alter table proveedores 
add column codigo_postal varchar(100);

-- 3. Eliminar una Columna. Elimina la columna `contacto` de la tabla `Proveedores`.
alter table proveedores
drop column contacto;

-- 4. Eliminar una Columna. Elimina la columna `pais` de la tabla `Regiones`.
alter table regiones
drop column pais;

-- 5. Modificar el Tipo de Dato de una Columna. Modifica el tipo de dato de la columna `telefono` en la tabla `Clientes` a `VARCHAR(15)`.
alter table clientes
alter column telefono type varchar(100);

-- 6. Modificar el Tipo de Dato de una Columna. Modifica el tipo de dato de la columna `total` en la tabla `Envíos` a `NUMERIC(12, 2)`.
alter table envios
alter column total type numeric(12,2);

-- 7. Añadir una Columna. Añade una columna `fecha_contrato` de tipo `DATE` a la tabla `Empleados`.
alter table empleados 
add column fecha_contrato date;

-- 8. Eliminar una Columna. Elimina la columna `estado` de la tabla `Envíos`.
alter table envios
drop column estado;

-- 9. Modificar el Nombre de una Columna. Modifica el nombre de la columna `nombre` en la tabla `Empleados` a `nombre_completo`.
alter table empleados
rename column nombre to nombre_completo;


-- EJERCICIO 5
-- 1. Listar todos los clientes que viven en España.
select * from clientes
where pais = 'ES'

-- 2. Obtener todos los envíos realizados por un empleado específico.
select * from envios
where id_empleado = 3

-- 3. Listar todos los productos incluidos en un envío específico.
select * from detalle_de_envios
where id_envio = 29

-- 4. Encontrar todos los proveedores con un teléfono específico.
select * from proveedores
where telefono = 258982091

-- 5. Listar los empleados que tienen un cargo de "Supervisor de Envíos".
select * from empleados
where cargo = 'Supervisor de Envíos'

-- 6. Obtener todos los envíos que fueron realizados por el cliente con id_cliente = 5.
select * from envios
where id_cliente = 5

-- 7. Listar todas las regiones con su nombre y país.
select * from regiones
-- No se puede listar el país porque se ha eliminado en el ejercicio 4.4.

-- 8. Mostrar todos los productos cuyo precio unitario sea mayor que 50.
select * from detalle_de_envios
where precio_unitario > 50;

-- 9. Obtener todos los envíos realizados el 2024-08-05.
select * from envios
where fecha_envio = '2024-08-05';

-- 10. Listar todos los clientes que tienen un número de teléfono que comienza con "6003".
select * from clientes
where telefono like '6003%'; --starts with--
