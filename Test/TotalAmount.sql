/*
SELECT MAX(D.Amount)
FROM game.Retailer R
    INNER JOIN game.Discount D
    ON R.RetailerID = D.RetailerID
WHERE  R.RetailerID = 1 AND
    20100 BETWEEN D.MinQuantity AND D.MaxQuantity
*/

/*
DECLARE @TotalAmount MONEY,
        @Message     VARCHAR(255);

SET @TotalAmount = 0;
SET @Message = '';

EXEC game.CalTotalAmount @GameID = 1,
@RetailerID = 1,
@Quantity = 110,
@Total =  @TotalAmount OUTPUT;

SET @Message = '@TotalAmount = ' + CONVERT(VARCHAR(10), @TotalAmount) + ' is the return value from SP game.CalTotalAmount.';
RAISERROR (@Message, 0,1) WITH NOWAIT;
*/

EXEC game.InsertOrder @GameID = 1,
                @RetailerID = 1,
                @Quantity = 200


SELECT *
FROM game.History
ORDER BY RowID DESC