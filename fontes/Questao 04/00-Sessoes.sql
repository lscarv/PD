SELECT 
	DATEPART(YEAR, SessionStartTime) AS Ano,
	DATEPART(MONTH, SessionStartTime) AS Mes,
	COUNT(DISTINCT(StudentID)) AS TotalClientes,
	COUNT(*) AS TotalSessoes
FROM [PD_B-02-sessions] 
--WHERE 
	--(SessionStartTime <= '2017-11-30 23:59:59')
GROUP BY 
DATEPART(YEAR, SessionStartTime),
DATEPART(MONTH, SessionStartTime)
ORDER BY 
DATEPART(YEAR, SessionStartTime) Asc,
DATEPART(MONTH, SessionStartTime) Asc

SELECT 
	MIN(SessionStartTime) AS Maximo,
	MAX(SessionStartTime) AS Maximo
FROM [PD_B-02-sessions] 