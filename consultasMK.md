 1 Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

~~~sql
select f.id,c.nombre from oficina as f 
join oficina_direccion as od on f.id = od.idOficina 
join ciudad as c on c.id = od.idCiudad; 
~~~
<pre>+------+--------------+
| id   | nombre       |
+------+--------------+
| OF1  | Buenos Aires |
| OF10 | París        |
| OF2  | São Paulo    |
| OF3  | Bogotá       |
| OF4  | Buenos Aires |
| OF5  | São Paulo    |
| OF6  | Cali         |
| OF7  | Madrid       |
| OF8  | Madrid       |
| OF9  | París        |
+------+--------------+
</pre>


 2 Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

~~~sql
SELECT pv.ciudad,ot.telefono from oficina_direccion as od join oficina_telefono as ot
 on ot.idOficina = od.idOficina
join paisvista as pv on pv.idCiudad = od.idCiudad where pv.pais = "españa";
~~~
<pre>+--------+------------+
| ciudad | telefono   |
+--------+------------+
| Madrid | 6677889900 |
| Madrid | 0099887766 |
| Madrid | 7788990011 |
| Madrid | 1100998877 |
+--------+------------+</pre>

 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
-- jefe tiene un código de jefe igual a 7.
~~~sql
select em.nombre,concat(em.apellido1," ",em.apellido2)
as apellidos,em.email 
from empleado as em where idCargo = 1 ;
~~~
<pre>+--------+------------------+----------------------------+
| nombre | apellidos        | email                      |
+--------+------------------+----------------------------+
| Juan   | Pérez González   | juan.perez@example.com     |
| Elena  | Castro Mendoza   | elena.castro@example.com   |
| Eva    | Gómez Pacheco    | eva.gomez@example.com      |
| Isabel | Mendoza Castillo | isabel.mendoza@example.com |
+--------+------------------+----------------------------+
</pre>

 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
-- empresa.
~~~sql
select car.nombre,em.nombre,concat(em.apellido1," ",em.apellido2)
as apellidos,em.email 
from empleado as em join cargo as car 
on car.id = em.idCargo where em.idJefe is null;
~~~
<pre>+---------+--------+------------------+------------------------+
| nombre  | nombre | apellidos        | email                  |
+---------+--------+------------------+------------------------+
| Gerente | Juan   | Pérez González   | juan.perez@example.com |
+---------+--------+------------------+------------------------+
</pre>
 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
-- empleados que no sean representantes de ventas.
~~~sql
select em.nombre,concat(em.apellido1," ",em.apellido2)
as apellidos,car.nombre
from empleado as em join cargo as car 
on car.id = em.idCargo where car.nombre != "vendedor";
~~~
<pre>+-----------+------------------+-----------+
| nombre    | apellidos        | nombre    |
+-----------+------------------+-----------+
| Juan      | Pérez González   | Gerente   |
| Elena     | Castro Mendoza   | Gerente   |
| Eva       | Gómez Pacheco    | Gerente   |
| Isabel    | Mendoza Castillo | Gerente   |
| Carlos    | Martínez Díaz    | Contador  |
| Carmen    | Suárez Vega      | Contador  |
| Fernando  | Ramos García     | Contador  |
| Antonio   | Vázquez Peña     | Contador  |
| Francisco | López Romero     | Contador  |
| Javier    | Jiménez Rojas    | Contador  |
| Ana       | García Sánchez   | Jardinero |
| Miguel    | Ortega Luna      | Jardinero |
| Beatriz   | Moreno Salinas   | Jardinero |
| Gabriela  | Martín Núñez     | Jardinero |
| Karla     | Ruiz Torres      | Jardinero |
+-----------+------------------+-----------+
</pre>

 6. Devuelve un listado con el nombre de los todos los clientes españoles.

~~~sql
select distinct cl.nombre from cliente as cl 
join  cliente_direccion as cd on cl.id = cd.idCliente 
join paisvista as pv on cd.idCiudad = pv.idCiudad where pv.pais = "españa" ;
~~~

<pre>+---------+
| nombre  |
+---------+
| Nuria   |
| Fabián  |
| Manuel  |
+---------+
</pre>

 7.Devuelve un listado con los distintos estados por los que puede pasar un
 pedido.

~~~sql
select * from estado;
~~~



  8. Devuelve un listado con el código de cliente de aquellos clientes que
realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:

 YEAR
~~~sql
select cl.id,cl.nombre from cliente as cl join pago as pg on cl.id = pg.idCliente where year(pg.fecha) = 2008; 
~~~
<pre>+----+--------+
| id | nombre |
+----+--------+
| 12 | Ángel  |
|  4 | Jorge  |
+----+--------+
</pre>

 date_format
~~~sql
SELECT cl.id, cl.nombre 
FROM cliente AS cl 
JOIN pago AS pg ON cl.id = pg.idCliente 
WHERE DATE_FORMAT(pg.fecha, '%Y') = '2008';
~~~
<pre>+----+--------+
| id | nombre |
+----+--------+
| 12 | Ángel  |
|  4 | Jorge  |
+----+--------+
</pre>
 solo
~~~sql
SELECT cl.id, cl.nombre 
FROM cliente AS cl 
JOIN pago AS pg ON cl.id = pg.idCliente 
WHERE pg.fecha BETWEEN '2008-01-01' AND '2008-12-31';
~~~
<pre>+----+--------+
| id | nombre |
+----+--------+
| 12 | Ángel  |
|  4 | Jorge  |
+----+--------+
</pre>

 9. Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos que no han sido entregados a
tiempo.

~~~sql
select p.id,cl.id,p.fechaEsperada,p.fechaEntrega from pedido as p 
join cliente as cl on p.idCliente = cl.id 
join estado as es on p.idEstado = es.id 
where p.fechaEsperada < p.fechaEntrega;
~~~
<pre>+----+----+---------------+--------------+
| id | id | fechaEsperada | fechaEntrega |
+----+----+---------------+--------------+
| 11 |  2 | 2023-10-10    | 2023-11-09   |
| 15 |  4 | 2018-11-08    | 2018-11-12   |
+----+----+---------------+--------------+
</pre>
 10. Devuelve un listado con el código de pedido, código de cliente, fecha
esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
 menos dos días antes de la fecha esperada.

CON ADDDATE
~~~sql
select p.id,cl.id,p.fechaEsperada,p.fechaEntrega from pedido as p 
join cliente as cl on p.idCliente = cl.id 
join estado as es on p.idEstado = es.id 
where p.fechaEntrega <= adddate(p.fechaEsperada, interval -2 day);
~~~
<pre>+----+----+---------------+--------------+
| id | id | fechaEsperada | fechaEntrega |
+----+----+---------------+--------------+
| 13 | 13 | 2023-11-20    | 2023-11-09   |
+----+----+---------------+--------------+
</pre>
CON DATEDIFF
~~~sql
select p.id,cl.id,p.fechaEsperada,p.fechaEntrega from pedido as p 
join cliente as cl on p.idCliente = cl.id 
join estado as es on p.idEstado = es.id 
where datediff(p.fechaEsperada,p.fechaEntrega) >= 2;
~~~
<pre>+----+----+---------------+--------------+
| id | id | fechaEsperada | fechaEntrega |
+----+----+---------------+--------------+
| 13 | 13 | 2023-11-20    | 2023-11-09   |
+----+----+---------------+--------------+
</pre>
 con suma y resta

~~~sql
SELECT p.id, cl.id AS cliente_id, p.fechaEsperada, p.fechaEntrega
FROM pedido AS p 
JOIN cliente AS cl ON p.idCliente = cl.id 
JOIN estado AS es ON p.idEstado = es.id 
WHERE day(p.fechaEsperada) - day(p.fechaEntrega) >= 2 and month(p.fechaEsperada) - month(p.fechaEntrega) <= 1;
~~~
<pre>+----+----+---------------+--------------+
| id | id | fechaEsperada | fechaEntrega |
+----+----+---------------+--------------+
| 13 | 13 | 2023-11-20    | 2023-11-09   |
+----+----+---------------+--------------+
</pre>
 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

~~~sql
select p.id from pedido p 
join estado as es on p.idEstado = es.id where 
es.nombre = "cancelado" and year(fechaPedido) = 2009;
~~~
<pre>+----+
| id |
+----+
| 14 |
+----+
</pre>
 12 Devuelve un listado de todos los pedidos que han sido entregados en el
-- mes de enero de cualquier año.

~~~sql
select id from pedido 
where month(fechaEntrega) = 01;
~~~
<pre>+----+
| id |
+----+
|  1 |
+----+
</pre>
 13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

~~~sql
select pg.id from pago as pg 
join tipo_pago as tp 
on pg.idTipo = tp.id where tp.nombre = "paypal" and year(fecha) = 2008;
~~~
<pre>+----+
| id |
+----+
| 11 |
+----+</pre>

 14. Devuelve un listado con todas las formas de pago que aparecen en la
tabla pago. Tenga en cuenta que no deben aparecer formas de pago
repetidas. 
~~~sql
select distinct tp.nombre from pago as pg 
join tipo_pago as tp 
on pg.idTipo = tp.id ;
~~~
+------------------------+
| nombre                 |
+------------------------+
| Efectivo               |
| Tarjeta de Crédito     |
| Débito                 |
| Transferencia Bancaria |
| Paypal                 |
+------------------------+

 15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio. */




  Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
cuyo representante de ventas tenga el código de empleado 13 o 20.

~~~sql
select em.id,em.nombre,pv.ciudad,cd.direccion from empleado as em 
join cliente as cl on cl.idEmpleado = em.id 
join cliente_direccion as cd on cd.idCliente = cl.id
join paisvista as pv on pv.idCiudad = cd.idCiudad where pv.ciudad = "madrid" and em.id = 13 and 20 ;
~~~
<pre>+----+--------+--------+----------------+
| id | nombre | ciudad | direccion      |
+----+--------+--------+----------------+
| 13 | David  | Madrid | Calle AA 901   |
| 13 | David  | Madrid | Avenida BB 234 |
+----+--------+--------+----------------+
</pre>

## CONSULTAS MULTITABLASS



1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
representante de ventas.

~~~sql
select cl.nombre as cliente,em.nombre as representanteVentas,
concat(em.apellido1," ",em.apellido2)as apellidosRepresenVent 
from cliente as cl 
join empleado as em on cl.idEmpleado = em.id join cargo as cg on cg.id = em.idCargo
where cg.nombre = "vendedor";
~~~
<pre>+----------+---------------------+-----------------------+
| cliente  | representanteVentas | apellidosRepresenVent |
+----------+---------------------+-----------------------+
| Laura    | María               | López Hernández       |
| Pedro    | María               | López Hernández       |
| Mary     | María               | López Hernández       |
| Patricia | Luis                | Torres Navarro        |
| Tomás    | Gloria              | Hernández Martínez    |
| Nuria    | David               | Gil Ortega            |
| Joaquín  | Hugo                | Santos Vargas         |
+----------+---------------------+-----------------------+
</pre>
2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
nombre de sus representantes de ventas.

~~~sql
select cl.nombre as cliente,em.nombre as representante,pg.total,pg.fecha from cliente as cl 
join empleado as em on em.id = cl.idEmpleado 
join pago as pg on pg.idCliente = cl.id
join cargo as cg on cg.id = em.idCargo where cg.nombre = "vendedor" ; 
~~~
<pre>+----------+---------------+----------+------------+
| cliente  | representante | total    | fecha      |
+----------+---------------+----------+------------+
| Laura    | María         | 25000.00 | 2000-05-15 |
| Laura    | María         | 61000.00 | 2007-04-14 |
| Pedro    | María         | 38000.00 | 2001-07-20 |
| Patricia | Luis          | 29000.00 | 2005-02-18 |
| Tomás    | Gloria        | 42000.00 | 2002-09-10 |
| Nuria    | David         | 55000.00 | 2003-11-05 |
+----------+---------------+----------+------------+
</pre>
/*
3. Muestra el nombre de los clientes que no hayan realizado pagos junto con
el nombre de sus representantes de ventas.
*/
~~~sql
select cl.nombre as cliente,em.nombre as representante,pg.total,pg.fecha from cliente as cl 
 join empleado as em on em.id = cl.idEmpleado 
left join pago as pg on pg.idCliente = cl.id
left join cargo as cg on cg.id = em.idCargo where cg.nombre = "vendedor" and total is null ; 
~~~
<pre>+----------+---------------+-------+-------+
| cliente  | representante | total | fecha |
+----------+---------------+-------+-------+
| Mary     | María         |  NULL | NULL  |
| Joaquín  | Hugo          |  NULL | NULL  |
+----------+---------------+-------+-------+
</pre>

4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

~~~sql
select distinct cl.id,cl.nombre as cliente,em.nombre as representante,ofi.nombre,pv.ciudad from cliente as cl 
join empleado as em on em.id = cl.idEmpleado 
join pago as pg on pg.idCliente = cl.id
join cargo as cg on cg.id = em.idCargo 
join cliente_direccion as cd on cd.idCliente = cl.id 
join paisvista as pv on pv.idCiudad = cd.idCiudad
join oficina as ofi on em.idOficina = ofi.id
where cg.nombre = "vendedor" ; 
~~~

<pre>+----+----------+---------------+------------------+--------------+
| id | cliente  | representante | nombre           | ciudad       |
+----+----------+---------------+------------------+--------------+
|  1 | Laura    | María         | Oficina Central  | Buenos Aires |
|  2 | Pedro    | María         | Oficina Central  | Córdoba      |
|  6 | Patricia | Luis          | Oficina Central  | Córdoba      |
| 11 | Tomás    | Gloria        | Oficina Colombia | Medellín     |
| 14 | Nuria    | David         | Oficina Italia   | Madrid       |
+----+----------+---------------+------------------+--------------+</pre>
/*
5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
de sus representantes junto con la ciudad de la oficina a la que pertenece el
representante.

~~~sql
select distinct cl.id,cl.nombre as cliente,em.nombre as representante,ofi.nombre,pv.ciudad from cliente as cl 
join empleado as em on em.id = cl.idEmpleado 
left join pago as pg on pg.idCliente = cl.id
left join cargo as cg on cg.id = em.idCargo 
join cliente_direccion as cd on cd.idCliente = cl.id 
join paisvista as pv on pv.idCiudad = cd.idCiudad
join oficina as ofi on em.idOficina = ofi.id
where cg.nombre = "vendedor" and total is null; 
~~~
<pre>+----+----------+---------------+------------------+----------+
| id | cliente  | representante | nombre           | ciudad   |
+----+----------+---------------+------------------+----------+
| 18 | Joaquín  | Hugo          | Oficina Colombia | Marsella |
+----+----------+---------------+------------------+----------+
</pre>
6. Lista la dirección de las oficinas que tengan clientes en colombia.

~~~sql
select distinct od.direccion,pv.pais from oficina_direccion as od 
join oficina as ofi on ofi.id = od.idOficina 
join paisvista as pv on pv.idCiudad = od.idCiudad
join cliente_direccion as cd on cd.idCiudad = pv.idCiudad 
where pv.pais = "colombia";
~~~
<pre>+------------------------------------+----------+
| direccion                          | pais     |
+------------------------------------+----------+
| Boulevard Oficina Regional Sur 789 | Colombia |
| Carrera Oficina Medellín 123       | Colombia |
+------------------------------------+----------+
</pre>
7. Devuelve el nombre de los clientes y el nombre de sus representantes junto
con la ciudad de la oficina a la que pertenece el representante.

~~~sql
select distinct cl.nombre as cliente,em.nombre as representante,pv.ciudad from cliente as cl 
join empleado as em on em.id = cl.idEmpleado 
join pago as pg on pg.idCliente = cl.id
join cargo as cg on cg.id = em.idCargo 
join cliente_direccion as cd on cd.idCliente = cl.id 
join paisvista as pv on pv.idCiudad = cd.idCiudad
join oficina as ofi on em.idOficina = ofi.id
where cg.nombre = "vendedor"; 
~~~
<pre>+----------+---------------+--------------+
| cliente  | representante | ciudad       |
+----------+---------------+--------------+
| Laura    | María         | Buenos Aires |
| Pedro    | María         | Córdoba      |
| Patricia | Luis          | Córdoba      |
| Tomás    | Gloria        | Medellín     |
| Nuria    | David         | Madrid       |
+----------+---------------+--------------+
</pre>

8. Devuelve un listado con el nombre de los empleados junto con el nombre
de sus jefes.

~~~sql
select em.nombre,em2.idJefe,em2.nombre from empleado as em 
join empleado as em2
on em.idJefe = em2.id;
~~~
<pre>+-----------+--------+----------+
| nombre    | idJefe | nombre   |
+-----------+--------+----------+
| María     |   NULL | Juan     |
| Carlos    |   NULL | Juan     |
| Ana       |   NULL | Juan     |
| Luis      |      1 | María    |
| Carmen    |      1 | Carlos   |
| Miguel    |      1 | Ana      |
| Elena     |      1 | María    |
| Fernando  |      1 | Carlos   |
| Gloria    |      1 | Ana      |
| Antonio   |   NULL | Juan     |
| Beatriz   |      2 | Luis     |
| David     |      3 | Carmen   |
| Eva       |      4 | Miguel   |
| Francisco |      2 | Elena    |
| Gabriela  |      3 | Fernando |
| Hugo      |      4 | Gloria   |
| Isabel    |      1 | Antonio  |
| Javier    |      5 | Beatriz  |
| Karla     |      6 | David    |
| Laura     |      7 | Eva      |
| Christian |      7 | Eva      |
+-----------+--------+----------+
</pre>

9. Devuelve un listado que muestre el nombre de cada empleados, el nombre
de su jefe y el nombre del jefe de sus jefe.

~~~sql
select em.nombre as empleado,em2.idJefe,em2.nombre as jefe, em3.idJefe,em3.nombre
as jefejefe from empleado as em 
join empleado as em2
on em.idJefe = em2.id
join empleado as em3
on em2.idJefe = em3.id;
~~~
<pre>+-----------+--------+----------+--------+----------+
| empleado  | idJefe | jefe     | idJefe | jefejefe |
+-----------+--------+----------+--------+----------+
| Luis      |      1 | María    |   NULL | Juan     |
| Carmen    |      1 | Carlos   |   NULL | Juan     |
| Miguel    |      1 | Ana      |   NULL | Juan     |
| Elena     |      1 | María    |   NULL | Juan     |
| Fernando  |      1 | Carlos   |   NULL | Juan     |
| Gloria    |      1 | Ana      |   NULL | Juan     |
| Beatriz   |      2 | Luis     |      1 | María    |
| David     |      3 | Carmen   |      1 | Carlos   |
| Eva       |      4 | Miguel   |      1 | Ana      |
| Francisco |      2 | Elena    |      1 | María    |
| Gabriela  |      3 | Fernando |      1 | Carlos   |
| Hugo      |      4 | Gloria   |      1 | Ana      |
| Isabel    |      1 | Antonio  |   NULL | Juan     |
| Javier    |      5 | Beatriz  |      2 | Luis     |
| Karla     |      6 | David    |      3 | Carmen   |
| Laura     |      7 | Eva      |      4 | Miguel   |
| Christian |      7 | Eva      |      4 | Miguel   |
+-----------+--------+----------+--------+----------+
</pre>

10. Devuelve el nombre de los clientes a los que no se les ha entregado a
tiempo un pedido.

~~~sql
select cl.nombre from cliente as cl 
join pedido as pd on pd.idCliente = cl.id where 
date(pd.fechaEntrega) > date(pd.fechaEsperada);
~~~

<pre>+--------+
| nombre |
+--------+
| Pedro  |
| Jorge  |
+--------+
</pre>
11. Devuelve un listado de las diferentes gamas de producto que ha comprado
cada cliente.

~~~sql
select distinct gp.descripcion as gamas from detalle_pedido as dp 
join pedido as p on dp.idPedido = p.id 
join producto as prod on dp.idProducto = prod.id 
join gama_producto as gp on gp.id = prod.idGama
join cliente as cl on cl.id = p.idCliente;
~~~
<pre>+--------------+
| gamas        |
+--------------+
| Semillas     |
| Herramientas |
| Macetas      |
| Flores       |
+--------------+
</pre>

## Consultas multitabla (Composición externa)




1. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pago.

~~~sql
select cl.nombre as cliente
from cliente as cl 
left join pago as pg on pg.idCliente = cl.id where total is null; 
~~~
<pre>+-----------+
| cliente   |
+-----------+
| Lucía     |
| Raúl      |
| Esteban   |
| Verónica  |
| Gustavo   |
| Sara      |
| Manuel    |
| Joaquín   |
| Rebeca    |
| Ignacio   |
| Clara     |
| Camilo    |
| Mary      |
+-----------+
</pre>
2. Devuelve un listado que muestre solamente los clientes que no han
realizado ningún pedido.

~~~sql
select cl.nombre from pedido as pd 
right join cliente as cl on cl.id = pd.idCliente where pd.id is null;
~~~
<pre>+-----------+
| nombre    |
+-----------+
| Raúl      |
| Patricia  |
| Verónica  |
| Sara      |
| Tomás     |
| Ángel     |
| Nuria     |
| Fabián    |
| Manuel    |
| Cecilia   |
| Joaquín   |
| Rebeca    |
| Camilo    |
| Mary      |
+-----------+
</pre>

3. Devuelve un listado que muestre los clientes que no han realizado ningún
pago y los que no han realizado ningún pedido.

~~~sql
select cl.nombre as clienteSinPedido,cl2.nombre as cliSinPago
from cliente as cl 
join cliente as cl2 on cl.id = cl2.id
left join pago as pg on pg.idCliente = cl2.id 
left join pedido as pd on pd.idCliente = cl.id where pg.total is null and pd.id is null; 
~~~
<pre>+------------------+------------+
| clienteSinPedido | cliSinPago |
+------------------+------------+
| Raúl             | Raúl       |
| Verónica         | Verónica   |
| Sara             | Sara       |
| Manuel           | Manuel     |
| Joaquín          | Joaquín    |
| Rebeca           | Rebeca     |
| Camilo           | Camilo     |
| Mary             | Mary       |
+------------------+------------+
</pre>

4. Devuelve un listado que muestre solamente los empleados que no tienen
una oficina asociada
~~~sql
Select nombre,concat(apellido1," ",apellido2) as apellidos from empleado where idOficina is null;
~~~
<pre>+-----------+--------------+
| nombre    | apellidos    |
+-----------+--------------+
| Christian | Celis Ardila |
+-----------+--------------+
</pre>
5. Devuelve un listado que muestre solamente los empleados que no tienen un
cliente asociado.

~~~sql
select em.nombre from empleado as em 
left join cliente as cl on em.id = cl.idEmpleado
where cl.id is null;
~~~
<pre>+-----------+
| nombre    |
+-----------+
| Juan      |
| Laura     |
| Christian |
+-----------+
</pre>
6. Devuelve un listado que muestre solamente los empleados que no tienen un
cliente asociado junto con los datos de la oficina donde trabajan.

~~~sql
select em.nombre from empleado as em 
left join cliente as cl on em.id = cl.idEmpleado 
join oficina_direccion as od 
on od.idOficina = em.idOficina where cl.id is null;
~~~
<pre>+--------+
| nombre |
+--------+
| Juan   |
| Laura  |
+--------+
</pre>
7. Devuelve un listado que muestre los empleados que no tienen una oficina
asociada y los que no tienen un cliente asociado.

~~~sql
select em.nombre,ofi.id,cl.id from empleado as em 
left join oficina as ofi on ofi.id = em.idOficina
left join empleado as em2 on em2.idOficina = ofi.id
left join cliente as cl on cl.idEmpleado = em2.id 
where  cl.id is null or em2.idOficina is null;
~~~
<pre>+-----------+------+------+
| nombre    | id   | id   |
+-----------+------+------+
| Juan      | OF1  | NULL |
| María     | OF1  | NULL |
| Luis      | OF1  | NULL |
| Eva       | OF10 | NULL |
| Laura     | OF10 | NULL |
| Christian | NULL | NULL |
+-----------+------+------+
</pre>
8. Devuelve un listado de los productos que nunca han aparecido en un
pedido.

~~~sql
select p.id,p.descripcion as producto from producto as p 
left join detalle_pedido as dp on dp.idProducto = p.id
where dp.idProducto is null; 
~~~
<pre>+--------+------------------+
| id     | producto         |
+--------+------------------+
| PRD020 | Reja para puerta |
+--------+------------------+
</pre>

9. Devuelve un listado de los productos que nunca han aparecido en un
pedido. El resultado debe mostrar el nombre, la descripción y la imagen del
producto.

~~~sql
select p.id,p.nombre as nombre,p.descripcion,gp.imagen from producto as p 
left join detalle_pedido as dp on dp.idProducto = p.id
join gama_producto as gp on p.idGama = gp.id
where dp.idProducto is null; 
~~~
<pre>+--------+------------------+------------------+-----------------------------------+
| id     | nombre           | descripcion      | imagen                            |
+--------+------------------+------------------+-----------------------------------+
| PRD020 | Reja para puerta | Reja para puerta | ornamentacion para ornamentar.jpg |
+--------+------------------+------------------+-----------------------------------+
</pre>
10. Devuelve las oficinas donde no trabajan ninguno de los empleados que
hayan sido los representantes de ventas de algún cliente que haya realizado
la compra de algún producto de la gama Frutas.

~~~sql
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
~~~
<pre>+------+------------------------+
| id   | nombre                 |
+------+------------------------+
| OF1  | Oficina Central        |
| OF10 | Oficina Alemania       |
| OF2  | Oficina Regional Norte |
| OF3  | Oficina Regional Sur   |
| OF4  | Oficina Argentina      |
| OF5  | Oficina Brasil         |
| OF6  | Oficina Colombia       |
| OF7  | Oficina España         |
| OF8  | Oficina Francia        |
| OF9  | Oficina Italia         |
+------+------------------------+
</pre>
11. Devuelve un listado con los clientes que han realizado algún pedido pero no
han realizado ningún pago.

~~~sql
select  cl2.nombre as cliSinPago
from cliente as cl 
join cliente as cl2 on cl.id = cl2.id
left join pago as pg on pg.idCliente = cl2.id 
left join pedido as pd on pd.idCliente = cl.id where pg.total is null; 
~~~
<pre>+------------+
| cliSinPago |
+------------+
| Mary       |
| Lucía      |
| Raúl       |
| Esteban    |
| Verónica   |
| Gustavo    |
| Sara       |
| Manuel     |
| Joaquín    |
| Rebeca     |
| Ignacio    |
| Camilo     |
| Clara      |
+------------+
</pre>
12. Devuelve un listado con los datos de los empleados que no tienen clientes
asociados y el nombre de su jefe asociado.

~~~sql
select em.nombre as empleado,concat(em.apellido1," ",em.apellido2)as apellidos,em2.nombre as jefe
from empleado as em 
left join cliente as cl on cl.idEmpleado = em.id
left join empleado as em2 on em2.id = em.idJefe
where cl.id is null;
~~~
<pre>+-----------+------------------+------+
| empleado  | apellidos        | jefe |
+-----------+------------------+------+
| Juan      | Pérez González   | NULL |
| Laura     | Hidalgo Sosa     | Eva  |
| Christian | Celis Ardila     | Eva  |
+-----------+------------------+------+</pre>
## Consultas resumen



1. ¿Cuántos empleados hay en la compañía?

~~~sql
select count(em.id)from empleado em;
~~~
<pre>+--------------+
| count(em.id) |
+--------------+
|           22 |
+--------------+
</pre>

2. ¿Cuántos clientes tiene cada país?

~~~sql
select count(cd.idCliente) as clientes,pv.pais 
from cliente_direccion as cd
join paisvista as pv on cd.idCiudad = pv.idCiudad
group by pv.pais;
~~~
<pre>+----------+-----------+
| clientes | pais      |
+----------+-----------+
|       12 | Argentina |
|        8 | Brasil    |
|        6 | Colombia  |
|        6 | España    |
|        4 | Francia   |
|        4 | Italia    |
+----------+-----------+
</pre>
3. ¿Cuál fue el pago medio en 2008?

~~~sql
select avg(total) from pago
where year(fecha);
~~~
<pre>+--------------+
| avg(total)   |
+--------------+
| 45085.833333 |
+--------------+
</pre>
4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
descendente por el número de pedidos.

~~~sql
select idEstado ,count(id) as pedidos from pedido
group by idEstado ;
~~~
<pre>+----------+---------+
| idEstado | pedidos |
+----------+---------+
|        1 |       2 |
|        2 |       2 |
|        3 |       3 |
|        4 |       1 |
|        5 |       5 |
|        6 |       1 |
|        7 |       1 |
+----------+---------+
</pre>

5. Calcula el precio de venta del producto más caro y más barato en una
misma consulta.

~~~sql
select max(precioVenta)as maximo,
min(precioVenta)as minimo from producto;
~~~
<pre>+-----------+---------+
| maximo    | minimo  |
+-----------+---------+
| 220000.00 | 5000.00 |
+-----------+---------+
</pre>
6. Calcula el número de clientes que tiene la empresa.

~~~sql
select count(*) as cantClientes from cliente;
~~~
<pre>+--------------+
| cantClientes |
+--------------+
|           23 |
+--------------+
</pre>

7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

~~~sql
select count(*) cantidadClientes from cliente_direccion as cd
join ciudad as c on c.id = cd.idCiudad
where c.nombre = "madrid";
~~~
<pre>+------------------+
| cantidadClientes |
+------------------+
|                2 |
+------------------+</pre>
8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan
por M?

~~~sql
select  count(*) clientesEnM from cliente_direccion as cd
join ciudad as c on c.id = cd.idCiudad
where c.nombre like "m%";
~~~
<pre>+-------------+
| clientesEnM |
+-------------+
|           8 |
+-------------+
</pre>

9. Devuelve el nombre de los representantes de ventas y el número de clientes
al que atiende cada uno.

~~~sql
select em.nombre as vendedor,count(cl.id) as cantClientes from empleado as em
join cargo as cg on cg.id = em.idCargo
join cliente as cl on cl.idEmpleado = em.id
where cg.nombre = "vendedor"
group by em.nombre;
~~~
<pre>+----------+--------------+
| vendedor | cantClientes |
+----------+--------------+
| María    |            3 |
| Luis     |            1 |
| Gloria   |            1 |
| David    |            1 |
| Hugo     |            1 |
+----------+--------------+
</pre>
10. Calcula el número de clientes que no tiene asignado representante de
ventas.

~~~sql
select count(*) sinVendedores from empleado as em
left join cliente as cl on cl.idEmpleado = em.id
left join cargo as cg on cg.id = em.idCargo
where cl.id is not null and cg.nombre != "vendedor";
~~~
<pre>+---------------+
| sinVendedores |
+---------------+
|            16 |
+---------------+
</pre>


11. Calcula la fecha del primer y último pago realizado por cada uno de los
clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

~~~sql
select cl.nombre,min(p.fecha) as primera, max(p.fecha)as ultima 
from pago as p
join cliente as cl on p.idCliente = cl.id
join cliente as cl2 on cl.id = cl2.id
group by cl.nombre;
~~~
<pre>+----------+------------+------------+
| nombre   | primera    | ultima     |
+----------+------------+------------+
| Laura    | 2000-05-15 | 2007-04-14 |
| Pedro    | 2001-07-20 | 2001-07-20 |
| Tomás    | 2002-09-10 | 2002-09-10 |
| Nuria    | 2003-11-05 | 2003-11-05 |
| Silvia   | 2004-12-30 | 2004-12-30 |
| Patricia | 2005-02-18 | 2005-02-18 |
| Jorge    | 2006-03-22 | 2008-08-12 |
| Ángel    | 2008-06-08 | 2008-06-08 |
| Cecilia  | 2009-08-12 | 2009-08-12 |
| Fabián   | 2020-08-11 | 2020-08-11 |
+----------+------------+------------+
</pre>
12. Calcula el número de productos diferentes que hay en cada uno de los
pedidos.

~~~sql
select idPedido as idPedido,count(idProducto) as cantidad 
from detalle_pedido
group by idPedido;
~~~
<pre>+----------+----------+
| idPedido | cantidad |
+----------+----------+
|        1 |        2 |
|        2 |        2 |
|        3 |        2 |
|        4 |        2 |
|        5 |        2 |
|        6 |        2 |
|        7 |        2 |
|        8 |        2 |
|        9 |        2 |
|       10 |        1 |
+----------+----------+
</pre>
13. Calcula la suma de la cantidad total de todos los productos que aparecen en
cada uno de los pedidos.

~~~sql
select dp.idPedido as idPedido,sum(dp.cantidad) as cantidad 
from detalle_pedido as dp
join pedido as p on dp.idPedido = p.id
group by dp.idPedido
;
~~~
<pre>+----------+----------+
| idPedido | cantidad |
+----------+----------+
|        1 |        8 |
|        2 |       17 |
|        3 |        6 |
|        4 |       14 |
|        5 |        3 |
|        6 |        7 |
|        7 |       11 |
|        8 |       15 |
|        9 |       19 |
|       10 |        1 |
+----------+----------+
</pre>
14. Devuelve un listado de los 5 productos más vendidos y el número total de
unidades que se han vendido de cada uno. El listado deberá estar ordenado
por el número total de unidades vendidas.

~~~sql
select idProducto,p.nombre,cantidad from detalle_pedido as dp
join producto as p on p.id = dp.idProducto
order by cantidad desc limit 5;
~~~
<pre>+------------+-------------------+----------+
| idProducto | nombre            | cantidad |
+------------+-------------------+----------+
| PRD003     | Tijeras de Poda   |       10 |
| PRD018     | Planta Múnich     |       10 |
| PRD017     | Jardín Florencia  |        9 |
| PRD008     | Jardín Medellín   |        8 |
| PRD016     | Flor Milán        |        8 |
+------------+-------------------+----------+
</pre>
15. La facturación que ha tenido la empresa en toda la historia, indicando la
base imponible, el IVA y el total facturado. La base imponible se calcula
sumando el coste del producto por el número de unidades vendidas de la
tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
suma de los dos campos anteriores.

~~~sql
select (dp.cantidad * sum(p.precioProveedor)) as imponible,
(dp.cantidad * sum(p.precioProveedor) * 1.21 - dp.cantidad * sum(p.precioProveedor)) as iva,
(dp.cantidad * sum(p.precioProveedor) * 1.21 - dp.cantidad * sum(p.precioProveedor)+ dp.cantidad * sum(p.precioProveedor)) as total
 from detalle_pedido as dp
join producto as p on dp.idProducto = p.id
group by dp.cantidad;
~~~
<pre>+-----------+----------+-----------+
| imponible | iva      | total     |
+-----------+----------+-----------+
| 115000.00 | 24150.00 | 139150.00 |
|  31500.00 |  6615.00 |  38115.00 |
| 350000.00 | 73500.00 | 423500.00 |
| 175000.00 | 36750.00 | 211750.00 |
|  74000.00 | 15540.00 |  89540.00 |
|  88000.00 | 18480.00 | 106480.00 |
| 180000.00 | 37800.00 | 217800.00 |
| 224000.00 | 47040.00 | 271040.00 |
|  24000.00 |  5040.00 |  29040.00 |
| 225000.00 | 47250.00 | 272250.00 |
+-----------+----------+-----------+
</pre>

16. La misma información que en la pregunta anterior, pero agrupada por
código de producto.




