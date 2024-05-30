select * from paisvista;
drop database garden1;
SELECT * FROM oficina;
select * from oficina_direccion;
show tables;
use garden1;
-- 1 Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

select f.id,c.nombre from oficina as f 
join oficina_direccion as od on f.id = od.idOficina 
join ciudad as c on c.id = od.idCiudad; 

-- 2 Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

SELECT pv.ciudad,ot.telefono from oficina_direccion as od join oficina_telefono as ot
 on ot.idOficina = od.idOficina
join paisvista as pv on pv.idCiudad = od.idCiudad where pv.pais = "españa";

-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
-- jefe tiene un código de jefe igual a 7.

select em.nombre,concat(em.apellido1," ",em.apellido2)
as apellidos,em.email 
from empleado as em where idCargo = 1 ;

-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
-- empresa.

select car.nombre,em.nombre,concat(em.apellido1," ",em.apellido2)
as apellidos,em.email 
from empleado as em join cargo as car 
on car.id = em.idCargo where em.idJefe is null;

-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
-- empleados que no sean representantes de ventas.

select em.nombre,concat(em.apellido1," ",em.apellido2)
as apellidos,car.nombre
from empleado as em join cargo as car 
on car.id = em.idCargo where car.nombre != "vendedor";


-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.

select distinct cl.nombre from cliente as cl 
join  cliente_direccion as cd on cl.id = cd.idCliente 
join paisvista as pv on cd.idCiudad = pv.idCiudad where pv.pais = "españa" ;


-- 7.Devuelve un listado con los distintos estados por los que puede pasar un
-- pedido.

select * from estado;

-- 8. Devuelve un listado con el código de cliente de aquellos clientes que
-- realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
-- aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:

-- YEAR
select cl.id,cl.nombre from cliente as cl join pago as pg on cl.id = pg.idCliente where year(pg.fecha) = 2008; 

-- date_format
SELECT cl.id, cl.nombre 
FROM cliente AS cl 
JOIN pago AS pg ON cl.id = pg.idCliente 
WHERE DATE_FORMAT(pg.fecha, '%Y') = '2008';
-- solo
SELECT cl.id, cl.nombre 
FROM cliente AS cl 
JOIN pago AS pg ON cl.id = pg.idCliente 
WHERE pg.fecha BETWEEN '2008-01-01' AND '2008-12-31';


-- 9. Devuelve un listado con el código de pedido, código de cliente, fecha
-- esperada y fecha de entrega de los pedidos que no han sido entregados a
-- tiempo.

select p.id,cl.id,p.fechaEsperada,p.fechaEntrega from pedido as p 
join cliente as cl on p.idCliente = cl.id 
join estado as es on p.idEstado = es.id 
where p.fechaEsperada < p.fechaEntrega;

-- 10. Devuelve un listado con el código de pedido, código de cliente, fecha
-- esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
-- menos dos días antes de la fecha esperada.

-- CON ADDDATE
select p.id,cl.id,p.fechaEsperada,p.fechaEntrega from pedido as p 
join cliente as cl on p.idCliente = cl.id 
join estado as es on p.idEstado = es.id 
where p.fechaEntrega <= adddate(p.fechaEsperada, interval -2 day);

-- CON DATEDIFF
select p.id,cl.id,p.fechaEsperada,p.fechaEntrega from pedido as p 
join cliente as cl on p.idCliente = cl.id 
join estado as es on p.idEstado = es.id 
where datediff(p.fechaEsperada,p.fechaEntrega) >= 2;


-- con suma y resta

SELECT p.id, cl.id AS cliente_id, p.fechaEsperada, p.fechaEntrega
FROM pedido AS p 
JOIN cliente AS cl ON p.idCliente = cl.id 
JOIN estado AS es ON p.idEstado = es.id 
WHERE day(p.fechaEsperada) - day(p.fechaEntrega) >= 2 and month(p.fechaEsperada) - month(p.fechaEntrega) <= 1;

-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

select * from pedido p 
join estado as es on p.idEstado = es.id where 
es.nombre = "cancelado" and year(fechaPedido) = 2009;


-- 12 Devuelve un listado de todos los pedidos que han sido entregados en el
-- mes de enero de cualquier año.

select * from pedido 
where month(fechaEntrega) = 01;


-- 13. Devuelve un listado con todos los pagos que se realizaron en el
-- año 2008 mediante Paypal. Ordene el resultado de mayor a menor.


select * from pago as pg 
join tipo_pago as tp 
on pg.idTipo = tp.id where tp.nombre = "paypal" and year(fecha) = 2008;

-- 14. Devuelve un listado con todas las formas de pago que aparecen en la
-- tabla pago. Tenga en cuenta que no deben aparecer formas de pago
-- repetidas. 

select distinct tp.nombre from pago as pg 
join tipo_pago as tp 
on pg.idTipo = tp.id ;

/* 15. Devuelve un listado con todos los productos que pertenecen a la
gama Ornamentales y que tienen más de 100 unidades en stock. El listado
deberá estar ordenado por su precio de venta, mostrando en primer lugar
los de mayor precio. */



/*
16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
cuyo representante de ventas tenga el código de empleado 13 o 20.
*/

select em.id,em.nombre,pv.ciudad,cd.direccion from empleado as em 
join cliente as cl on cl.idEmpleado = em.id 
join cliente_direccion as cd on cd.idCliente = cl.id
join paisvista as pv on pv.idCiudad = cd.idCiudad where pv.ciudad = "madrid" and em.id = 13 and 20 ;

/*
CONSULTAS MULTITABLASS
*/

/*
1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
representante de ventas.
*/



select * from empleado;




select * from pago;