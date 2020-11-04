SELECT 
	DATEPART(YEAR, CancellationDate) AS Ano,
	DATEPART(MONTH, CancellationDate) AS Mes,
	COUNT(*) AS Total
FROM [PD_B-07-premium_cancellations] 
WHERE 
	(CancellationDate <= '2017-11-30 23:59:59')
GROUP BY 
DATEPART(YEAR, CancellationDate),
DATEPART(MONTH, CancellationDate)
ORDER BY 
DATEPART(YEAR, CancellationDate) Asc,
DATEPART(MONTH, CancellationDate) Asc	