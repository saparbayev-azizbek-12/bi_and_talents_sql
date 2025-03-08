create database lesson_10;

go

use lesson_10;

DROP TABLE IF EXISTS Shipments; 
CREATE TABLE Shipments (
    N INT PRIMARY KEY,
    Num INT
);

INSERT INTO Shipments (N, Num) VALUES (1, 1);
INSERT INTO Shipments (N, Num) VALUES (2, 1);
INSERT INTO Shipments (N, Num) VALUES (3, 1);
INSERT INTO Shipments (N, Num) VALUES (4, 1);
INSERT INTO Shipments (N, Num) VALUES (5, 1);
INSERT INTO Shipments (N, Num) VALUES (6, 1);
INSERT INTO Shipments (N, Num) VALUES (7, 1);
INSERT INTO Shipments (N, Num) VALUES (8, 1);
INSERT INTO Shipments (N, Num) VALUES (9, 2);
INSERT INTO Shipments (N, Num) VALUES (10, 2);
INSERT INTO Shipments (N, Num) VALUES (11, 2);
INSERT INTO Shipments (N, Num) VALUES (12, 2);
INSERT INTO Shipments (N, Num) VALUES (13, 2);
INSERT INTO Shipments (N, Num) VALUES (14, 4);
INSERT INTO Shipments (N, Num) VALUES (15, 4);
INSERT INTO Shipments (N, Num) VALUES (16, 4);
INSERT INTO Shipments (N, Num) VALUES (17, 4);
INSERT INTO Shipments (N, Num) VALUES (18, 4);
INSERT INTO Shipments (N, Num) VALUES (19, 4);
INSERT INTO Shipments (N, Num) VALUES (20, 4);
INSERT INTO Shipments (N, Num) VALUES (21, 4);
INSERT INTO Shipments (N, Num) VALUES (22, 4);
INSERT INTO Shipments (N, Num) VALUES (23, 4);
INSERT INTO Shipments (N, Num) VALUES (24, 4);
INSERT INTO Shipments (N, Num) VALUES (25, 4);
INSERT INTO Shipments (N, Num) VALUES (26, 5);
INSERT INTO Shipments (N, Num) VALUES (27, 5);
INSERT INTO Shipments (N, Num) VALUES (28, 5);
INSERT INTO Shipments (N, Num) VALUES (29, 5);
INSERT INTO Shipments (N, Num) VALUES (30, 5);
INSERT INTO Shipments (N, Num) VALUES (31, 5);
INSERT INTO Shipments (N, Num) VALUES (32, 6);
INSERT INTO Shipments (N, Num) VALUES (33, 7);

;WITH InitialTable AS (
	SELECT 1 AS Days
		UNION ALL
	SELECT Days + 1 FROM InitialTable
	WHERE Days < 40
),
RankedTable AS (
	SELECT IT.Days, ISNULL(S.Num, 0) AS Numbers, ROW_NUMBER() OVER(ORDER BY ISNULL(S.Num, 0)) AS rnk, COUNT(Days) OVER() AS Total
	FROM InitialTable IT
	LEFT JOIN Shipments S
		ON IT.Days = S.N
)
--SELECT * FROM RankedTable
SELECT CASE 
			WHEN COUNT(rnk) % 2 = 1 THEN 
			(
				SELECT TOP 1 Numbers FROM RankedTable
				WHERE rnk = ((Total + 1) / 2)
			)
			WHEN COUNT(rnk) % 2 = 0 THEN 
			(
				SELECT TOP 1 AVG(Numbers) FROM RankedTable 
				WHERE rnk IN ((Total / 2), ((Total + 2) / 2))
			)
		END AS Medium
FROM RankedTable