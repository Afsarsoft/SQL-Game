CREATE OR ALTER PROCEDURE game.CreateHistoryTable
AS
/***************************************************************************************************
File: CreateHistoryTable.sql
----------------------------------------------------------------------------------------------------
Procedure:      game.CreateHistoryTable
Create Date:    2021-03-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Creates game.History table  
Call by:        TBD, UI, Add hoc
Steps:          NA
Parameter(s):   None
Usage:          EXEC game.CreateHistoryTable
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

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed Creating game.History table.';

IF OBJECT_ID('game.History', 'U') IS NOT NULL
    DROP TABLE game.History

CREATE TABLE game.History
(
    RowID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Time CHAR(19) NOT NULL,
    SP VARCHAR(50) NOT NULL,
    -- Start, End, Run, Error
    Status VARCHAR(5) NOT NULL,
    Message VARCHAR(MAX) NOT NULL
);

SET @Message = 'Completed Creating table game.History ' ;   
RAISERROR(@Message, 0,1) WITH NOWAIT;
-------------------------------------------------------------------------------

SET @Message = 'Completed SP ' + @SP + 'Duration in minutes:  '   
   + CONVERT(VARCHAR(12), CONVERT(DECIMAL(6,2),datediff(mi, @StartTime, getdate())));    
RAISERROR(@Message, 0,1) WITH NOWAIT;
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

   RAISERROR(@ErrorText,18,127) WITH NOWAIT;      
END CATCH;      

