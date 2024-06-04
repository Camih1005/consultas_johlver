
/*
16. La misma información que en la pregunta anterior, pero agrupada por
código de producto.
*/

select p.id,(dp.cantidad * sum(p.precioProveedor)) as imponible,
(dp.cantidad * sum(p.precioProveedor) * 1.21 - dp.cantidad * sum(p.precioProveedor)) as iva,
(dp.cantidad * sum(p.precioProveedor) * 1.21 - dp.cantidad * sum(p.precioProveedor)+ dp.cantidad * sum(p.precioProveedor)) as total
 from detalle_pedido as dp
join producto as p on dp.idProducto = p.id
group by dp.cantidad,p.id;



/*
17. La misma información que en la pregunta anterior, pero agrupada por
código de producto filtrada por los códigos que empiecen por PRD00.
*/

select p.id,(dp.cantidad * sum(p.precioProveedor)) as imponible,
(dp.cantidad * sum(p.precioProveedor) * 1.21 - dp.cantidad * sum(p.precioProveedor)) as iva,
(dp.cantidad * sum(p.precioProveedor) * 1.21 - dp.cantidad * sum(p.precioProveedor)+ dp.cantidad * sum(p.precioProveedor)) as total
 from detalle_pedido as dp
join producto as p on dp.idProducto = p.id
group by dp.cantidad,p.id
having p.id like "PRD00%";


/*
18. Lista las ventas totales de los productos que hayan facturado más de 3000
euros. Se mostrará el nombre, unidades vendidas, total facturado y total
facturado con impuestos (21% IVA).
*/

select p.nombre,dp.cantidad,p.precioVenta,(dp.cantidad * p.precioVenta)
as CantXprecio,(dp.cantidad * p.precioVenta * 1.21)as masIVA 
from detalle_pedido as dp
join producto as p on dp.idProducto = p.id;


/*
19. Muestre la suma total de todos los pagos que se realizaron para cada uno
de los años que aparecen en la tabla pagos.
*/

select year(fecha) as fecha,sum(total)as suma from pago
group by year(fecha);


/*
SUB CONSULTAS
*/

/*
1. Devuelve el nombre del cliente con mayor límite de crédito.
*/
Select nombre from (select nombre,max(limiteCredito) from cliente
group by nombre)as cliente2;
