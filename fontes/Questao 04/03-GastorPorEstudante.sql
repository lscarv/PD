SELECT 
	StudentId,
	MIN(PaymentDate) AS PrimeiroPgto,
	MAX(PaymentDate) AS UltimoPgto,
	SUM(
		CASE
			WHEN (PlanType = 'Mensal') THEN 29.90
			WHEN (PlanType = 'Anual') THEN 23.90
		END
	) AS TotalGasto
FROM [PD_B-06-premium_payments]
GROUP BY
StudentId 
ORDER BY TotalGasto DESC
