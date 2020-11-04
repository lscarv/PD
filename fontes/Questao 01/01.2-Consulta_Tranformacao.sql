SELECT 
	StudentID, RegisteredDate, SubscriptionDate,
	DATEDIFF(HOUR, RegisteredDate, SubscriptionDate) as Horas,
	DATEDIFF(HOUR, RegisteredDate, SubscriptionDate)/24 as Dias, 
	((DATEDIFF(HOUR, RegisteredDate, SubscriptionDate)/24)/7) as Semanas,
	FLOOR((DATEDIFF(HOUR, RegisteredDate, SubscriptionDate)/24)/30.436875E) as Meses
FROM [PD_A-01-premium_students]
--WHERE DATEDIFF(HOUR, RegisteredDate, SubscriptionDate) > 23
ORDER BY DATEDIFF(HOUR, RegisteredDate, SubscriptionDate)
