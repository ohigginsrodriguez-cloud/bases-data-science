CREATE TABLE ventas (
    id SERIAL PRIMARY KEY,
    vendedor VARCHAR(100),
    mes VARCHAR(50),
    monto INTEGER,
    region VARCHAR(50),
    producto VARCHAR(100)
);

INSERT INTO ventas (vendedor, mes, monto, region, producto) VALUES
('Ana', 'enero', 15000, 'norte', 'laptop'),
('Luis', 'enero', 8000, 'sur', 'mouse'),
('Ana', 'febrero', 20000, 'norte', 'laptop'),
('Eva', 'enero', 12000, 'norte', 'teclado'),
('Luis', 'febrero', 9500, 'sur', 'monitor'),
('Ana', 'marzo', 18000, 'norte', 'laptop'),
('Eva', 'febrero', 15000, 'norte', 'monitor'),
('Luis', 'marzo', 11000, 'sur', 'laptop'),
('Eva', 'marzo', 9000, 'norte', 'mouse'),
('Ana', 'abril', 22000, 'norte', 'laptop');

select COUNT(*) from ventas;

select * from ventas;

select vendedor, sum(monto) as total
from ventas
group by vendedor;

-- 1. Total por región

select region, sum(monto) as total
from ventas
group by region;

-- 2. Promedio de ventas por vendedor (usa AVG en lugar de SUM)

select vendedor, avg(monto) as promedio
from ventas
group by vendedor;

-- 3. Cuántas ventas hizo cada vendedor (usa COUNT)

select vendedor, count(monto) as catntidad_ventas
from ventas
group by vendedor;

select vendedor, sum(monto) as total
from ventas
group by vendedor
having sum(monto) > 30000;

-- WHERE: filtra filas antes de agrupar
-- Solo toma en cuenta ventas mayores a 10000, luego agrupa
SELECT vendedor, SUM(monto) AS total
FROM ventas
WHERE monto > 10000
GROUP BY vendedor;

-- HAVING: agrupa primero, luego filtra el resultado
-- Agrupa todo, luego muestra solo los que suman más de 30000
SELECT vendedor, SUM(monto) AS total
FROM ventas
GROUP BY vendedor
HAVING SUM(monto) > 30000;

select vendedor, monto
from ventas
order by vendedor;

select vendedor, monto 
from ventas
where vendedor = 'Ana';

-- 1. Vendedores que hicieron más de 2 ventas

select vendedor
from ventas
group by vendedor
having count(monto) > 2;

-- 2. Regiones donde el promedio de ventas es mayor a 12000

select region
from ventas
group by region
having avg(monto) > 12000;

-- 3. Vendedores cuyo monto máximo de una sola venta supera 15000
--    (usa MAX en lugar de SUM)

select vendedor
from ventas
group by vendedor
having max(monto) > 15000;

-- 4. Ventas del mes de enero donde el monto es mayor a 10000
--    (aquí usa WHERE, no HAVING — piensa por qué)

select vendedor, monto
from ventas
where mes = 'enero' and monto > 10000;

-- Ordenar de mayor a menor monto
SELECT vendedor, monto
FROM ventas
ORDER BY monto DESC;

-- Top 3 ventas más altas
SELECT vendedor, monto
FROM ventas
ORDER BY monto DESC
LIMIT 3;

-- 1. Top 2 vendedores con mayor total de ventas

select vendedor, sum(monto) as total
from ventas
group by vendedor
order by total desc
limit 2;

-- 2. Promedio de ventas por producto, ordenado de mayor a menor,
--    solo los que tienen promedio mayor a 10000

select producto, avg(monto) as promedio
from ventas 
group by producto
having avg(monto) > 10000
order by promedio desc;

-- 3. Mes con más ventas en total, solo el primero

select mes, sum(monto) as total
from ventas
group by mes
order by total desc
limit 1;

-- 4. Vendedor con más ventas en la región norte

select vendedor, count(monto) as ventas_count
from ventas
where region = 'norte'
group by vendedor
order by ventas_count desc
limit 1;


