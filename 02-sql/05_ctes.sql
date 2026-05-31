-- Con subquery — difícil de leer
SELECT vendedor, total
FROM (
    SELECT vendedor, SUM(monto) AS total
    FROM ventas
    GROUP BY vendedor
) subquery
WHERE total > 30000;

-- Con CTE — más legible
WITH totales AS (
    SELECT vendedor, SUM(monto) AS total
    FROM ventas
    GROUP BY vendedor
)
SELECT vendedor, total
FROM totales
WHERE total > 30000;


WITH totales AS (
    SELECT vendedor, SUM(monto) AS total
    FROM ventas
    GROUP BY vendedor
)
SELECT 
    vendedor,
    total,
    ROUND(total * 100.0 / (SELECT SUM(total) FROM totales), 2) AS porcentaje
FROM totales
ORDER BY total DESC;


WITH totales AS (
    SELECT vendedor, SUM(monto) AS total
    FROM ventas
    GROUP BY vendedor
),
promedios AS (
    SELECT AVG(total) AS promedio_general
    FROM totales
)
SELECT vendedor, total
FROM totales, promedios
WHERE total > promedio_general;



-- 1. Con una CTE, obtén el promedio de ventas por región
--    y muestra solo las regiones con promedio mayor a 12000

with promedios as (
	select 
		avg(monto) as promedio_region,
		region
	from ventas
	group by region
)
select 
	round(promedio_region),
	region
from promedios
where promedio_region > 12000

-- 2. Con dos CTEs encadenadas:
--    - primera: total de ventas por vendedor
--    - segunda: ranking de vendedores por total
--    muestra el ranking final

with total_ventas_vendedor as (
	select vendedor, sum(monto) as total_vendedor
	from ventas
	group by vendedor
),
ranking_vendedores as (
	select 
		vendedor,
		total_vendedor,
		rank() over(order by total_vendedor desc) as rank
	from total_ventas_vendedor
)
select vendedor, total_vendedor, rank
from ranking_vendedores;

-- 3. Con una CTE, obtén las ventas de cada vendedor
--    y calcula qué porcentaje representa cada mes
--    del total de ese vendedor

with ventas_vendedor as (
	select vendedor, mes, monto,
		sum(monto) over (partition by vendedor) as total_vendedor
	from ventas
)
select vendedor, mes, monto, total_vendedor,
	round((monto * 100.0) / total_vendedor, 2 ) as porcentaje
from ventas_vendedor ;
	

