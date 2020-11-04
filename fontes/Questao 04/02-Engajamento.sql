SELECT 
	StudentId,
	MIN(SessionStartTime) AS PrimeiraSessao,
	MAX(SessionStartTime) AS UltimaSessao,
	COUNT(*) AS TotalSessoes
FROM [PD_B-02-sessions] 
--WHERE 
	--(SessionStartTime <= '2017-11-30 23:59:59')
GROUP BY 
StudentId

SELECT MAX(SessionStartTime) AS UltimaSessao
FROM [PD_B-02-sessions] 
