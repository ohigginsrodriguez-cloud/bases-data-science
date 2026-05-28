-- GROUP BY: una fila por vendedor



-- =============================================
-- WINDOW FUNCTIONS básicas
-- =============================================

SELECT vendedor, SUM(monto) AS total
FROM ventas
GROUP BY vendedor;

-- Window function: todas las filas + el total del vendedor en cada una
SELECT 
    vendedor,
    monto,
    SUM(monto) OVER (PARTITION BY vendedor) AS total_vendedor,
    ROUND(monto * 100.0 / SUM(monto) OVER (PARTITION BY vendedor), 2) AS porcentaje
FROM ventas;


select 
	vendedor,
	monto,
	avg(monto) over(partition by vendedor) as promedio_vendedor
from ventas;

-- =============================================
-- ROW_NUMBER y RANK
-- =============================================

SELECT 
    vendedor,
    mes,
    monto,
    ROW_NUMBER() OVER (PARTITION BY vendedor ORDER BY monto DESC) AS ranking
FROM ventas;


SELECT vendedor, mes, monto
FROM (
    SELECT 
        vendedor,
        mes,
        monto,
        ROW_NUMBER() OVER (PARTITION BY vendedor ORDER BY monto DESC) AS ranking
    FROM ventas
) AS subquery
WHERE ranking = 1;

SELECT 
    vendedor,
    monto,
    ROW_NUMBER() OVER (ORDER BY monto DESC) AS row_number,
    RANK() OVER (ORDER BY monto DESC) AS rank
FROM ventas;

-- =============================================
-- EJERCICIOS
-- =============================================

-- 1. Muestra vendedor, monto, y el monto máximo de su región
--    en cada fila

select
	vendedor, 
	monto,
	max(monto) over (partition by region) as monto_maximo
	from ventas
	order by vendedor;

-- 2. Muestra vendedor, mes, monto, y el ranking de ventas
--    dentro de su región (mayor monto = ranking 1)

select
	region,
	vendedor,
	mes,
	monto,
	rank() over (partition by region order by monto desc) as ranking_ventas
from ventas;

-- 3. Muestra todas las filas con vendedor, monto,
--    y cuánto representa ese monto del total general
--    en porcentaje (como hicimos antes pero sin PARTITION BY)

select 
	vendedor,
	monto,
	round(monto * 100.0 / sum(monto) over (), 2) as porcentaje
	from ventas
	order by monto desc;