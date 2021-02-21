CREATE OR ALTER PROCEDURE game.CreateTables
AS
/***************************************************************************************************
File: CreateTables.sql
----------------------------------------------------------------------------------------------------
Procedure:      game.CreateTables
Create Date:    2021-03-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Creates all needed game tables  
Call by:        TBD, UI, Add hoc
Steps:          NA
Parameter(s):   None
Usage:          EXEC game.CreateTables
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
****************************************************************************************************/
SET NOCOUNT ON;

DECLARE @ErrorText VARCHAR(MAX),      
        @Message   VARCHAR(255),   
        @StartTime DATETIME,
        @SP        VARCHAR(50)

BEGIN TRY;   
SET @ErrorText = 'Unexpected ERROR in setting the variables!';  

SET @SP = OBJECT_NAME(@@PROCID)
SET @StartTime = GETDATE();    
SET @Message = 'Started SP ' + @SP + ' at ' + FORMAT(@StartTime , 'MM/dd/yyyy HH:mm:ss');  
 
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC game.InsertHistory @SP = @SP,
    @Status = 'Start',
    @Message = @Message;


-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table game.Retailer.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'game.Retailer') AND type in (N'U'))
BEGIN
    SET @Message = 'Table game.Retailer already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
    CREATE TABLE game.Retailer
    (
        RetailerID TINYINT NOT NULL,
        Name NVARCHAR(50) NOT NULL,
        Website NVARCHAR(50) NOT NULL,
        Address NVARCHAR(50) NOT NULL,
        City NVARCHAR(50) NOT NULL,
        Zip NVARCHAR(50) NOT NULL,
        CONSTRAINT PK_Retailer_RetailerID PRIMARY KEY CLUSTERED (RetailerID),
        CONSTRAINT UK_Retailer_Name UNIQUE (Name)
    );

    SET @Message = 'Completed CREATE TABLE game.Retailer.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table game.Discount.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'game.Discount') AND type in (N'U'))
BEGIN
    SET @Message = 'Table game.Discount already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
    CREATE TABLE game.Discount
    (
        DiscountID TINYINT NOT NULL,
        RetailerID TINYINT NOT NULL,
        Name NVARCHAR(50) NOT NULL,
        MinQuantity INT NOT NULL,
        MaxQuantity INT NOT NULL,
        Amount TINYINT NOT NULL,
        CONSTRAINT PK_Discount_DiscountID PRIMARY KEY CLUSTERED (DiscountID),
        CONSTRAINT UK_Discount_Name UNIQUE (Name)
    );

    SET @Message = 'Completed CREATE TABLE game.Discount.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table game.Order.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'game.Order') AND type in (N'U'))
BEGIN
    SET @Message = 'Table game.Order already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
    CREATE TABLE game.[Order]
    (
        OrderID INT NOT NULL,
        GameID TINYINT NOT NULL,
        RetailerID TINYINT NOT NULL,
        OrderDate DATETIME NOT NULL,
        Quantity INT NOT NULL,
        TotalAmount MONEY NOT NULL,
        CONSTRAINT PK_Order_StoreID PRIMARY KEY CLUSTERED (OrderID)
    );

    SET @Message = 'Completed CREATE TABLE game.Order.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table game.Game.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'game.Game') AND type in (N'U'))
BEGIN
    SET @Message = 'Table game.Game already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
    CREATE TABLE game.Game
    (
        GameID TINYINT NOT NULL,
        TypeID TINYINT NOT NULL,
        PartnerID TINYINT NOT NULL,
        Name NVARCHAR(50) NOT NULL,
        Price MONEY NOT NULL,
        Note NVARCHAR(250) NOT NULL,
        CONSTRAINT PK_Game_GameID PRIMARY KEY CLUSTERED (GameID),
        CONSTRAINT UK_Game_Name UNIQUE (Name)
    );

    SET @Message = 'Completed CREATE TABLE game.Game.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table game.Type.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'game.Type') AND type in (N'U'))
BEGIN
    SET @Message = 'Table game.Type already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
    CREATE TABLE game.Type
    (
        TypeID TINYINT NOT NULL,
        Name NVARCHAR(50) NOT NULL,
        Note NVARCHAR(250) NOT NULL,
        CONSTRAINT PK_Type_TypeID PRIMARY KEY CLUSTERED (TypeID),
        CONSTRAINT UK_Type_Name UNIQUE (Name)
    );

    SET @Message = 'Completed CREATE TABLE game.Type.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table game.GameTeam.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'game.GameTeam') AND type in (N'U'))
BEGIN
    SET @Message = 'Table game.GameTeam already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
    CREATE TABLE game.GameTeam
    (
        GameID TINYINT NOT NULL,
        TeamID TINYINT NOT NULL,
        RoyaltyPer MONEY NOT NULL,
        CONSTRAINT PK_GameTeam_GameIDTeamID PRIMARY KEY CLUSTERED (GameID, TeamID)
    );

    SET @Message = 'Completed CREATE TABLE game.GameTeam.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table game.Team.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'game.Team') AND type in (N'U'))
BEGIN
    SET @Message = 'Table game.Team already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
    CREATE TABLE game.Team
    (
        TeamID TINYINT NOT NULL,
        Name NVARCHAR(50) NOT NULL,
        Note NVARCHAR(250) NOT NULL,
        CONSTRAINT PK_Team_TeamID PRIMARY KEY CLUSTERED (TeamID),
        CONSTRAINT UK_Team_Name UNIQUE (Name)
    );

    SET @Message = 'Completed CREATE TABLE game.Team.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table game.Partner.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'game.Partner') AND type in (N'U'))
BEGIN
    SET @Message = 'Table game.Partner already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
    CREATE TABLE game.Partner
    (
        PartnerID TINYINT NOT NULL,
        Name NVARCHAR(50) NOT NULL,
        CONSTRAINT PK_Partner_PartnerID PRIMARY KEY CLUSTERED (PartnerID),
        CONSTRAINT UK_Partner_Name UNIQUE (Name)
    );

    SET @Message = 'Completed CREATE TABLE game.Partner.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed CREATE Table game.PartnerInfo.';

IF EXISTS (SELECT *
FROM sys.objects
WHERE object_id = OBJECT_ID(N'game.PartnerInfo') AND type in (N'U'))
BEGIN
    SET @Message = 'Table game.PartnerInfo already exist, skipping....';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
    CREATE TABLE game.PartnerInfo
    (
        PartnerID TINYINT NOT NULL,
        Website NVARCHAR(50) NOT NULL,
        City NVARCHAR(50) NOT NULL,
        State NVARCHAR(50) NOT NULL,
        Country NVARCHAR(50) NOT NULL,
        Note NVARCHAR(250) NOT NULL,
        CONSTRAINT PK_PartnerInfo_PartnerID PRIMARY KEY CLUSTERED (PartnerID)
    );

    SET @Message = 'Completed CREATE TABLE game.PartnerInfo.';
    RAISERROR(@Message, 0,1) WITH NOWAIT;
    EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message
END
-------------------------------------------------------------------------------


SET @Message = 'Completed SP ' + @SP + '. Duration in minutes:  '   
   + CONVERT(VARCHAR(12), CONVERT(DECIMAL(6,2),datediff(mi, @StartTime, getdate())));   
RAISERROR(@Message, 0,1) WITH NOWAIT;
EXEC game.InsertHistory @SP = @SP,
    @Status = 'End',
    @Message = @Message

END TRY

BEGIN CATCH;
IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;

SET @ErrorText = 'Error: '+CONVERT(VARCHAR,ISNULL(ERROR_NUMBER(),'NULL'))      
                  +', Severity = '+CONVERT(VARCHAR,ISNULL(ERROR_SEVERITY(),'NULL'))      
                  +', State = '+CONVERT(VARCHAR,ISNULL(ERROR_STATE(),'NULL'))      
                  +', Line = '+CONVERT(VARCHAR,ISNULL(ERROR_LINE(),'NULL'))      
                  +', Procedure = '+CONVERT(VARCHAR,ISNULL(ERROR_PROCEDURE(),'NULL'))      
                  +', Server Error Message = '+CONVERT(VARCHAR(100),ISNULL(ERROR_MESSAGE(),'NULL'))      
                  +', SP Defined Error Text = '+@ErrorText;

EXEC game.InsertHistory @SP = @SP,
   @Status = 'Error',
   @Message = @ErrorText

RAISERROR(@ErrorText,18,127) WITH NOWAIT;
END CATCH;      

