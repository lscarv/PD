SELECT 
	Periodo, 
	COUNT(Periodo) AS Assinantes, 
	CONCAT(CONVERT(DECIMAL(18,2), ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) over(), 2)), '%')  AS Probabilidade
FROM
	(SELECT 
		CASE
			WHEN Horas < 24 THEN '24 horas'
			WHEN DIAS = 1 THEN '1 dia'
			WHEN DIAS = 2 THEN '2 dias'
			WHEN DIAS >= 3 AND DIAS <= 7 THEN 'até 7 dias'
			WHEN DIAS >= 8 AND DIAS <= 14 THEN 'até 15 dias'
			WHEN DIAS >= 15 AND DIAS <= 30 THEN 'até 30 dias'
			WHEN MESES = 1 THEN 'No mês seguinte'
			WHEN MESES = 2 THEN '2 meses'
			WHEN MESES = 3 OR MESES = 4 THEN '3-4 meses'
			WHEN MESES = 5 OR MESES = 6 THEN '5-6 meses'
			WHEN MESES > 6 THEN 'acima de 6 meses'
		END AS Periodo
	FROM 
		(
			SELECT 
				StudentID, RegisteredDate, SubscriptionDate,
				DATEDIFF(HOUR, RegisteredDate, SubscriptionDate) as Horas,
				DATEDIFF(HOUR, RegisteredDate, SubscriptionDate)/24 as Dias, 
				FLOOR((DATEDIFF(HOUR, RegisteredDate, SubscriptionDate)/24)/30.436875E) as Meses
			FROM [PD_A-01-premium_students]
		) 
	AS students) as prob
GROUP BY Periodo