SELECT 
	PlanType,
	DATEPART(YEAR, PaymentDate) AS Ano,
	DATEPART(MONTH, PaymentDate) AS Mes,
	COUNT(DISTINCT(StudentID)) AS Total
FROM [PD_B-06-premium_payments] 
WHERE 
	(PaymentDate <= '2017-11-30 23:59:59')
GROUP BY 
PlanType,
DATEPART(YEAR, PaymentDate),
DATEPART(MONTH, PaymentDate)
ORDER BY 
PlanType Asc,
DATEPART(YEAR, PaymentDate) Asc,
DATEPART(MONTH, PaymentDate) Asc
