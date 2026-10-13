-- Ejecutar DESPUES de schema.sql sobre lunarmc_tp6.
-- Usa datos ficticios. Evitar ejecutar dos veces sin limpiar la base de prueba.
USE lunarmc_tp6;

-- CREATE: tablas maestras (dos o mas registros).
INSERT INTO roles (nombre) VALUES ('cliente'), ('administrador');
INSERT INTO categorias (nombre) VALUES ('Rangos'), ('Extras'), ('Llaves');

-- Usuarios ficticios; el hash es un valor de demostracion, no una cuenta habilitada para login.
INSERT INTO usuarios (rol_id, nick, email, password, gender)
VALUES (1, 'JugadorDemoTP6', 'jugador.tp6@example.com', 'HASH_DE_PRUEBA_NO_UTILIZABLE', 'otro');

-- CREATE: tabla principal de negocio (productos), con FK a categorias.
INSERT INTO productos (codigo, categoria_id, nombre, descripcion, precio)
VALUES ('sun', 1, 'Sun', 'Rango Sun', 2.99),
       ('venus', 1, 'Venus', 'Rango Venus', 5.99),
       ('kill_effects', 2, 'Kill Effects', 'Efectos cosmeticos', 4.99),
       ('producto_prueba', 2, 'Producto temporal TP6', 'Solo para probar DELETE', 1.00);

-- Dos pedidos de prueba y su detalle.
INSERT INTO pedidos (usuario_id, total, estado)
VALUES (1, 2.99, 'pendiente'), (1, 10.98, 'pendiente');
INSERT INTO pedido_productos (pedido_id, producto_id, precio, cantidad, subtotal)
VALUES (1, 1, 2.99, 1, 2.99),
       (2, 2, 5.99, 1, 5.99),
       (2, 3, 4.99, 1, 4.99);

-- READ: WHERE + ORDER BY.
SELECT id, nombre, precio FROM productos
WHERE categoria_id = 1 ORDER BY precio DESC;

-- READ: INNER JOIN entre tablas relacionadas.
SELECT p.id AS pedido, u.nick, pr.nombre AS producto,
       d.cantidad, d.precio, d.subtotal
FROM pedido_productos d
INNER JOIN pedidos p ON p.id = d.pedido_id
INNER JOIN usuarios u ON u.id = p.usuario_id
INNER JOIN productos pr ON pr.id = d.producto_id
ORDER BY p.id, d.id;

-- UPDATE: modificar un registro concreto.
UPDATE pedidos SET estado = 'pagado' WHERE id = 1;
SELECT id, estado FROM pedidos WHERE id = 1;

-- DELETE: borrar solamente el producto temporal sin referencias.
DELETE FROM productos WHERE codigo = 'producto_prueba';
SELECT id, nombre FROM productos ORDER BY id;
