# 🌙 LunarMC Network — Proyecto Integrador

##  Descripción del proyecto

LunarMC es una tienda web desarrollada para un servidor de Minecraft. Su objetivo es permitir que los usuarios puedan registrarse, iniciar sesión y adquirir rangos y productos adicionales dentro del servidor.

Este proyecto fue desarrollado como parte de un Proyecto Integrador escolar, aplicando conocimientos de desarrollo web, programación PHP y bases de datos MySQL.

##  Tecnologías utilizadas

- **HTML:** estructura de las páginas.
- **CSS:** diseño y personalización visual.
- **JavaScript:** interactividad de la tienda.
- **PHP:** funcionamiento del registro, inicio de sesión, carrito y procesamiento de pedidos.
- **MySQL:** almacenamiento de usuarios, productos y compras.
- **XAMPP:** ejecución local del servidor Apache y MySQL.
- **phpMyAdmin:** administración de la base de datos.

## 🛒 Funcionalidades principales

- Registro de usuarios.
- Inicio de sesión mediante usuario y contraseña.
- Visualización de rangos y productos.
- Carrito de compras.
- Registro de pedidos.
- Sistema de meta mensual.
- Almacenamiento de información en MySQL.

## 🗄️ TP6 — Normalización de la base de datos

En esta etapa del Proyecto Integrador se realizó una mejora de la estructura de la base de datos de LunarMC, aplicando los conceptos de normalización hasta la Tercera Forma Normal (3FN).

Inicialmente, el sistema contaba con cuatro tablas principales:

- `usuarios`
- `pedidos`
- `pedido_productos`
- `meta_mensual`

Se incorporaron tres nuevas tablas:

- `roles`
- `categorias`
- `productos`

De esta manera, la base de datos pasó a contar con **siete tablas relacionadas**, utilizando claves primarias y foráneas para mejorar la organización y consistencia de los datos.

### Formas normales aplicadas

**Primera Forma Normal (1FN):** se organizaron los registros para que cada campo contenga un valor individual, evitando listas de productos dentro de una misma celda.

**Segunda Forma Normal (2FN):** se analizaron las dependencias funcionales y se separó la información correspondiente a usuarios, pedidos y productos.

**Tercera Forma Normal (3FN):** se organizaron los datos de roles, categorías y productos en tablas independientes para reducir redundancias y evitar dependencias innecesarias.

### Relaciones entre tablas

- `usuarios.rol_id` → `roles.id`
- `productos.categoria_id` → `categorias.id`
- `pedidos.usuario_id` → `usuarios.id`
- `pedido_productos.pedido_id` → `pedidos.id`
- `pedido_productos.producto_id` → `productos.id`

Se conservaron algunas columnas del sistema original para mantener la compatibilidad con el código PHP existente.

## 📂 Archivos del TP6

**`NORMALIZACION.md`**

Documento que explica el proceso de normalización, desde una estructura sin normalizar hasta la Tercera Forma Normal.

**`schema.sql`**

Archivo SQL que contiene la estructura de las tablas, sus claves primarias, claves foráneas e índices.

**`consultas.sql`**

Archivo con ejemplos de operaciones CRUD:

- `INSERT`: insertar registros.
- `SELECT`: consultar información.
- `UPDATE`: actualizar registros.
- `DELETE`: eliminar registros.

También incluye consultas con `INNER JOIN` para relacionar la información de distintas tablas.

## ✅ Pruebas realizadas

Se realizaron pruebas para verificar:

- El registro de nuevos usuarios.
- La asignación del rol de cliente.
- El almacenamiento de pedidos.
- La relación entre productos y compras mediante `producto_id`.
- El funcionamiento de consultas `INNER JOIN`.
- La actualización de la meta mensual después de una compra.

## 💻 Ejecución local

Para ejecutar LunarMC se necesita tener instalado XAMPP con Apache y MySQL.

1. Copiar los archivos del proyecto dentro de la carpeta `htdocs`.
2. Iniciar Apache y MySQL desde XAMPP.
3. Importar la base de datos correspondiente mediante phpMyAdmin.
4. Configurar los datos de conexión de PHP con MySQL.
5. Abrir la página desde `http://localhost/lunarmc/`.

**Nota:** los archivos SQL del TP6 utilizan una base de demostración independiente de la base de datos utilizada por la tienda.

## 🎯 Objetivo del TP6

Aplicar los principios de normalización de bases de datos a un sistema web real, mejorando la organización de la información, estableciendo relaciones entre entidades y comprobando su funcionamiento mediante consultas SQL.

---


**Trabajo Práctico N.º 6: Normalización de Bases de Datos**
