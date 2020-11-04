-- NOVOS CLIENTES - ASSINARAM O PLANO ANUAL EM NOV./2017
SELECT 
	COUNT(DISTINCT(StudentId)) AS TotUsersMonthPlan
	--DISTINCT(StudentId) AS TotUsersMonthPlan, Assinatura, UltimaRenovacao, TotalPagamento
FROM
	(SELECT 
		DISTINCT(StudentId), COUNT(*) AS TotalPagamento, MIN(PaymentDate) as Assinatura, MAX(PaymentDate) as UltimaRenovacao
	FROM [PD_B-06-premium_payments] 
	WHERE 
		(PlanType='Mensal') AND (PaymentDate <= '2017-11-30 23:59:59')
	GROUP BY StudentId) AS t
WHERE 
	(t.Assinatura >= '2017-11-01 00:00:00' AND t.Assinatura <= '2017-11-30 23:59:59')
--ORDER BY t.Assinatura ASC, t.UltimaRenovacao ASC

