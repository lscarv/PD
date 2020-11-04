-- TOTAL DE CLIENTES QUE PAGARAM O PLANO MENSAL OUT.2017
SELECT 
	COUNT(DISTINCT(P.StudentId)) AS TotalClientes
FROM  
	[PD_B-06-premium_payments] AS P
WHERE
	(PlanType='Mensal' AND (PaymentDate >= '2017-10-01 00:00:00' AND PaymentDate <= '2017-10-31 23:59:59'))

-- RETORNA TODOS OS USUÁRIOS QUE PAGARAM O PLANO MENSAL EM OUT./2017 E CANCELARAM EM OUTUBRO
SELECT 
	COUNT(DISTINCT(StudentId)) AS CANCELAMENTO
FROM 
	[PD_B-07-premium_cancellations] AS C
WHERE
	(CancellationDate >= '2017-10-01 00:00:00' AND CancellationDate <= '2017-10-31 23:59:59') 
	AND	StudentId IN 
	(
		SELECT 
			DISTINCT(P.StudentId) AS TotalClientes
		FROM  
			[PD_B-06-premium_payments] AS P
		WHERE
			(PlanType='Mensal' AND (PaymentDate >= '2017-10-01 00:00:00' AND PaymentDate <= '2017-10-31 23:59:59'))
	)

-- RETORNA TODOS OS USUÁRIOS QUE PAGARAM O PLANO MENSAL EM OUT./2017 E CANCELARAM EM NOVEMBRO
SELECT 
	COUNT(DISTINCT(StudentId)) AS CANCELAMENTO
FROM 
	[PD_B-07-premium_cancellations] AS C
WHERE
	(CancellationDate >= '2017-11-01 00:00:00' AND CancellationDate <= '2017-11-30 23:59:59') 
	AND	StudentId IN 
	(
		SELECT 
			DISTINCT(P.StudentId) AS TotalClientes
		FROM  
			[PD_B-06-premium_payments] AS P
		WHERE
			(PlanType='Mensal' AND (PaymentDate >= '2017-10-01 00:00:00' AND PaymentDate <= '2017-10-31 23:59:59'))
	)