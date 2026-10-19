USE ventas_tech_db;

SELECT SUM (cantidad * precio_unitario) AS total_facturado
FROM ventas;

SELECT COUNT (cantidad) as cantidad_pedidos
FROM ventas;

SELECT AVG (id_venta) AS ventas_promedio
FROM ventas;
-- CONSULTA 1
SELECT
MONTH (fecha_venta) AS mes,
SUM (cantidad * precio_unitario) AS total_facturado,
COUNT (cantidad) AS cantidad_pedidos,
AVG (id_venta) AS ventas_promedio
FROM ventas
GROUP BY MONTH (fecha_venta)
ORDER BY mes;

-- CONSULTA 2
SELECT TOP 5 id_producto,
SUM (cantidad) AS cantidad_pedidos,
SUM (cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

--CONSULTA 3
SELECT id_cliente,
COUNT(*) AS cantidad_pedidos,
SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;

--CONSULTA 4
SELECT
MONTH(fecha_venta) AS mes,
SUM(cantidad * precio_unitario) AS Total_facturado,
CASE WHEN SUM(cantidad * precio_unitario) >
(
SELECT AVG(total_mes)
FROM
(
SELECT
SUM(cantidad * precio_unitario) AS total_mes
FROM ventas
GROUP BY MONTH(fecha_venta)
) AS Promedios
)
THEN 'Por encima'
ELSE 'Por debajo'
END AS Comparacion
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;


-- Un hallazgo es que el producto mas vendido mouse inalambrico pero en pesos es el menor de recaudacion.
-- Segundo hallazgo es que los cinco clientes cargados hicieron dos pedidos en el periodo, del cual Laura Torres es quien gastó mas.
-- Ultimo hallazgo fue que en el mes de marzo la facturación quedó por debajo del promedio