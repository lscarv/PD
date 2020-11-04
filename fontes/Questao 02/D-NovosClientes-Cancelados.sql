SELECT 
	COUNT(DISTINCT(StudentId)) AS TotalCancelamentos
	--StudentId, COUNT(*)
FROM 
	[PD_B-07-premium_cancellations] AS C
WHERE
	(CancellationDate >= '2017-11-01 00:00:00' AND CancellationDate <= '2017-11-30 23:59:59')
	AND StudentId IN
	(
		SELECT 
			DISTINCT(StudentId)
		FROM
			(SELECT 
				DISTINCT(StudentId), COUNT(*) AS TotalPagamento, MIN(PaymentDate) as Assinatura, MAX(PaymentDate) as UltimaRenovacao
			FROM [PD_B-06-premium_payments] 
			WHERE 
				(PlanType='Mensal') AND (PaymentDate <= '2017-11-30 23:59:59')
			GROUP BY StudentId) AS t
		WHERE 
			(t.Assinatura >= '2017-11-01 00:00:00' AND t.Assinatura <= '2017-11-30 23:59:59')	
	)
--GROUP BY StudentId