-- 1. Top 3 productos más vendidos por monto total

select
	producto,
	sum(monto) as monto_total
from ventas 
group by producto
order by monto_total desc
limit 3;

-- 2. Vendedor con mayor promedio de venta por región
--    (el mejor vendedor de cada región)

select region, vendedor, promedio
from(
	select
		region,
		vendedor,
		avg(monto) as promedio,
		row_number() over (partition by region order by avg(monto) desc) as row
	from ventas
	group by region, vendedor
	) subquery
where row = 1;



-- 3. Mes donde se vendió más en la región norte

select 
	sum(monto) as ventas_mes_total,
	mes
from ventas
where region = 'norte'
group by mes
order by ventas_mes_total  desc
limit 1;

-- 4. Porcentaje que representa cada vendedor del total general
--    usando window functions

select 
	vendedor,
	round(monto * 100.0 / sum(monto) over () , 2)
from ventas;

-- 5. Ranking de ventas por producto, de mayor a menor monto
--    dentro de cada producto

select 
	producto,
	monto,
	rank() over (partition by producto order by monto desc) as ranking_producto
from ventas;