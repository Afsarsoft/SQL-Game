/***************************************************************************************************
File: 03_InsertTables.sql
----------------------------------------------------------------------------------------------------
Create Date:    2020-09-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Inserts needed rows to few tables 
Call by:        TBD, Add hoc
Steps:          N/A 
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

SET @SP = 'Script-03_InsertTables';
SET @StartTime = GETDATE();

SET @Message = 'Started SP ' + @SP + ' at ' + FORMAT(@StartTime , 'MM/dd/yyyy HH:mm:ss');   
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC game.InsertHistory @SP = @SP,
   @Status = 'Start',
   @Message = @Message;

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed INSERT to table Partner!';
INSERT INTO game.Partner
   (PartnerID, Name)
VALUES
   (01, 'Microsoft'),
   (02, 'Sony'),
   (03, 'ABC Games')

SET @Message = CONVERT(VARCHAR(10), @@ROWCOUNT) + ' rows effected. Completed INSERT to table Partner';   
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC game.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed INSERT to table PartnerInfo!';
INSERT INTO game.PartnerInfo
   (PartnerID, Website, City, [State], Country, Note)
VALUES
   (01, 'www.microsoft.com', 'Redmond', 'WA', 'USA', 'TBD'),
   (02, 'www.sony.com', 'Tokyo', 'N/A', 'Japan', 'TBD'),
   (03, 'www.abcgame.com', 'Dallas', 'Texas', 'USA', 'TBD')

SET @Message = CONVERT(VARCHAR(10), @@ROWCOUNT) + ' rows effected. Completed INSERT to table PartnerInfo';   
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC game.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed INSERT to table Retailer!';
INSERT INTO game.Retailer
   (RetailerID, Name, Website, Address, City, Zip)
VALUES
   (01, 'Costco', 'www.costco.com', 'TBD', 'Bellevue', '98006'),
   (02, 'Amazon', 'www.amazon.com', 'TBD', 'Seattle', '98004'),
   (03, 'Best Buy', 'www.bestbuy.com', 'TBD', 'TBD', 'TBD'),
   (04, 'Target', 'www.trget.com', 'TBD', 'TBD', 'TBD')

SET @Message = CONVERT(VARCHAR(10), @@ROWCOUNT) + ' rows effected. Completed INSERT to table PartnerInfo';   
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC game.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed INSERT to table Discount!';
INSERT INTO game.Discount
   (DiscountID, RetailerID, Name, MinQuantity, MaxQuantity, Amount)
VALUES
   (01, 01, 'Costco Low Order', 100, 1000, 5),
   (02, 01, 'Costco Mid Order', 1000, 10000, 7),
   (03, 01, 'Costco High Order', 10000, 100000, 10),
   (04, 02, 'Amazon Low Order', 100, 1000, 2),
   (05, 02, 'Amazon Mid Order', 1000, 10000, 4),
   (06, 02, 'Amazon High Order', 10000, 100000, 6),
   (07, 03, 'Best Buy Low Order', 100, 1000, 3),
   (08, 03, 'Best Buy Mid Order', 1000, 10000, 5),
   (09, 03, 'Best Buy High Order', 10000, 100000, 7),
   (10, 04, 'Target Low Order', 100, 1000, 4),
   (11, 04, 'Target Mid Order', 1000, 10000, 5),
   (12, 04, 'Target High Order', 10000, 100000, 6)

SET @Message = CONVERT(VARCHAR(10), @@ROWCOUNT) + ' rows effected. Completed INSERT to table PartnerInfo';   
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC game.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed INSERT to table Game!';
INSERT INTO game.Game
   (GameID, TypeID, PartnerID, Name, Price, Note)
VALUES
   (01, 01, 01, 'Game 01', 100, 'TBD'),
   (02, 01, 01, 'Game 02', 200, 'TBD'),
   (03, 01, 01, 'Game 03', 300, 'TBD'),
   (04, 02, 02, 'Game 04', 400, 'TBD'),
   (05, 03, 01, 'Game 05', 250, 'TBD')

SET @Message = CONVERT(VARCHAR(10), @@ROWCOUNT) + ' rows effected. Completed INSERT to table Game';   
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC game.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed INSERT to table GameTeam!';
INSERT INTO game.GameTeam
   (GameID, TeamID, RoyaltyPer)
VALUES
   (01, 01, 100),
   (01, 02, 200),
   (01, 03, 300),

   (02, 01, 100),
   (02, 02, 200),

   (03, 01, 100),
   (03, 02, 200),
   (03, 03, 300),

   (04, 01, 100),
   (04, 02, 200),

   (05, 01, 100)


SET @Message = CONVERT(VARCHAR(10), @@ROWCOUNT) + ' rows effected. Completed INSERT to table Game';   
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC game.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed INSERT to table Team!';
INSERT INTO game.Team
   (TeamID, Name, Note)
VALUES
   (01, 'Team A', 'Doing Basic Stuff'),
   (02, 'Team B', 'Doing Average Stuff'),
   (03, 'Team C', 'Doing Advance Stuff')

SET @Message = CONVERT(VARCHAR(10), @@ROWCOUNT) + ' rows effected. Completed INSERT to table Game';   
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC game.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed INSERT to table Type!';
INSERT INTO game.Type
   (TypeID, Name, Note)
VALUES
   (01, 'Action', 'Action stuff'),
   (02, 'Romantic', 'Romantic Stuff'),
   (03, 'Kids Learning', 'Kids Learning')

SET @Message = CONVERT(VARCHAR(10), @@ROWCOUNT) + ' rows effected. Completed INSERT to table Game';   
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC game.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
-------------------------------------------------------------------------------


SET @Message = 'Completed SP ' + @SP + '. Duration in minutes:  '   
   + CONVERT(VARCHAR(12), CONVERT(DECIMAL(6,2),datediff(mi, @StartTime, getdate())));    
RAISERROR(@Message, 0,1) WITH NOWAIT;
EXEC game.InsertHistory @SP = @SP,
   @Status = 'End',
   @Message = @Message;

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
   @Message = @ErrorText;

RAISERROR(@ErrorText,18,127) WITH NOWAIT;
END CATCH;      
