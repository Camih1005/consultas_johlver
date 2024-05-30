## -- 1 Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

~~~~sql
select f.id,c.nombre from oficina as f 
join oficina_direccion as od on f.id = od.idOficina 
join ciudad as c on c.id = od.idCiudad; 
~~~~

## salida
```

+-----+--------------+
| id  | nombre       |
+-----+--------------+
| OF1 | Buenos Aires |
| OF2 | São Paulo    |
| OF3 | Bogotá       |
+-----+--------------+
```


