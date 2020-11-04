SELECT T.StudentId, T.DiasSemUso, E.TotalSessoes, ISNULL(F.TotalGasto, 0) AS TotalGasto FROM
	(SELECT 
		StudentId,
		MAX(SessionStartTime) AS UltimaSessao, 
		DATEDIFF(DAY, MAX(SessionStartTime), '2018-05-31') AS DiasSemUso
	FROM [PD_B-02-sessions] 
	WHERE 
		(SessionStartTime >= '2017-11-01 00:00:00') AND (SessionStartTime <= '2018-05-31 23:59:59')
	GROUP BY 
	StudentId) as T
LEFT JOIN
	(SELECT 
		StudentId,
		MIN(SessionStartTime) AS PrimeiraSessao,
		MAX(SessionStartTime) AS UltimaSessao,
		COUNT(*) AS TotalSessoes
	FROM [PD_B-02-sessions] 
	WHERE 
		(SessionStartTime >= '2017-11-01 00:00:00') AND (SessionStartTime <= '2018-05-31 23:59:59')
	GROUP BY 
	StudentId) as E
ON T.StudentId = E.StudentId
LEFT JOIN
	(SELECT 
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
	WHERE 
		(PaymentDate >= '2017-11-01 00:00:00') AND (PaymentDate <= '2018-05-31 23:59:59')
	GROUP BY StudentId) AS F
ON T.StudentId = F.StudentId
WHERE TotalGasto > 0