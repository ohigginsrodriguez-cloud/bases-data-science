-- REPORTE COMPLETO DE VENTAS
-- Resuelve cada sección con las herramientas que aprendiste

-- SECCIÓN 1: Resumen general
-- 1a. Total de ventas, promedio y cantidad de transacciones 
--     de toda la empresa

select
	sum(monto) as total_ventas,
	avg(monto) as promedio,
	count(*) as transacciones
from ventas;

-- 1b. Lo mismo pero por región

select
	region,
	sum(monto) as total_ventas,
	avg(monto) as promedio,
	count(*) as transacciones
from ventas
group by region;

-- SECCIÓN 2: Performance de vendedores

-- 2a. Ranking de vendedores por total de ventas

select 
	vendedor,
	sum(monto) as total_ventas,
	rank() over (order by sum(monto) desc) as ranking
from ventas
group by vendedor;

-- 2b. Vendedores que están por encima del promedio general

with totales as (
	select 
		vendedor,
		sum(monto) as total
from ventas
group by vendedor
)
select 
	vendedor,
	total
from totales
where total > (select avg(total) from totales)

-- 2c. Para cada vendedor, su mejor mes (mes con mayor venta)

select vendedor, mes as  mejor_mes, monto
from (
	select 
		vendedor,
		mes,
		monto,
		row_number() over(partition by vendedor order by monto desc) as rn
	from ventas
) s
where rn = 1;

-- SECCIÓN 3: Análisis de productos

-- 3a. Top 3 productos más vendidos por monto total

select producto, sum(monto) as total_producto
from ventas
group by producto
order by total_producto  desc
limit 3;

-- 3b. Producto más vendido por región

with totales as (
select region, producto,
	sum(monto) as total
from ventas
group by producto, region
),
mas_vendidos as (
select region, producto, total,
	row_number() over (partition by region order by total desc) as row
from totales
)
select region, producto, total
from mas_vendidos 
where row = 1


-- SECCIÓN 4: Análisis temporal

-- 4a. Mes con más ventas en total

select mes, sum(monto) as total
from ventas 
group by mes
order by total desc
limit 1

-- 4b. Para cada mes, el vendedor con mayor venta ese mes

with mes_vendedor as (
	select mes, vendedor, sum(monto) as total_ventas
	from ventas
	group by mes, vendedor
),
mayores as (
	select mes, vendedor, total_ventas,
		row_number() over (partition by mes order by total_ventas desc) as row
	from mes_vendedor
)
select mes, vendedor, total_ventas
from mayores
where row = 1

-- SECCIÓN 5: Reporte ejecutivo con CTEs

-- Una sola query que muestre por vendedor:
-- nombre, total, porcentaje del total general, ranking

with reporte as (
	select 
		vendedor,
		sum(monto) as total_vendedor
	from ventas
	group by vendedor
),
porcentaje_ranking as (
	select vendedor, total_vendedor,
		round(total_vendedor * 100 / sum(total_vendedor) over (), 2) as porcentaje,
		rank() over (order by total_vendedor desc) as rank
	from reporte
)
select vendedor, total_vendedor, porcentaje, rank
from porcentaje_ranking