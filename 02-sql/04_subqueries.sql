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

select producto, avg(monto) as promedio_producto
from ventas
group by producto
having avg(monto) > (select avg(monto) from ventas)


-- 2. El vendedor con el monto más alto en cada mes
--    (usa subquery con ROW_NUMBER)

select vendedor, monto, mes, monto_alto_mes
from (
select
	vendedor,
	monto,
	mes,
	row_number() over(partition by mes order by monto desc) as monto_alto_mes
from ventas
) subquery
where subquery.monto_alto_mes = 1

-- 3. Ventas donde el monto supera el total 
--    de ventas de Luis

select 
	vendedor,
	monto
from ventas
where monto > (select sum(monto) from ventas where vendedor = 'Luis')


