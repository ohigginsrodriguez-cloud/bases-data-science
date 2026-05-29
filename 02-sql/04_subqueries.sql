-- Subquery básica: ventas con monto mayor al promedio general
select vendedor, monto
from ventas 
where monto > (select avg(monto)  from ventas);

-- Vendedores cuyo total de ventas supera 
-- el promedio de totales por vendedor

select vendedor, total 
from (
	select vendedor, sum(monto) as total
	from ventas
	group by vendedor
) subquery
where total > (
	select avg(total)
	from (
		select vendedor, sum(monto) as total
		from ventas
		group by vendedor 
	) promedios
);

-- 1. Productos cuyo monto promedio supera 
--    el promedio general de todos los montos

-- 2. El vendedor con el monto más alto en cada mes
--    (usa subquery con ROW_NUMBER)

-- 3. Ventas donde el monto supera el total 
--    de ventas de Luis