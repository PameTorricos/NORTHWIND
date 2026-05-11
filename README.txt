PROYECTO: SISTEMA OLTP + DATA WAREHOUSE + DACPAC

Descripción del Proyecto

El presente proyecto implementa una solución integral de bases de datos utilizando SQL Server, basada en el modelo Northwind.


El objetivo principal es simular una plataforma empresarial de ventas y distribución, permitiendo registrar operaciones transaccionales y posteriormente analizarlas mediante herramientas analíticas.
La empresa requiere administrar:

* Clientes.
* Proveedores.
* Productos.
* Empleados.
* Pedidos.
* Transportistas.
* Categorías.
* Territorios.

Además, necesita generar reportes analíticos sobre:
* Ventas totales.
* Productos más vendidos.
* Clientes más frecuentes.
* Rendimiento de empleados.
* Ventas por país.
* Descuentos aplicados.
* Distribución de pedidos.

El proyecto está dividido en dos grandes componentes:

Sistema OLTP, encargado de:

* Registrar operaciones transaccionales.
* Gestionar pedidos.
* Administrar clientes y productos.
* Mantener integridad referencial.

Data Warehouse, encargado de:

* Procesamiento analítico.
* Generación de KPIs.
* Consultas de inteligencia de negocios.
* Optimización de reportes.

Normalización (3FN)

El modelo cumple Tercera Forma Normal debido a:

Primera Forma Normal (1FN)
* No existen grupos repetitivos.
* Todos los atributos son atómicos.

Segunda Forma Normal (2FN)
* Los atributos dependen completamente de la clave primaria.
* No existen dependencias parciales.

Tercera Forma Normal (3FN)
* No existen dependencias transitivas.
* Los atributos dependen únicamente de la clave primaria.

---

Data Warehouse - Modelo Estrella

                             ┌─────────────────┐
                             │        DimDate        │
                             ├─────────────────┤
                             │ PK DateKey            │
                             │ FullDate              │
                             │ Year                  │
                             │ Quarter               │
                             │ Month                 │
                             │ MonthName             │
                             │ Day                   │
                             └────────┬──────── ┘
                                         │
                                         │
                                         │
┌─────────────────┐  		     │              ┌─────────────────┐
│      DimCustomer      │               │               │      DimProduct       │
├─────────────────┤   			 │               ├─────────────────┤
│ PK CustomerKey        │               │               │ PK ProductKey         │
│ CustomerID            │               │               │ ProductID             │
│ CompanyName           │               │               │ ProductName           │
│ Country               │               │               │ CategoryName          │
│ City                  │               │               │ SupplierName          │
│ Region                │               │               │ UnitPrice             │
└──────────┬──────┘      		│     			 │ Discontinued          │
           │                            │               └──────────┬──────┘
           │                            │                              │
           │                            │                              │
           │                            ▼                              │
           │               ┌──────────────────────┐    	    │
           └──────────▶│         FactSales            │◀────────┘
                           ├──────────────────────┤
                           │ PK FactSlesID                │
                           │ FK DateKey                   │
                           │ FK CustomerKey               │
                           │ FK ProductKey                │
                           │ FK EmployeeKey               │
                           │                              │
                           │ Quantity                     │
                           │ UnitPrice                    │
                           │ Discount                     │
                           │ Freight                      │
                           │ TotalAmount                  │
                           └──────────┬───────────┘
                                          │
                                          │
                                          │
                             ┌────────▼─────────┐
                             │      DimEmployee        │
                             ├──────────────────┤
                             │ PK EmployeeKey          │
                             │ EmployeeID              │
                             │ FullName                │
                             │ Title                   │
                             │ Country                 │
                             │ City                    │
                             └──────────────────┘
Proceso ETL

El proceso ETL realiza:

Extracción

Obtención de datos desde NorthwindOLTP.

Transformación

* Limpieza de datos.
* Conversión de formatos.
* Construcción de dimensiones.
* Cálculo de métricas.

Carga

Inserción de datos en:

* Tablas dimensionales.
* Tabla de hechos.

# 11. Estructura del Proyecto

ProyectoDW_Northwind/
│
├── README.txt
│
├── OLTP/
├── DW/
│   ├── 01_CreateDW.sql
│   ├── 02_Dimensions.sql
│   ├── 03_Facts.sql
│   ├── 04_ETL.sql
│   └── 05_Analytics.sql
│
├── DACPAC/
│   ├── NorthwindDW.sqlproj
│   └── publish.xml

Instrucciones de Despliegue

Paso 1: Ejecutar Base de Datos OLTP

Paso 2: Crear Data Warehouse
Ejecutar:
CreateDW.sql
Dimensions.sql
Facts.sql

Paso 3: Ejecutar ETL
Ejecutar:
ETL.sql

Paso 4: Consultas Analíticas
Ejecutar:
Analytics.sql

AUTOR: PAMELA CAROLINA TORRICOS RIVADINEIRA
MODULO II - ALMACENAMIENTO Y PREPARACION DE DATOS