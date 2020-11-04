-- CLIENTES QUE DEVERIA RENOVAR MAS NÃO RENOVARAM
SELECT 
	--COUNT(DISTINCT(StudentId)) AS TotUsersMonthPlan
	DISTINCT(StudentId) AS TotUsersMonthPlan, Assinatura, UltimaRenovacao
FROM
	(SELECT 
		DISTINCT(StudentId), COUNT(*) AS TotalPagamento, MIN(PaymentDate) as Assinatura, MAX(PaymentDate) as UltimaRenovacao
	FROM [PD_B-06-premium_payments] 
	WHERE 
		(PlanType='Anual') AND (PaymentDate <= '2017-11-30 23:59:59')
	GROUP BY StudentId) AS t
WHERE 
	((t.Assinatura >= '2016-11-01 00:00:00') AND (t.Assinatura <= '2016-11-30 23:59:59')) 
	AND StudentId NOT IN
	(
		SELECT 
			DISTINCT(StudentId)
		FROM
			(SELECT 
				DISTINCT(StudentId), COUNT(*) AS TotalPagamento, MIN(PaymentDate) as Assinatura, MAX(PaymentDate) as UltimaRenovacao
			FROM [PD_B-06-premium_payments] 
			WHERE 
				(PlanType='Anual') AND (PaymentDate <= '2017-11-30 23:59:59')
			GROUP BY StudentId) AS t
		WHERE 
			(t.Assinatura < '2017-11-01 00:00:00' AND t.UltimaRenovacao >= '2017-11-01 00:00:00')
	)

