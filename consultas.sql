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

select cl.nombre as cliente,em.nombre as representanteVentas,
concat(em.apellido1," ",em.apellido2)as apellidosRepresenVent 
from cliente as cl 
join empleado as em on cl.idEmpleado = em.id join cargo as cg on cg.id = em.idCargo
where cg.nombre = "vendedor";

/*
2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
nombre de sus representantes de ventas.
*/

select cl.nombre as cliente,em.nombre as representante,pg.total,pg.fecha from cliente as cl 
join empleado as em on em.id = cl.idEmpleado 
join pago as pg on pg.idCliente = cl.id
join cargo as cg on cg.id = em.idCargo where cg.nombre = "vendedor" ; 

/*
3. Muestra el nombre de los clientes que no hayan realizado pagos junto con
el nombre de sus representantes de ventas.
*/

select cl.nombre as cliente,em.nombre as representante,pg.total,pg.fecha from cliente as cl 
 join empleado as em on em.id = cl.idEmpleado 
left join pago as pg on pg.idCliente = cl.id
left join cargo as cg on cg.id = em.idCargo where cg.nombre = "vendedor" and total is null ; 


/*
4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
representantes junto con la ciudad de la oficina a la que pertenece el
representante.
*/

select distinct cl.id,cl.nombre as cliente,em.nombre as representante,ofi.nombre,pv.ciudad from cliente as cl 
join empleado as em on em.id = cl.idEmpleado 
join pago as pg on pg.idCliente = cl.id
join cargo as cg on cg.id = em.idCargo 
join cliente_direccion as cd on cd.idCliente = cl.id 
join paisvista as pv on pv.idCiudad = cd.idCiudad
join oficina as ofi on em.idOficina = ofi.id
where cg.nombre = "vendedor" ; 
/*
5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
de sus representantes junto con la ciudad de la oficina a la que pertenece el
representante.
*/
select distinct cl.id,cl.nombre as cliente,em.nombre as representante,ofi.nombre,pv.ciudad from cliente as cl 
join empleado as em on em.id = cl.idEmpleado 
left join pago as pg on pg.idCliente = cl.id
left join cargo as cg on cg.id = em.idCargo 
join cliente_direccion as cd on cd.idCliente = cl.id 
join paisvista as pv on pv.idCiudad = cd.idCiudad
join oficina as ofi on em.idOficina = ofi.id
where cg.nombre = "vendedor" and total is null; 



/*
6. Lista la dirección de las oficinas que tengan clientes en colombia.
*/

select distinct od.direccion,pv.pais from oficina_direccion as od 
join oficina as ofi on ofi.id = od.idOficina 
join paisvista as pv on pv.idCiudad = od.idCiudad
join cliente_direccion as cd on cd.idCiudad = pv.idCiudad 
where pv.pais = "colombia";

/*
7. Devuelve el nombre de los clientes y el nombre de sus representantes junto
con la ciudad de la oficina a la que pertenece el representante.
*/

select distinct cl.nombre as cliente,em.nombre as representante,pv.ciudad from cliente as cl 
join empleado as em on em.id = cl.idEmpleado 
join pago as pg on pg.idCliente = cl.id
join cargo as cg on cg.id = em.idCargo 
join cliente_direccion as cd on cd.idCliente = cl.id 
join paisvista as pv on pv.idCiudad = cd.idCiudad
join oficina as ofi on em.idOficina = ofi.id
where cg.nombre = "vendedor"; 


/*
8. Devuelve un listado con el nombre de los empleados junto con el nombre
de sus jefes.

*/

select em.nombre,em2.idJefe,em2.nombre from empleado as em 
join empleado as em2
on em.idJefe = em2.id;

/*
9. Devuelve un listado que muestre el nombre de cada empleados, el nombre
de su jefe y el nombre del jefe de sus jefe.
*/

select em.nombre as empleado,em2.idJefe,em2.nombre as jefe, em3.idJefe,em3.nombre
as jefejefe from empleado as em 
join empleado as em2
on em.idJefe = em2.id
join empleado as em3
on em2.idJefe = em3.id;


/*
10. Devuelve el nombre de los clientes a los que no se les ha entregado a
tiempo un pedido.
*/

select * from cliente as cl 
join pedido as pd on pd.idCliente = cl.id where 
date(pd.fechaEntrega) > date(pd.fechaEsperada);


/*
11. Devuelve un listado de las diferentes gamas de producto que ha comprado
cada cliente.
*/
select distinct gp.descripcion as gamas from detalle_pedido as dp 
join pedido as p on dp.idPedido = p.id 
join producto as prod on dp.idProducto = prod.id 
join gama_producto as gp on gp.id = prod.idGama
join cliente as cl on cl.id = p.idCliente;


/*
Consultas multitabla (Composición externa)
*/


/*
1. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago.
*/
select cl.nombre as cliente
from cliente as cl 
left join pago as pg on pg.idCliente = cl.id where total is null; 

/*
2. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pedido.
*/

select cl.nombre from pedido as pd 
right join cliente as cl on cl.id = pd.idCliente where pd.id is null;


/*
3. Devuelve un listado que muestre los clientes que no han realizado ningún
pago y los que no han realizado ningún pedido.
*/
select cl.nombre as clienteSinPedido,cl2.nombre as cliSinPago
from cliente as cl 
join cliente as cl2 on cl.id = cl2.id
left join pago as pg on pg.idCliente = cl2.id 
left join pedido as pd on pd.idCliente = cl.id where pg.total is null and pd.id is null; 


/*
4. Devuelve un listado que muestre solamente los empleados que no tienen
una oficina asociada.
*/

Select nombre,concat(apellido1," ",apellido2) as apellidos from empleado where idOficina is null;

/*
5. Devuelve un listado que muestre solamente los empleados que no tienen un
cliente asociado.
*/

select em.nombre from empleado as em 
left join cliente as cl on em.id = cl.idEmpleado
where cl.id is null;

/*
6. Devuelve un listado que muestre solamente los empleados que no tienen un
cliente asociado junto con los datos de la oficina donde trabajan.
*/

select em.nombre from empleado as em 
left join cliente as cl on em.id = cl.idEmpleado 
join oficina_direccion as od 
on od.idOficina = em.idOficina where cl.id is null;

/*
7. Devuelve un listado que muestre los empleados que no tienen una oficina
asociada y los que no tienen un cliente asociado.
*/

select em.nombre,ofi.id,cl.id from empleado as em 
left join oficina as ofi on ofi.id = em.idOficina
left join empleado as em2 on em2.idOficina = ofi.id
left join cliente as cl on cl.idEmpleado = em2.id 
where  cl.id is null or em2.idOficina is null;

/*
8. Devuelve un listado de los productos que nunca han aparecido en un
pedido.
*/

select p.id,p.descripcion as producto from producto as p 
left join detalle_pedido as dp on dp.idProducto = p.id
where dp.idProducto is null; 


/*
9. Devuelve un listado de los productos que nunca han aparecido en un
pedido. El resultado debe mostrar el nombre, la descripción y la imagen del
producto.
*/

select p.id,p.nombre as nombre,p.descripcion,gp.imagen from producto as p 
left join detalle_pedido as dp on dp.idProducto = p.id
join gama_producto as gp on p.idGama = gp.id
where dp.idProducto is null; 

/*
10. Devuelve las oficinas donde no trabajan ninguno de los empleados que
hayan sido los representantes de ventas de algún cliente que haya realizado
la compra de algún producto de la gama Frutas.
*/

select * from oficina where id not in(
select ofi.id from oficina as ofi 
join empleado as em on em.idOficina = ofi.id
join cargo as cg on cg.id = em.idCargo
join cliente as cl on cl.idEmpleado = em.id
join pedido as p on p.idCliente = cl.id
join detalle_pedido as dp on dp.idPedido = p.id
join producto as prod on prod.id = dp.idProducto
join gama_producto as gp on prod.idGama = gp.id
where cg.nombre = "vendedor" and gp.descripcion = "Frutas");

/*
11. Devuelve un listado con los clientes que han realizado algún pedido pero no
han realizado ningún pago.
*/
select  cl2.nombre as cliSinPago
from cliente as cl 
join cliente as cl2 on cl.id = cl2.id
left join pago as pg on pg.idCliente = cl2.id 
left join pedido as pd on pd.idCliente = cl.id where pg.total is null; 

/*
12. Devuelve un listado con los datos de los empleados que no tienen clientes
asociados y el nombre de su jefe asociado.
*/
select em.nombre as empleado,concat(em.apellido1," ",em.apellido2)as apellidos,em2.nombre as jefe
from empleado as em 
left join cliente as cl on cl.idEmpleado = em.id
left join empleado as em2 on em2.id = em.idJefe
where cl.id is null;

/*
Consultas resumen
*/

/*
1. ¿Cuántos empleados hay en la compañía?
*/

select count(em.id)from empleado em;

/*
2. ¿Cuántos clientes tiene cada país?
*/

select count(cd.idCliente) as clientes,pv.pais 
from cliente_direccion as cd
join paisvista as pv on cd.idCiudad = pv.idCiudad
group by pv.pais;

/*
3. ¿Cuál fue el pago medio en 2008?
*/

select avg(total) from pago
where year(fecha);

/*
4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
descendente por el número de pedidos.
*/

select idEstado ,count(id) as pedidos from pedido
group by idEstado ;

/*
5. Calcula el precio de venta del producto más caro y más barato en una
misma consulta.
*/

select max(precioVenta)as maximo,
min(precioVenta)as minimo from producto;

/*
6. Calcula el número de clientes que tiene la empresa.
*/

select count(*) as cantClientes from cliente;


/*
7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?
*/

select count(*) cantidadClientes from cliente_direccion as cd
join ciudad as c on c.id = cd.idCiudad
where c.nombre = "madrid";

/*
8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan
por M?
*/

select  count(*) clientesEnM from cliente_direccion as cd
join ciudad as c on c.id = cd.idCiudad
where c.nombre like "m%";


/*
9. Devuelve el nombre de los representantes de ventas y el número de clientes
al que atiende cada uno.
*/

select em.nombre as vendedor,count(cl.id) as cantClientes from empleado as em
join cargo as cg on cg.id = em.idCargo
join cliente as cl on cl.idEmpleado = em.id
where cg.nombre = "vendedor"
group by em.nombre;

/*
10. Calcula el número de clientes que no tiene asignado representante de
ventas.
*/

select count(*) sinVendedores from empleado as em
left join cliente as cl on cl.idEmpleado = em.id
left join cargo as cg on cg.id = em.idCargo
where cl.id is not null and cg.nombre != "vendedor";



/*
11. Calcula la fecha del primer y último pago realizado por cada uno de los
clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.
*/

select cl.nombre,min(p.fecha) as primera, max(p.fecha)as ultima 
from pago as p
join cliente as cl on p.idCliente = cl.id
join cliente as cl2 on cl.id = cl2.id
group by cl.nombre;

/*
12. Calcula el número de productos diferentes que hay en cada uno de los
pedidos.
*/

select idPedido as idPedido,count(idProducto) as cantidad 
from detalle_pedido
group by idPedido;

/*
13. Calcula la suma de la cantidad total de todos los productos que aparecen en
cada uno de los pedidos.
*/

select dp.idPedido as idPedido,sum(dp.cantidad) as cantidad 
from detalle_pedido as dp
join pedido as p on dp.idPedido = p.id
group by dp.idPedido
;
/*
14. Devuelve un listado de los 5 productos más vendidos y el número total de
unidades que se han vendido de cada uno. El listado deberá estar ordenado
por el número total de unidades vendidas.
*/

select idProducto,p.nombre,cantidad from detalle_pedido as dp
join producto as p on p.id = dp.idProducto
order by cantidad desc limit 5;

/*
15. La facturación que ha tenido la empresa en toda la historia, indicando la
base imponible, el IVA y el total facturado. La base imponible se calcula
sumando el coste del producto por el número de unidades vendidas de la
tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
suma de los dos campos anteriores.
*/

select (dp.cantidad * sum(p.precioProveedor)) as imponible,
(dp.cantidad * sum(p.precioProveedor) * 1.21 - dp.cantidad * sum(p.precioProveedor)) as iva,
(dp.cantidad * sum(p.precioProveedor) * 1.21 - dp.cantidad * sum(p.precioProveedor)+ dp.cantidad * sum(p.precioProveedor)) as total
 from detalle_pedido as dp
join producto as p on dp.idProducto = p.id
group by dp.cantidad;


/*
16. La misma información que en la pregunta anterior, pero agrupada por
código de producto.
*/




select sum(dp.cantidad) from detalle_pedido as dp
join producto as p on dp.idProducto = p.id
