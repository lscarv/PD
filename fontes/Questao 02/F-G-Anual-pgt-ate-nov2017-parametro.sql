-- TOTAL DE CLIENTES QUE JÁ ASSINARAM O PLANO ANUAL ATÉ NOV./2017
DECLARE @ANOFIM INT;
DECLARE @MESFIM INT;
DECLARE @ANOINI INT;
DECLARE @MESINI INT;

DECLARE @sANOFIM VARCHAR(4);
DECLARE @sMESFIM VARCHAR(2);
DECLARE @sANOINI VARCHAR(4);
DECLARE @sMESINI VARCHAR(2);
DECLARE @sDATAFIM VARCHAR(MAX);
DECLARE @sDATAINI VARCHAR(MAX);
DECLARE @sDATAINIMES VARCHAR(MAX);

DECLARE @sDIAFIM VARCHAR(2);

SET @ANOFIM = 2017;
SET @MESFIM = 11
SET @sDIAFIM = '30'
SET @ANOINI = @ANOFIM-1;
SET @MESINI = @MESFIM-1;

IF (@MESINI = 0) SET @MESINI = 12

SET @sANOFIM = CAST(@ANOFIM AS VARCHAR(4))
SET @sMESFIM = CAST(@MESFIM AS VARCHAR(4))
SET @sANOINI = CAST(@ANOINI AS VARCHAR(4))
SET @sMESINI = CAST(@MESINI AS VARCHAR(4))

SET @sDATAFIM = @sANOFIM + '-' + @sMESFIM + '-' + @sDIAFIM + ' 23:59:59'
SET @sDATAINI = @sANOINI + '-' + @sMESFIM + '-01 00:00:00'
SET @sDATAINIMES = @sANOFIM + '-' + @sMESFIM + '-01 00:00:00'

SELECT 
	COUNT(DISTINCT(StudentId)) AS TotUsersAnualPlan
	--DISTINCT(StudentId)
FROM [PD_B-06-premium_payments] 
WHERE 
	(PlanType='Anual') AND (PaymentDate >= @sDATAINI AND PaymentDate <= (@sDATAFIM))
	AND StudentId NOT IN
	(
		SELECT 
			DISTINCT(StudentId)
		FROM 
			[PD_B-07-premium_cancellations] AS C
		WHERE
			(CancellationDate >= (@sDATAINIMES) AND CancellationDate <= (@sDATAFIM)) AND
			StudentId IN 
			(
				SELECT 
					DISTINCT(StudentId) AS TotUsersMonthPlan
				FROM [PD_B-06-premium_payments] 
				WHERE 
					(PlanType='Anual') AND (PaymentDate <= (@sDATAFIM))
			)	
	)
	AND StudentId NOT IN
	(
		SELECT 
			DISTINCT(C.StudentId)
		FROM 
			[PD_B-07-premium_cancellations] AS C
		INNER JOIN
			(SELECT 
				P.StudentId, P.PlanType, MIN(P.PaymentDate) AS Assinatura, MAX(P.PaymentDate) AS Renovacao
			FROM 
				[PD_B-07-premium_cancellations] AS C
			INNER JOIN [PD_B-06-premium_payments] AS P ON C.StudentId = P.StudentId 
			WHERE
				(PlanType='Anual') AND (PaymentDate <= (@sDATAFIM))
				AND (CancellationDate < (@sDATAINIMES)) 
			GROUP BY
				P.StudentId, P.PlanType) AS P
		ON C.StudentId = P.StudentId
		WHERE C.CancellationDate > P.Renovacao AND (C.CancellationDate < (@sDATAINIMES))
	)
	AND StudentId NOT IN
	(
		SELECT 
			DISTINCT(StudentId)
		FROM
			(SELECT 
				DISTINCT(StudentId), COUNT(*) AS TotalPagamento, MIN(PaymentDate) as Assinatura, MAX(PaymentDate) as UltimaRenovacao
			FROM [PD_B-06-premium_payments] 
			WHERE 
				(PlanType='Anual') AND (PaymentDate <= (@sDATAFIM))
			GROUP BY StudentId) AS t
		WHERE 
			((t.Assinatura >= @sDATAINI) AND (t.Assinatura <= @sANOINI + '-' + @sMESFIM + '-' + @sDIAFIM + ' 23:59:59')) 
			AND StudentId NOT IN
			(
				SELECT 
					DISTINCT(StudentId)
				FROM
					(SELECT 
						DISTINCT(StudentId), COUNT(*) AS TotalPagamento, MIN(PaymentDate) as Assinatura, MAX(PaymentDate) as UltimaRenovacao
					FROM [PD_B-06-premium_payments] 
					WHERE 
						(PlanType='Anual') AND (PaymentDate <= (@sDATAFIM))
					GROUP BY StudentId) AS t
				WHERE 
					(t.Assinatura < (@sDATAINIMES) AND t.UltimaRenovacao >= (@sDATAINIMES))
			)
	)

