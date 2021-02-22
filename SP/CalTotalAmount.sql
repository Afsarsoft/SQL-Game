CREATE OR ALTER PROCEDURE game.CalTotalAmount
    @GameID     TINYINT,
    @RetailerID TINYINT,
    @Quantity   INT,
    @Total      MONEY OUTPUT
AS
/***************************************************************************************************
File: CalTotalAmount.sql
----------------------------------------------------------------------------------------------------
Procedure:      game.CalTotalAmount
Create Date:    2021-03-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Calculates Total Amount for an Order 
Call by:        game.InsertOrder

Steps:          1- Find the Price for a Game
                2- Find the Discount for the Retailer based on the Quantitiy 
                3- Calcuate the output variable @Total
****************************************************************************************************
SUMMARY OF CHANGES
Date(yyyy-mm-dd)    Author              Comments
------------------- ------------------- ------------------------------------------------------------
****************************************************************************************************/
SET NOCOUNT ON;

DECLARE @ErrorText   VARCHAR(MAX),      
        @Message     VARCHAR(255),    
        @StartTime   DATETIME,
        @SP          VARCHAR(50),

        @RowCount       INT,
        @Price          MONEY,
        @Discount       TINYINT,
        @DiscountAmount MONEY;

BEGIN TRY;
SET @RowCount = 0;
SET @Price = 0;
SET @Discount = 0;
SET @DiscountAmount = 0;
SET @ErrorText = 'Unexpected ERROR in setting the variables!';

SET @SP = OBJECT_NAME(@@PROCID);
SET @StartTime = GETDATE();

SET @Message = 'Started SP ' + @SP + ' at ' + FORMAT(@StartTime , 'MM/dd/yyyy HH:mm:ss');   
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC game.InsertHistory @SP = @SP,
   @Status = 'Start',
   @Message = @Message;

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed SELECT from Game table!';

SET @Price = (SELECT Price
FROM game.Game
WHERE GameID = @GameID);
SET @RowCount = @@ROWCOUNT

IF @RowCount = 0
BEGIN
    SET @ErrorText = '@Price = '+ CONVERT(VARCHAR(10), @Price) + ' Not able to get needed value!. Rasing Error!';
    RAISERROR(@ErrorText, 16,1);
END;

SET @Message = '@Price = ' + CONVERT(VARCHAR(10), @Price) + ' calculated from game.Game for GameID '+ CONVERT(VARCHAR(10), @GameID) + '.';
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC game.InsertHistory @SP = @SP,
                        @Status = 'Run',
                        @Message = @Message;

-- SELECT @Price = Price
-- FROM game.Game
-- WHERE GameID = @GameID
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed SELECT from Retailer table!';

SET @Discount = (SELECT MAX(D.Amount)
FROM game.Retailer R
    INNER JOIN game.Discount D
    ON R.RetailerID = D.RetailerID
WHERE  R.RetailerID = @RetailerID AND
    @Quantity BETWEEN D.MinQuantity AND D.MaxQuantity);
SET @RowCount = @@ROWCOUNT

IF @RowCount = 0
BEGIN
    SET @ErrorText = '@Discount = '+ CONVERT(VARCHAR(10), @Discount) + ' Not able to get needed value!. Rasing Error!';
    RAISERROR(@ErrorText, 16,1);
END;

SET @Message = '@Discount = ' + CONVERT(VARCHAR(10), @Discount) + ' calculated from game.Retailer for @Quantity '+ CONVERT(VARCHAR(10), @Quantity) + '.';
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC game.InsertHistory @SP = @SP,
                        @Status = 'Run',
                        @Message = @Message;
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed calculating Total!';

SET @DiscountAmount =  ((@Price * @Quantity) * @Discount/100);
SET @Total = ((@Price * @Quantity) + @DiscountAmount);

SET @Message = '@Total = ' + CONVERT(VARCHAR(10), @Total) + '.';
RAISERROR (@Message, 0,1) WITH NOWAIT;
EXEC game.InsertHistory @SP = @SP,
                        @Status = 'Run',
                        @Message = @Message;
-------------------------------------------------------------------------------

SET @Message = 'Completed SP ' + @SP + '. Duration in minutes:  '    
      + CONVERT(VARCHAR(12), CONVERT(DECIMAL(6,2),datediff(mi, @StartTime, getdate())));    
RAISERROR (@Message, 0,1) WITH NOWAIT;    
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

