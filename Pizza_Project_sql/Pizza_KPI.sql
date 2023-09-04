SELECT * FROM pizza_sales

-- 1. KPI's --


/* TOTAL INGRESOS */

SELECT SUM(total_price) AS Total_Ingresos
FROM pizza_sales

/* CUAL ES EL PEDIDO MEDIO */

SELECT SUM(total_price) / COUNT(DISTINCT order_id) 
	AS Media_Pedido 
FROM pizza_sales

/* TOTAL DE PIZZA VENDIDA */

SELECT SUM(quantity) AS Total_Pizza_Vendida FROM pizza_sales


/* TOTAL PEDIDO*/

SELECT COUNT(DISTINCT order_id) AS Total_Pedido FROM pizza_sales


/* PIZZA MEDIA POR PEDIDO*/

SELECT CAST((SUM(quantity) / COUNT(DISTINCT order_id)) AS DECIMAL(10,2))
AS Media_Pizza_Por_Pedido
FROM pizza_sales



-- 2. EVOLUCIÓN DIARIA DEL TOTAL DE PEDIDOS --

SELECT DATENAME(DW, order_date) AS Dia_Pedido,
	COUNT (DISTINCT order_id) AS Total_Pedidos
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)
ORDER BY Total_Pedidos DESC


-- 3. EVOLUCIÓN MENSUAL DEL TOTAL DE PEDIDOS --

SELECT DATENAME(MONTH, order_date) AS Nombre_Mes,
	COUNT(DISTINCT order_id) AS Total_Pedidos
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY Total_Pedidos DESC


-- 4. % VENTAS POR CATEGORIA --

SELECT pizza_category,
	CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_Ingresos,
	CAST(SUM(total_price) *100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL (10,2))
	AS Porcentaje_ventas
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Porcentaje_ventas DESC


-- 5. % VENTAS POR TAMAÑO DE LA PIZZA --

SELECT pizza_size,
	CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_Ingresos,
	CAST(SUM(total_price) *100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2))
	AS Porcentaje_ventas
FROM pizza_sales
GROUP BY pizza_size
ORDER BY Porcentaje_ventas DESC


-- 6. TOP 5 MÁS VENDIDAS --

SELECT TOP 5 pizza_name,
	SUM(total_price) AS Total_Ingresos
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Ingresos DESC


-- 7. LAS 5 MENOS VENDIDAS --

SELECT TOP 5 pizza_name,
	SUM(total_price) AS Total_Ingresos
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Ingresos ASC


-- 8. TOP 5 POR CANTIDAD -- 

SELECT TOP 5 pizza_name,
	SUM(quantity) AS Total_Cantidad
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Cantidad DESC


--- 9. LAS MENOS VENDIDAS POR CANTIDAD --

SELECT TOP 5 pizza_name,
	SUM(quantity) AS Total_Cantidad
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Cantidad ASC


-- 10. TOP 5 POR PEDIDO --

SELECT TOP 5 pizza_name,
	COUNT(DISTINCT order_id) AS Total_Pedido
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pedido ASC