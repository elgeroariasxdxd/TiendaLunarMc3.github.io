# LunarMC — TP6: normalización y modelo relacional

## Punto de partida: base real

La base original `lunarmc` contiene `usuarios`, `pedidos`, `pedido_productos` y `meta_mensual`. En `pedido_productos` se almacenan el nombre del producto como texto, el precio, la cantidad y el subtotal. Ya existen claves primarias autoincrementales y relaciones entre pedidos, usuarios y detalles.

## 1. Tabla hipotética sin normalizar

| pedido_id | nick | email | rol | productos | categorias | total |
|---|---|---|---|---|---|---:|
| 101 | JugadorDemo | demo@example.com | cliente | Sun (1), Venus (2) | Rangos, Rangos | 14.97 |

**Problemas:** las columnas `productos` y `categorias` contienen listas; el nombre, correo y rol del usuario se repetirían en cada pedido. Esta fila es hipotética para explicar el proceso, no una fila copiada de la base real.

## 2. Primera forma normal (1FN)

Se convierte cada producto comprado en una fila, con valores atómicos:

| pedido_id | producto | cantidad | nick | email | rol |
|---|---|---:|---|---|---|
| 101 | Sun | 1 | JugadorDemo | demo@example.com | cliente |
| 101 | Venus | 2 | JugadorDemo | demo@example.com | cliente |

Para analizar la 2FN, se considera como clave candidata de esta tabla de ejemplo la combinación `(pedido_id, producto)`.

## 3. Segunda forma normal (2FN)

En la tabla de 1FN, `nick`, `email` y `rol` dependen del pedido, no de toda la clave compuesta `(pedido_id, producto)`. Por eso se separan los datos del encabezado y del detalle:

- `pedidos`: un registro por compra, vinculado a un usuario.
- `pedido_productos`: una fila por producto comprado, con cantidad y precio histórico.
- `usuarios`: datos personales y de autenticación, independientes de cada compra.

Así se eliminan dependencias parciales del ejemplo y se evita repetir datos personales por cada artículo.

## 4. Tercera forma normal (3FN)

Se separan entidades que antes podían describirse mediante textos repetidos:

- `roles`: nombre del rol; `usuarios` almacena `rol_id`.
- `categorias`: nombre de la categoría; `productos` almacena `categoria_id`.
- `productos`: catálogo maestro con código, nombre y precio vigente.
- `pedido_productos`: almacena `producto_id` en lugar del nombre del producto repetido.

El precio en `pedido_productos.precio` es el **precio histórico de venta**, diferente del precio vigente de `productos.precio`; por ello se conserva. `subtotal` se mantiene en el esquema de prueba por compatibilidad conceptual con el diseño original, aunque puede calcularse como `precio * cantidad` y conviene controlar su consistencia.

## 5. Tablas finales, claves y relaciones

| Tabla | PK | FK |
|---|---|---|
| `roles` | `id` | — |
| `usuarios` | `id` | `rol_id → roles.id` |
| `categorias` | `id` | — |
| `productos` | `id` | `categoria_id → categorias.id` |
| `pedidos` | `id` | `usuario_id → usuarios.id` |
| `pedido_productos` | `id` | `pedido_id → pedidos.id`; `producto_id → productos.id` |
| `meta_mensual` | `id` | — |

### Relaciones

- Un rol tiene muchos usuarios (1:N).
- Un usuario puede tener muchos pedidos (1:N).
- Una categoría puede tener muchos productos (1:N).
- Un pedido contiene muchos productos y un producto puede aparecer en muchos pedidos (N:M), resuelto mediante `pedido_productos`.

## 6. Requisitos técnicos

`schema.sql` crea PK `INT AUTO_INCREMENT`, FK explícitas, auditoría `created_at`/`updated_at` e índices explícitos. `consultas.sql` incluye `INSERT`, `SELECT ... WHERE ... ORDER BY`, `INNER JOIN`, `UPDATE ... WHERE` y `DELETE ... WHERE`.

## 7. Pruebas en XAMPP/phpMyAdmin

1. Hacer una copia de seguridad de la base original `lunarmc`.
2. Importar `schema.sql`, que crea **otra base** llamada `lunarmc_tp6`.
3. Importar `consultas.sql` seleccionando `lunarmc_tp6`.
4. Comprobar que existen las siete tablas, que las FK aparecen en la vista de relaciones y que las consultas devuelven resultados.
5. Capturar pantalla de la estructura, relaciones y resultados de las consultas.

**Importante:** este TP6 documenta un esquema objetivo y de prueba. No migra los datos reales ni modifica el código PHP de producción. Para adaptar la base real se necesita una migración compatible con el procesamiento actual de pedidos y el resto del proyecto.
