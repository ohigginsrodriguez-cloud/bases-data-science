-- =============================================
-- SETUP: crear tabla e insertar datos
-- =============================================
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

-- =============================================
-- GROUP BY básico
-- =============================================
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

-- 4. Total por vendedor.

select vendedor, sum(monto) as total
from ventas
group by vendedor;

-- =============================================
-- HAVING vs WHERE
-- =============================================
-- WHERE filtra filas antes de agrupar

SELECT vendedor, SUM(monto) AS total
FROM ventas
WHERE monto > 10000
GROUP BY vendedor;

select vendedor, monto 
from ventas
where vendedor = 'Ana';

-- HAVING filtra grupos después de agrupar  

select vendedor, sum(monto) as total
from ventas
group by vendedor
having sum(monto) > 30000;

-- =============================================
-- EJERCICIOS
-- =============================================
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