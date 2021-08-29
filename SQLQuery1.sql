IF DB_ID('Cinematograf') IS NOT NULL
	DROP DATABASE Cinematograf
CREATE DATABASE Cinematograf
ON PRIMARY
(
	Name = MasterFile,
	FileName = 'E:\Cursuri\Anul 2 sem 2\Baze de Date\Proiect\MasterFile.mdf',
	size = 10MB, -- KB, Mb, GB, TB
	maxsize = unlimited,
	filegrowth = 1GB
),
(
	Name = DataFile1,
	FileName = 'E:\Cursuri\Anul 2 sem 2\Baze de Date\Proiect\DataFile1.ndf',
	size = 10MB, -- KB, Mb, GB, TB
	maxsize = unlimited,
	filegrowth = 1GB
),
(
	Name = DataFile2,
	FileName = 'E:\Cursuri\Anul 2 sem 2\Baze de Date\Proiect\DataFile2.ndf',
	size = 10MB, -- KB, Mb, GB, TB
	maxsize = unlimited,
	filegrowth = 1GB
)
LOG ON
(
	Name = LogFile1,
	FileName = 'E:\Cursuri\Anul 2 sem 2\Baze de Date\Proiect\LogFile1.ldf',
	size = 10MB, -- KB, Mb, GB, TB
	maxsize = unlimited,
	filegrowth = 1024MB
),
(
	Name = LogFile2,
	FileName = 'E:\Cursuri\Anul 2 sem 2\Baze de Date\Proiect\LogFile2.ldf',
	size = 10MB, -- KB, Mb, GB, TB
	maxsize = unlimited,
	filegrowth = 1024MB
)

IF OBJECT_ID('Employees', 'U') IS NOT NULL
	DROP TABLE Employees;
GO  
CREATE TABLE Employees
(
	EmployeeID int PRIMARY KEY IDENTITY(1,1),
	BranchID int NOT NULL,
	AddressID int NOT NULL,
	LastName varchar(30) NOT NULL,
	FirstName varchar(30) NOT NULL,
	BirthDate date CHECK (DATEDIFF(year, BirthDate, GETDATE()) >= 18),
	HireDate date,
	Title nvarchar(30),
	Phone nvarchar(15),
	SalariuNet int,
	SalariuBrut int
	
)

IF OBJECT_ID('Customers', 'U') IS NOT NULL
	DROP TABLE Customers;
GO  
CREATE TABLE Customers
(
	CustomerID int PRIMARY KEY IDENTITY(1,1),
	TicketID int,
	LastName varchar(30),
	FirstName varchar(30),
	Status varchar(30),
	Regular bit
)

IF OBJECT_ID('Addresses', 'U') IS NOT NULL
	DROP TABLE Addresses;
GO  
CREATE TABLE Addresses
(
	AddressID int PRIMARY KEY IDENTITY(1,1),
	TerritoryID int NOT NULL,
	County nvarchar(30),
	City nvarchar(30),
	Street nvarchar(30),
	Number int
)

IF OBJECT_ID('Branches', 'U') IS NOT NULL
	DROP TABLE Branches;
GO  
CREATE TABLE Branches
(
	BranchID int PRIMARY KEY IDENTITY(1,1),
	AddressID int NOT NULL,
	Name varchar(30),
	SeatRows int,
	SeatColumns int
)

IF OBJECT_ID('Expenses', 'U') IS NOT NULL
	DROP TABLE Expenses;
GO  
CREATE TABLE Expenses
(
	ExpenseID int PRIMARY KEY IDENTITY(1,1),
	BranchID int,
	ProductID int,
	Type varchar(30),
	CostPerMonth money
)

IF OBJECT_ID('Products', 'U') IS NOT NULL
	DROP TABLE Products;
GO  
CREATE TABLE Products
(
	ProductID int PRIMARY KEY IDENTITY(1,1),
	ExpenseID int,
	ProviderID int,
	ProductName varchar(30),
	PricePerUnit money
)

IF OBJECT_ID('Movies', 'U') IS NOT NULL
	DROP TABLE Movies;
GO  
CREATE TABLE Movies
(
	MovieID int PRIMARY KEY IDENTITY(1,1),
	StudioID int NOT NULL,
	Title varchar(30),
	Director varchar(30),
	LaunchDate date,
	MovieLength time(7),
	Genre varchar(30),
	Rating int
)

IF OBJECT_ID('Providers', 'U') IS NOT NULL
	DROP TABLE Providers;
GO 
CREATE TABLE Providers
(
	ProviderID int PRIMARY KEY IDENTITY(1,1),
	AddressID int NOT NULL,
	CompanyName varchar(30),
	PhoneNumber varchar(15),
	Fax varchar(20)
)

IF OBJECT_ID('Studios', 'U') IS NOT NULL
	DROP TABLE Studios;
GO 
CREATE TABLE Studios
(
	StudioID int PRIMARY KEY IDENTITY(1,1),
	ParentID int,
	StudioName varchar(30)
)

IF OBJECT_ID('Territories', 'U') IS NOT NULL
	DROP TABLE Territories;
GO 
CREATE TABLE Territories
(
	TerritoryID int PRIMARY KEY IDENTITY(1,1),
	Description varchar(30)
)

IF OBJECT_ID('Tickets', 'U') IS NOT NULL
	DROP TABLE Tickets;
GO 
CREATE TABLE Tickets
(
	TicketID int PRIMARY KEY IDENTITY(1,1),
	MovieID int,
	BranchID int,
	Discount int,
	TicketPrice int,
	Row int,
	Seat int,
	Date date
)

--IF OBJECT_ID('Studiouri Redundante', 'V') IS NOT NULL
--	DROP VIEW [Studiouri Redundante];
--GO 
--CREATE VIEW [Studiouri Redundante] AS
--SELECT S.StudioID, MAX(S.ParentID) AS ParentID, MAX(S.StudioName) AS StudioName
--FROM Studios S
--LEFT JOIN Movies M
--ON M.StudioID = S.StudioID
--GROUP BY S.StudioID
--HAVING COUNT(M.MovieID) =0

--IF OBJECT_ID('Angajați Pensionabili', 'V') IS NOT NULL
--	DROP VIEW [Angajați Pensionabili];
--GO 
--CREATE VIEW [Angajați Pensionabili] AS
--SELECT E.*
--FROM Employees E
--WHERE DATEDIFF(YEAR, GETDATE(), E.BirthDate) > 60

--IF OBJECT_ID('Profit Per Sucusală', 'V') IS NOT NULL
--	DROP VIEW [Profit Per Sucusală];
--GO 
--CREATE VIEW [Profit Per Sucusală] AS
--SELECT B.Name, (COUNT(T.TicketID) * 20 - COUNT(T.TicketID) * 20 * (AVG(T.Discount)/100)- SUM(E.CostPerMonth)) AS [Profit]
--FROM Branches B
--JOIN Tickets T
--ON T.BranchID = B.BranchID
--JOIN Expenses E
--ON E.BranchID = B.BranchID
--GROUP BY B.Name
--ORDER BY [Profit] DESC

--IF OBJECT_ID('Clienți Fideli', 'V') IS NOT NULL
--	DROP VIEW [Clienți Fideli];
--GO 
--CREATE VIEW [Clienți Fideli] AS
--SELECT C.FirstName, C.LastName, COUNT(T.TicketID) AS [Bilete Cumpărate]
--FROM Customers C
--JOIN Tickets T
--ON C.TicketID = T.TicketID
--GROUP BY C.FirstName, C.LastName, C.Regular
--HAVING C.Regular = 1

--IF OBJECT_ID('Cost Total', 'V') IS NOT NULL
--	DROP VIEW [Cost Total];
--GO 
--CREATE VIEW [Cost Total] AS
--SELECT E.Type, SUM(E.CostPerMonth) AS [Cost]
--FROM Expenses E
--JOIN Branches B
--ON E.BranchID = B.BranchID
--GROUP BY E.Type

--IF OBJECT_ID('Salarii', 'V') IS NOT NULL
--	DROP VIEW [Salarii];
--GO 
--CREATE VIEW [Salarii] AS
--SELECT E.EmployeeID, E.FirstName, E.LastName, E.Title, E.SalariuBrut,
--E.SalariuBrut /4 AS [Asigurare Socială]
--, E.SalariuBrut / 10 AS [Asigurări Sociale de Sănătate],
--(E.SalariuBrut - (E.SalariuBrut /4 +  E.SalariuBrut / 10 )) / 10 AS [Impozit pe Venit],
--E.Impozit, E.SalariuBrut - E.Impozit AS [Salariu Net]
--FROM Employees E


--CREATE PROCEDURE TicheteVândute AS
--SELECT COUNT(T.TicketID) AS [TicheteVândute]
--FROM Tickets T
--GO 


ALTER TABLE Addresses
	ADD CONSTRAINT FK_AddressTerritory
	FOREIGN KEY (TerritoryID) REFERENCES Territories(TerritoryID);

ALTER TABLE BranchID
	ADD CONSTRAINT FK_BranchAddress
	FOREIGN KEY (AddressID) REFERENCES Addresses(AddressID);

ALTER TABLE Customers
	ADD CONSTRAINT FK_CustomerTicket
	FOREIGN KEY (TicketID) REFERENCES Tickets(TicketID);

ALTER TABLE Employees
	ADD CONSTRAINT FK_EmployeeBranch
	FOREIGN KEY (BranchID) REFERENCES Branches(BranchID),
	CONSTRAINT FK_EmployeeAddress
	FOREIGN KEY (AddressID) REFERENCES Addresses(AddressID);

ALTER TABLE Expenses
	ADD CONSTRAINT FK_ExpenseBranch
	FOREIGN KEY (BranchID) REFERENCES Branches(BranchID),
	CONSTRAINT FK_ExpenseProducts
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID);

ALTER TABLE Movies
	ADD CONSTRAINT FK_MovieStudio
	FOREIGN KEY (StudioID) REFERENCES Studios(StudioID);

ALTER TABLE Products
	ADD CONSTRAINT FK_ProductProvider
	FOREIGN KEY (ProviderID) REFERENCES Providers(ProviderID);

ALTER TABLE Providers
	ADD CONSTRAINT FK_ProviderAddress
	FOREIGN KEY (AddressID) REFERENCES Addresses(AddressID);

ALTER TABLE Studios
	ADD CONSTRAINT FK_StudioParent
	FOREIGN KEY (ParentID) REFERENCES Studios(StudioID);

ALTER TABLE Tickets
	ADD CONSTRAINT FK_TicketMovie
	FOREIGN KEY (MovieID) REFERENCES Movies(MovieID), 
	CONSTRAINT FK_TicketBranch
	FOREIGN KEY (BranchID) REFERENCES Branches(BranchID);

	--Discount 100 la pensionari si copii, 15 la studenti si elevi si inca 5 la regulars

--1.
INSERT INTO Addresses( TerritoryID, County, City, Street, Number)
VALUES (3, N'Argeș', N'Pitești', N'Daciei',13)

--2.
INSERT INTO Movies(StudioID, Title, Director, LaunchDate, [MovieLength(minutes)], Genre, Rating)
VALUES (2, 'Joker','Todd Phillips','2019-10-02',122,'Drama',8)

--3.
INSERT INTO Employees(BranchID, AddressID, LastName, FirstName, BirthDate, HireDate, Title, Phone, SalariuBrut, Impozit)
VALUES(5,15,N'Roșu', N'Costin', '1990-06-09', '2019-06-22', N'Vânzător Snacks', '0767368544', 3109,  1289)

--4.
INSERT INTO Addresses( TerritoryID, County, City, Street, Number)
VALUES (3, N'Argeș', N'Mioveni', N'Revoluției',22)

--5.
INSERT INTO Addresses( TerritoryID, County, City, Street, Number)
VALUES (3, N'Argeș', N'Topoloveni', N'Scândurii',13)

--6.
INSERT INTO Tickets(MovieID, BranchID, Discount, Row,Seat,Date)
VALUES(32,2,0,2,4,'2019-10-02')

--7.
INSERT INTO Tickets(MovieID, BranchID, Discount, Row,Seat,Date)
VALUES(32,3,5,14,8,'2019-10-02')

--8.
INSERT INTO Addresses( TerritoryID, County, City, Street, Number)
VALUES (3, N'Argeș', N'Mioveni', N'Revoluției',24)

 --9.
 INSERT INTO Addresses( TerritoryID, County, City, Street, Number)
VALUES (3, N'Argeș', N'Câmpulung', N'Mihai Țerbea',10)

--10.
INSERT INTO Customers(TicketID, LastName, FirstName,Status, Regular)
VALUES (13,N'Marinescu',N'Vasile','Student',0)

--11.
INSERT INTO Customers(TicketID, LastName, FirstName,Status, Regular)
VALUES (33,N'Marian',N'Tudor','Adult',1)
SELECT * FROM Tickets
--12.
INSERT INTO Customers(TicketID, LastName, FirstName,Status, Regular)
VALUES (16,N'Stănescu',N'Codrin','Adult',1)

--13.
INSERT INTO Customers(TicketID, LastName, FirstName,Status, Regular)
VALUES (17,N'Codrea',N'Mihai','Adult',1)

--14.
INSERT INTO Customers(TicketID, LastName, FirstName,Status, Regular)
VALUES (18,N'Catană',N'Ionuț','Adult',1), (19,N'Scorsese',N'Matei','Adult',1)

--15.
INSERT INTO Employees(BranchID, AddressID, LastName, FirstName, BirthDate, HireDate, Title, Phone, SalariuBrut, Impozit)
VALUES(5,48,N'Calotă', N'Cătălin', '1993-02-15', '2019-06-22', N'Vânzător Snacks', '0767354384', 3109,  1289)

--1.Promovați angajații care lucrează de cel puțin 3 ani sub funcția de Asistent Manager la Manager
BEGIN TRAN

UPDATE Employees
SET Title = 'Manager'
WHERE Title = 'Asistent Manager' AND DATEDIFF(year, HireDate, GETDATE()) >=3

SELECT * FROM Employees

ROLLBACK

--2.Schimbați studiourile filmelor din studioul copil în părinte
BEGIN TRAN

UPDATE M
SET M.StudioID = S.ParentID
FROM Movies M
JOIN Studios S
ON M.StudioID = S.StudioID
WHERE S.ParentID IS NOT NULL AND M.StudioID IS NOT NULL

SELECT * FROM Movies

ROLLBACK

--3.Scadeți cu 10% salariul angajaților cu funcția de manager și creșteți cu 10%
BEGIN TRAN

SELECT * FROM Employees

UPDATE Employees
SET SalariuBrut = CASE
WHEN Title like '%Manager%' THEN SalariuBrut * 9 / 10
ELSE SalariuBrut * 11 / 10
END


SELECT * FROM Employees

ROLLBACK

--4.Treceți București ca localitate pentru adresele din teritoriul București
UPDATE A
SET A.County = N'București'
FROM Addresses A
JOIN Territories T
ON T.TerritoryID = A.TerritoryID
WHERE T.Description = N'București'

--5.Puneți studiourile fără părinte ca fiind propriul lor părinte
UPDATE Studios
SET ParentID = StudioID
WHERE ParentID is NULL

--6.Scade cu 50% costul pentru mâncare și 60% pentru băuturi
BEGIN TRAN

SELECT * FROM Expenses

UPDATE Expenses
SET CostPerMonth = CASE
WHEN Type = N'Mâncare' THEN CostPerMonth / 2
WHEN Type = N'Băutură' THEN CostPerMonth * 3 / 5
ELSE CostPerMonth
END

SELECT * FROM Expenses

ROLLBACK

--7.Creșteți cu 1 ratingul la filmele de tip dramă
BEGIN TRAN

SELECT * FROM Movies

UPDATE Movies
SET Rating = Rating + 1
WHERE Genre like '%Drama%' AND Rating < 10

SELECT * FROM Movies

ROLLBACK

--8.Schimbați teritoriul adreselor din București în Muntenia
BEGIN TRAN

SELECT * FROM Addresses

UPDATE Addresses
SET TerritoryID = 3
WHERE TerritoryID = 4

SELECT * FROM Addresses

ROLLBACK

--9.Schimbați unitatea de măsură a produselor din kg în grame
BEGIN TRAN

SELECT * FROM Products

UPDATE Products
SET Unit = 'g', PricePerUnit = PricePerUnit / 1000
WHERE Unit = 'Kg'

SELECT * FROM Products

ROLLBACK

--10.Schimbați numele de familie al unui angajat, datorită unei căsătorii
BEGIN TRAN

SELECT * FROM Employees WHERE LastName = 'Iliescu'

DECLARE @numeȘiPrenumeVechi NVARCHAR(30) = N'Șerbănescu Amalia';
DECLARE @numeNou NVARCHAR(30) = 'Iliescu';
UPDATE E
SET E.LastName = @numeNou
FROM Employees E
WHERE (E.LastName + ' ' + E.FirstName) = @numeȘiPrenumeVechi

SELECT * FROM Employees WHERE LastName = 'Iliescu'

ROLLBACK

--11.Adăugarea a 3 rânduri de locuri în cinematografele din București
BEGIN TRAN

SELECT * FROM Branches

UPDATE B
SET B.SeatRows = B.SeatRows + 3
FROM Branches B
JOIN Addresses A
ON A.AddressID = B.AddressID
WHERE A.TerritoryID = 4

SELECT * FROM Branches

ROLLBACK

--12.Scutirea de la plătirea impozitului a angajațiilor cu o vechime de peste 5 ani
BEGIN TRAN

SELECT * FROM Employees

UPDATE Employees
SET Impozit = 0
WHERE DATEDIFF(YEAR, HireDate,  GETDATE()) >=5

SELECT * FROM Employees

ROLLBACK

--13.Creșterea salariului cu 2% a angajaților din București
BEGIN TRAN

SELECT * FROM Employees

UPDATE E
SET SalariuBrut = SalariuBrut * 102 / 100
FROM Employees E
JOIN Addresses A
ON E.AddressID = A.AddressID
WHERE A.TerritoryID = 4

SELECT * FROM Employees

ROLLBACK

--14.Mutarea tuturor angajaților care lucrează la sucursalele din București
BEGIN TRAN

SELECT * FROM Employees JOIN Addresses ON Employees.AddressID = Addresses.AddressID

UPDATE A
SET A.County = N'București', A.City = N'București'
FROM Addresses A
JOIN Employees E
ON A.AddressID = E.AddressID
JOIN Branches B
ON E.BranchID = B.BranchID
JOIN Addresses AB
ON AB.AddressID = B.AddressID
WHERE AB.TerritoryID = 4

SELECT * FROM Employees JOIN Addresses ON Employees.AddressID = Addresses.AddressID

ROLLBACK

--15.Realculați discountul biletelor
BEGIN TRAN

SELECT *  FROM Tickets

UPDATE T
SET T.Discount = (CASE
	WHEN C.Regular = 1 THEN 5 
	WHEN C.Status like 'Pensionar' THEN 100 
	WHEN C.Status like 'Copil' THEN 100 
	ELSE 0 END) + (CASE 
	WHEN (C.Status like 'Student') THEN 15
	WHEN (C.Status like 'Elev') THEN 15
	ELSE 0 
	END)
FROM Tickets T
JOIN Customers C
ON C.TicketID = T.TicketID

SELECT *  FROM Tickets

ROLLBACK

--1.Arătați Numele angajaților care sunt din Transilvania
SELECT EmployeeID, LastName, FirstName, E.AddressID,A.County,A.City
FROM Employees E
JOIN Addresses A
ON E.AddressID = A.AddressID
JOIN Territories T
ON A.TerritoryID = T.TerritoryID
WHERE T.Description  = N'Transilvania'
ORDER BY EmployeeID

--2.Afișați toți clienții care au cumpărat bilete la filme produse de Universal Pictures sau Studiourile afiliate
SELECT CustomerID, LastName, FirstName,M.Title, S.StudioName
FROM Customers C
INNER JOIN Tickets T
ON C.TicketID = T.TicketID
INNER JOIN Movies M
ON T.MovieID = M.MovieID
INNER JOIN Studios S
ON M.StudioID = S.StudioID
WHERE S.StudioID = 4 OR S.ParentID = 4
ORDER BY CustomerID


--3.Afișați sucursalele care primesc produse din alte localități
CREATE PROCEDURE ProduseNonLocale
AS
SELECT B.BranchID, B.Name, A1.County AS 'Branch County', P2.CompanyName, A2.County AS 'Provider County'
FROM Branches B
JOIN Expenses E
ON B.BranchID = E.BranchID
JOIN Products P1
ON E.ProductID = P1.ProductID
JOIN Providers P2
ON P1.ProviderID = P2.ProviderID
JOIN Addresses A1
ON A1.AddressID = B.AddressID
JOIN Addresses A2
ON A2.AddressID = P2.AddressID
WHERE A1.County != A2.County
GO

EXEC ProduseNonLocale

--4.Ordonați regiunile după numărul de angajați din acestea
CREATE PROCEDURE AngajațiPerRegiune
AS
SELECT T.Description, COUNT(E.EmployeeID) AS [Număr de Angajați]
FROM Territories T
JOIN Addresses A
ON A.TerritoryID = T.TerritoryID
JOIN Employees E
ON E.AddressID = A.AddressID
GROUP BY T.Description
ORDER BY [Număr de Angajați] DESC
GO

EXEC AngajațiPerRegiune

--5. Arată adresele care nu sunt atribuite nicăieri și șterge-le
CREATE PROCEDURE AdreseRedundante
AS
SELECT *
FROM Addresses A
LEFT JOIN Employees E
ON A.AddressID = E.AddressID
LEFT JOIN Branches B
ON A.AddressID = B.AddressID
LEFT JOIN Providers P
ON A.AddressID = P.AddressID
WHERE (E.EmployeeID is NULL) AND (B.BranchID is NULL) AND (P.ProviderID is NULL)
GO

BEGIN TRAN

EXEC AdreseRedundante --Before

DELETE Addresses 
FROM Addresses A
LEFT JOIN Employees E
ON A.AddressID = E.AddressID
LEFT JOIN Branches B
ON A.AddressID = B.AddressID
LEFT JOIN Providers P
ON A.AddressID = P.AddressID
WHERE (E.EmployeeID is NULL) AND (B.BranchID is NULL) AND (P.ProviderID is NULL)

EXEC AdreseRedundante -- After

ROLLBACK

--6. Ordonați studiourile de filme în funcție de numărul de filmele produse
SELECT S.StudioName, COUNT(M.title) AS [Movies]
FROM Movies M
LEFT JOIN Studios S
ON M.StudioID = S.StudioID
WHERE S.StudioID IS NOT NULL
GROUP BY S.StudioName
ORDER BY [Movies] DESC

--7.Afișați numărul de tichete cumpărate de studenți în fiecare an
SELECT YEAR(T.Date) AS [An], COUNT(T.TicketID) AS [Număr de Tichete]
FROM Tickets T
JOIN Customers C
ON C.TicketID = T.TicketID
WHERE C.Status = 'Student'
GROUP BY YEAR(T.Date)

--8.Afișați furnizorii în funcție de tipurile de produse pe care le vând
SELECT P2.CompanyName, MAX(E.Type) AS [Tip de Produs]
FROM Expenses E
JOIN Products P1
ON E.ProductID = P1.ProductID
JOIN Providers P2
ON P1.ProviderID = P2.ProviderID
GROUP BY P2.CompanyName

--9.Ordonați furnizorii în funcție de costuri
SELECT P2.CompanyName, SUM(E.CostPerMonth)AS [Costuri]
FROM Expenses E
JOIN Products P1
ON E.ProductID = P1.ProductID
JOIN Providers P2
ON P1.ProviderID = P2.ProviderID
GROUP BY P2.CompanyName
ORDER BY [Costuri] DESC

--10.Ordonați funcțile angajaților după salariul net
SELECT E.Title, AVG(E.SalariuBrut - E.Impozit) AS [Media Salarilor Net]
FROM Employees E
GROUP BY E.Title
ORDER BY [Media Salarilor Net] DESC

--11.Calculați cantitatea de produse Consumată în fiecare lună
SELECT MAX(P2.CompanyName) as [Numele Companiei], P1.ProductName, (SUM(E.CostPerMonth) / MAX(P1.PricePerUnit)) AS [Cantitate], MAX(P1.Unit) as [Unitate de Măsură]
FROM Products P1
JOIN Expenses E
ON E.ProductID = P1.ProductID
JOIN Providers P2
ON P1.ProviderID = P2.ProviderID
GROUP BY P1.ProductName
ORDER BY MAX(P2.CompanyName)

--12.Afișați studiourile care au produs cel puțin 1 film prezente în baza de date
SELECT S.StudioName, COUNT(M.MovieID) AS [Filme]
FROM Movies M
JOIN Studios S
ON M.StudioID = S.StudioID
GROUP BY S.StudioName
HAVING COUNT(M.MovieID) > 0
ORDER BY [Filme]

--13.Afișați sucursalele care au vândut cel puțin 5 bilete
SELECT B.Name, COUNT(T.TicketID) as [Tichete Vândute]
FROM Branches B
JOIN Tickets T
ON T.BranchID = B.BranchID
GROUP BY B.Name
HAVING COUNT(T.TicketID)>4
ORDER BY [Tichete Vândute] DESC

--14.Afișați angajații cu salariul peste medie
SELECT (MAX(E.FirstName) + ' ' + MAX(E.LastName)) AS [Nume], E.SalariuBrut
FROM Employees E
GROUP BY E.SalariuBrut
HAVING E.SalariuBrut > (SELECT AVG(Employees.SalariuBrut) FROM Employees)

--15.Afișați angajații care lucrează de cel puțin 4 ani
SELECT MAX(E.FirstName) +' ' + MAX(E.LastName) AS [Nume], (YEAR(GETDATE()) - YEAR(MAX(E.HireDate))) AS [Ani De Muncă]
FROM Employees E
GROUP BY E.FirstName
HAVING (YEAR(GETDATE()) - YEAR(MAX(E.HireDate))) >= 4
ORDER BY [Ani De Muncă]

--16.Afișați angajații cu cel mai mare salariu comparat comparând pe cei cu aceeași funcție
SELECT E.FirstName, E.Title, E.SalariuBrut
FROM Employees E
GROUP BY E.Title, E.FirstName, E.SalariuBrut
HAVING MAX(E.SalariuBrut) = (SELECT MAX(E1.SalariuBrut) FROM Employees E1 WHERE E1.Title = E.Title)
ORDER BY E.SalariuBrut DESC

--17.Afișați cele mai costisitoare cheltuieli după tipul acestora
SELECT E1.Type, E1.CostPerMonth
FROM Expenses E1
JOIN Products P
ON E1.ProductID = E1.ProductID
WHERE E1.CostPerMonth = (SELECT MAX(CostPerMonth) FROM Expenses E2 WHERE E1.Type = E2.Type )
Group By E1.Type, E1.CostPerMonth
ORDER BY E1.CostPerMonth DESC

--18.Afișați studioul cu cele mai multe filme produse
SELECT TOP 1 S.StudioName, COUNT(M.MovieID) AS [Filme]
FROM Movies M
JOIN Studios S
ON M.StudioID = S.StudioID
GROUP BY S.StudioName
ORDER BY [Filme] DESC

--19.Afișați filmele care durează cel mai mult grupate după rating
SELECT M.Title, M.[MovieLength(minutes)], M.Rating
FROM Movies M
GROUP BY M.Rating, M.Title,  M.[MovieLength(minutes)]
HAVING M.[MovieLength(minutes)] = (SELECT MAX(M1.[MovieLength(minutes)]) FROM Movies M1 WHERE M.Rating = M1.Rating)

--20.Afișați directorii de filme si numărul de filme produse de aceștia
SELECT M.Director, COUNT(M.MovieID) AS [Filme Produse]
FROM Movies M
GROUP BY M.Director
ORDER BY [Filme Produse] DESC

--21.Afișați suma totală de plată pe lună pentru fiecare sucursală
SELECT B.Name, SUM(E.CostPerMonth) AS [Costuri Lunare]
FROM Branches B
JOIN Expenses E
ON B.BranchID = E.BranchID
GROUP BY B.Name

--22.Afișați numărul maxim de bilete care trebuie vândut de fiecare sucursală pentru a face un profit de 1000 de lei/lună pentru fiecare sucursală,
--având în vedere că prețul unui bilet este de 20 lei
SELECT B.Name, ((SUM(E.CostPerMonth) + 1000) * 5) / (100 - AVG(t.Discount)) AS [Număr Necesar de Bilete]
FROM Branches B
JOIN Expenses E
ON B.BranchID = E.BranchID
JOIN Tickets T
ON T.BranchID = T.TicketID
GROUP BY B.Name
ORDER BY [Număr Necesar de Bilete] DESC

--23.Ordonați teritoriile după numărul de clienți
SELECT T1.Description, COUNT(T2.TicketID) AS [Număr de Clienți]
FROM Territories T1
JOIN Addresses A
ON A.TerritoryID = T1.TerritoryID
JOIN Branches B
ON B.AddressID = A.AddressID
JOIN Tickets T2
ON T2.BranchID = B.BranchID
GROUP BY T1.Description
ORDER BY [Număr de Clienți] Desc

--24.Afișați numele și numărul de telefon angajaților care își serbează ziua de naștere
SELECT (E.FirstName + ' ' + E.LastName) AS [Nume], E.Phone
FROM Employees E
WHERE MONTH(E.BirthDate) = MONTH(GETDATE()) AND DAY(E.BirthDate) = DAY(GETDATE())

--25.Afișați biletele care expiră azi și cine le-a cumpărat
SELECT T.TicketID, B.Name, C.FirstName, C.LastName, M.Title AS [Movie Title], T.Date
FROM Tickets T
JOIN Movies M
ON M.MovieID = T.MovieID
JOIN Customers C
ON C.TicketID = T.TicketID
JOIN Branches B
ON B.BranchID = T.BranchID
WHERE YEAR(T.Date) = YEAR(GETDATE()) AND MONTH(T.Date) = MONTH(GETDATE()) AND DAY(T.Date) = DAY(GETDATE())


--1.Trigger pentru ștergerea studiourilor redundante
IF OBJECT_ID('Delete Studios', 'TR') is NOT NULL
	DROP TRIGGER [Delete Studios]
GO
CREATE TRIGGER [Delete Studios]
ON Movies
AFTER INSERT, DELETE, UPDATE
AS
BEGIN
	DELETE Studios
	FROM Studios
	JOIN [Studiouri Redundante]
	ON Studios.StudioID = [Studiouri Redundante].StudioID
	WHERE Studios.StudioID = [Studiouri Redundante].StudioID AND Studios.ParentID is NOT NULL
END

-- 2. Crearea unui trigger care verifică dacă s-a introdus o adresă duplicat
IF OBJECT_ID('Address Duplicate', 'TR') IS NOT NULL
	DROP TRIGGER [Address Duplicate];
GO
CREATE TRIGGER [Address Duplicate]
ON Addresses
AFTER INSERT, UPDATE
AS
BEGIN
	IF @@ROWCOUNT = 0 RETURN;
	SET NOCOUNT ON;
	IF EXISTS 
	(
		SELECT COUNT(*)
		FROM Inserted AS I
		JOIN Addresses AS A
		ON I.City = A.City
		GROUP BY A.City
		HAVING COUNT(*) > 1 
	)
	BEGIN
		PRINT 'Warning for duplicate address';
	END
END;

--3. Crearea unui trigger care afișează coloanele introduse sau updatate în tabelul Employees
IF OBJECT_ID('InsertOrUpdateTrigger', 'TR') IS NOT NULL 
	DROP TRIGGER InsertOrUpdateTrigger; 
GO
CREATE TRIGGER InsertOrUpdateTrigger
ON Employees
AFTER DELETE, INSERT, UPDATE
AS 
BEGIN
	IF @@ROWCOUNT = 0 RETURN;
	SET NOCOUNT ON;
	SELECT COUNT(*) AS 'Number of Inserted Rows' 
	FROM Inserted;
	SELECT COUNT(*) AS 'Number of Deleted Rows' 
	FROM Deleted;
END;

--4.Calcularea automată a prețurilor biletelor
IF OBJECT_ID('TicketPriceCalculator', 'TR') IS NOT NULL
	DROP TRIGGER TicketPriceCalculator;
GO
CREATE TRIGGER TicketPriceCalculator
ON Tickets
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE Tickets
	SET TicketPrice = 20 * Discount / 100
END;

--1.Ștergeți toți angajații pensionabil(care au vârsta de peste 60 de ani)
BEGIN TRAN

SELECT * FROM Employees

DELETE FROM Employees
WHERE DATEDIFF(YEAR,Employees.BirthDate,  GETDATE()) >= 60

SELECT * FROM Employees

ROLLBACK

--2.Ștergeți angajații din Vâlcea
BEGIN TRAN

SELECT * FROM Employees

DECLARE @județ NVARCHAR(30) = 'Vâlcea';
DELETE E
FROM Employees E
JOIN Addresses A
ON E.AddressID = A.AddressID
WHERE A.County = @județ

DELETE A
FROM Employees E
JOIN Addresses A
ON E.AddressID = A.AddressID
WHERE A.County = @județ

SELECT * FROM Employees
SELECT * FROM Addresses

ROLLBACK


--3.Ștergeți biletele care au expirat acum mai bine de 1 ani
BEGIN TRAN

SELECT * FROM Tickets

DECLARE @vechimeaBiletului int = 1;
UPDATE C
SET C.TicketID = NULL
FROM Customers C
JOIN Tickets T
ON T.TicketID = C.TicketID
WHERE DATEDIFF(YEAR,T.Date, GETDATE() ) >= @vechimeaBiletului

DELETE
FROM Tickets
WHERE DATEDIFF(YEAR,Tickets.Date, GETDATE() ) >= @vechimeaBiletului

SELECT * FROM Tickets

ROLLBACK

--4.Ștergeți filmele prduse de studioul Warner Bros
BEGIN TRAN

SELECT * FROM Movies 

DECLARE @studio NVARCHAR(30) = 'Warner Bros. Studios';

UPDATE T
SET T.MovieID = NULL
FROM Tickets T
JOIN Movies M
ON T.MovieID = M.MovieID
JOIN Studios S
ON M.StudioID = S.StudioID
WHERE S.StudioName = @studio

DELETE M
FROM Movies M
JOIN Studios S
ON M.StudioID = S.StudioID
WHERE S.StudioName = @studio

SELECT * FROM Movies

ROLLBACK

--5.Ștergeți providerul care consumă cel mai mult
BEGIN TRAN

SELECT * FROM Providers

DECLARE @numeProvider NVARCHAR(30) = 
	(
	SELECT MAX(P.CompanyName)
	FROM Providers P 
	JOIN Products P1
	ON P.ProviderID = P1.ProviderID
	JOIN Expenses E
	ON E.ProductID = P1.ProductID
	GROUP BY E.Type 
	HAVING SUM(E.CostPerMonth) = 
		(
		SELECT TOP 1 SUM(E1.CostPerMonth)
		FROM Expenses E1
		GROUP BY E1.Type
		ORDER BY SUM(E1.CostPerMonth) DESC
		)
	)

UPDATE P1
SET P1.ProviderID = NULL
FROM Products P1
JOIN Providers P2
ON P1.ProviderID = P2.ProviderID
WHERE P2.CompanyName = @numeProvider


DELETE P
FROM Providers P
WHERE P.CompanyName = @numeProvider

SELECT * FROM Providers

ROLLBACK

--6.Ștergeți anajații care plătesc cel mai mult impozit din fiecare funcție
BEGIN TRAN

SELECT * FROM Employees

DELETE E
FROM Employees E
WHERE E.Impozit = (
	SELECT MAX(E1.Impozit)
	FROM Employees E1
	WHERE E1.Title = E.Title
	GROUP BY E1.Title
	)

SELECT * FROM Employees

ROLLBACK

--7.Ștergeți angajații născuți în an bisect
BEGIN TRAN

SELECT * FROM Employees

DELETE FROM Employees
WHERE YEAR(Employees.BirthDate) % 4 = 0

SELECT * FROM Employees

ROLLBACK

--8.Ștergeți produsele din fiecare tip în afară de cele mai ieftine(excepție utilități)
BEGIN TRAN

SELECT * FROM Expenses

DELETE E
FROM Expenses E
WHERE E.Type != 'Utilitate' AND E.ExpenseID != (
	SELECT MIN(E1.ExpenseID)
	FROM Expenses E1
	GROUP BY E1.Type
	HAVING E1.Type = E.Type
	)

SELECT * FROM Expenses

ROLLBACK

--9.Ștergeți biletele vândute de sucursala City Cinema
BEGIN TRAN

SELECT * FROM Tickets

DECLARE @numeSucursala NVARCHAR(30) = 'City Cinema'

UPDATE C
SET C.TicketID = NULL
FROM Customers C
JOIN Tickets T
ON T.TicketID = C.TicketID
JOIN Branches B
ON B.BranchID = T.BranchID
WHERE B.Name = @numeSucursala

DELETE T
FROM Tickets T
JOIN Branches B
ON T.BranchID = B.BranchID
WHERE B.Name = @numeSucursala

SELECT * FROM Tickets

ROLLBACK

--10.Ștergeți clienții care nu sunt fideli
BEGIN TRAN

SELECT * FROM Customers

DELETE FROM Customers 
WHERE Regular = 0

SELECT * FROM Customers

ROLLBACK