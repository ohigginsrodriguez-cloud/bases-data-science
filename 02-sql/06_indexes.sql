-- Ver cuánto tarda una query sin índice
EXPLAIN ANALYZE
SELECT * FROM ventas WHERE vendedor = 'Ana';

create index idx_ventas_vendedor on ventas(vendedor);

explain analyze 
select * from ventas where vendedor = 'Ana';

-- Índice simple — una columna
CREATE INDEX idx_ventas_vendedor ON ventas(vendedor);
--            ^nombre del índice  ^tabla  ^columna

-- Índice compuesto — varias columnas
-- Útil cuando filtras por dos columnas juntas frecuentemente
CREATE INDEX idx_ventas_region_mes ON ventas(region, mes);

-- Ver los índices que tiene una tabla
SELECT indexname, indexdef 
FROM pg_indexes 
WHERE tablename = 'ventas';

-- Eliminar un índice
DROP INDEX idx_ventas_vendedor;

CREATE INDEX idx_ventas_region_mes ON ventas(region, mes);

EXPLAIN ANALYZE
SELECT * FROM ventas 
WHERE region = 'norte' AND mes = 'enero';