-- Negocios (las PYMEs registradas)
CREATE TABLE negocios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    propietario_nombre VARCHAR(150),
    email VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    creado_en TIMESTAMP DEFAULT NOW()
);

-- Planes disponibles
CREATE TABLE planes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    precio_mensual NUMERIC(10,2),
    incluye_prediccion BOOLEAN DEFAULT TRUE,
    incluye_recomendacion BOOLEAN DEFAULT FALSE,
    incluye_simulacion BOOLEAN DEFAULT FALSE
);

-- Suscripciones activas
CREATE TABLE suscripciones (
    id SERIAL PRIMARY KEY,
    negocio_id INTEGER REFERENCES negocios(id),
    plan_id INTEGER REFERENCES planes(id),
    activa BOOLEAN DEFAULT TRUE,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE
);

-- Catálogo de productos por negocio
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    negocio_id INTEGER REFERENCES negocios(id),
    nombre VARCHAR(150) NOT NULL,
    categoria VARCHAR(100),
    precio_actual NUMERIC(10,2),
    costo_actual NUMERIC(10,2),
    activo BOOLEAN DEFAULT TRUE,
    creado_en TIMESTAMP DEFAULT NOW()
);

-- Transacción (la venta como evento)
CREATE TABLE ventas (
    id SERIAL PRIMARY KEY,
    negocio_id INTEGER REFERENCES negocios(id),
    fecha TIMESTAMP NOT NULL,
    creado_en TIMESTAMP DEFAULT NOW()
);

-- Detalle de productos por venta
CREATE TABLE venta_detalle (
    id SERIAL PRIMARY KEY,
    venta_id INTEGER REFERENCES ventas(id),
    producto_id INTEGER REFERENCES productos(id),
    cantidad INTEGER NOT NULL,
    precio_unitario NUMERIC(10,2) NOT NULL
);

-- Movimientos de inventario
CREATE TABLE inventario_movimientos (
    id SERIAL PRIMARY KEY,
    producto_id INTEGER REFERENCES productos(id),
    tipo_movimiento VARCHAR(20) NOT NULL,
    cantidad INTEGER NOT NULL,
    motivo VARCHAR(100),
    fecha DATE NOT NULL,
    creado_en TIMESTAMP DEFAULT NOW()
);








-- Negocio de prueba
INSERT INTO negocios (nombre, propietario_nombre, email, telefono)
VALUES ('Abarrotes Don Memo', 'Memo Pérez', 'memo@example.com', '9991234567');

-- Plan de prueba
INSERT INTO planes (nombre, precio_mensual, incluye_prediccion, incluye_recomendacion, incluye_simulacion)
VALUES ('basico', 199.00, TRUE, FALSE, FALSE);

-- Suscripción activa
INSERT INTO suscripciones (negocio_id, plan_id, activa, fecha_inicio)
VALUES (1, 1, TRUE, '2024-01-01');

-- Productos de la tiendita
INSERT INTO productos (negocio_id, nombre, categoria, precio_actual, costo_actual)
VALUES 
(1, 'Coca-Cola 600ml', 'bebidas', 18.00, 12.00),
(1, 'Sabritas Original', 'snacks', 17.00, 11.00),
(1, 'Pan Bimbo', 'panaderia', 45.00, 32.00),
(1, 'Leche Lala 1L', 'lacteos', 28.00, 21.00);



SELECT * FROM productos;


SELECT COUNT(*) FROM ventas;
SELECT COUNT(*) FROM venta_detalle;

SELECT * FROM ventas LIMIT 5;
SELECT * FROM venta_detalle LIMIT 5;













