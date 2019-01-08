USE DevTest
GO

CREATE TYPE dbo.TabTypeA AS TABLE 
(
	ID INT NOT NULL,
	DirPath VARCHAR(1024) NOT NULL,
	FileCount INT NOT NULL
    PRIMARY KEY (ID)
)
GO

CREATE TABLE dbo.TableA 
(
	ID INT NOT NULL,
	DirPath VARCHAR(1024) NOT NULL,
	FileCount INT NOT NULL
    PRIMARY KEY (ID)
)
GO

CREATE PROCEDURE spInsertToTableA
	@tab TabTypeA READONLY
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.TableA
	SELECT t.ID, t.DirPath, t.FileCount FROM @tab t

END
GO

--Test
DECLARE @tab TabTypeA;
INSERT INTO @tab VALUES (2, 'c:\Temp\', 3)
EXEC dbo.spInsertToTableA @tab = @tab

select * from dbo.TableA

delete from dbo.TableA