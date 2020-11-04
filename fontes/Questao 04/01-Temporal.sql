SELECT 
	StudentId,
	MAX(SessionStartTime) AS UltimaSessao,
	DATEDIFF(DAY, MAX(SessionStartTime), '2018-05-31') AS DiasSemUso
FROM [PD_B-02-sessions] 
WHERE 
	(SessionStartTime <= '2018-05-31 23:59:59')
GROUP BY 
StudentId
