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
   (02, 'Sony', 'Tokyo', 'N/A', 'Japan', 'TBD'),
   (03, 'ABC Games', 'Dallas', 'Texas', 'USA', 'TBD')

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
SET @ErrorText = 'Failed INSERT to table Game!';
INSERT INTO game.Game
   (GameID, TypeID, PartnerID, Name, Price, Note)
VALUES
   (01, 01, 01, 'Game 01', 100, 'TBD'),
   (02, 01, 01, 'Game 02', 200, 'TBD'),
   (03, 01, 01, 'Game 03', 300, 'TBD'),
   (04, 02, 02, 'Game 04', 400, 'TBD'),
   (05, 02, 01, 'Game 05', 250, 'TBD'),
   (06, 01, 01, 'Game 06', 350, 'TBD'),
   (07, 01, 01, 'Game 07', 150, 'TBD'),
   (08, 01, 03, 'Game 08', 350, 'TBD')

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
