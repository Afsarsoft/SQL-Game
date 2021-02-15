CREATE OR ALTER PROCEDURE game.CreateFKs
AS
/***************************************************************************************************
File: CreateFKs.sql
----------------------------------------------------------------------------------------------------
Procedure:      game.CreateFKs
Create Date:    2021-03-01 (yyyy-mm-dd)
Author:         Surush Cyrus
Description:    Creates FKs for all needed game tables  
Call by:        TBD, UI, Add hoc
Steps:          NA
Parameter(s):   None
Usage:          EXEC game.CreateFKs
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
SET @ErrorText = 'Failed adding FOREIGN KEY for Table game.Game.';

IF EXISTS (SELECT *
FROM sys.foreign_keys
WHERE object_id = OBJECT_ID(N'game.FK_Game_Type_TypeID')
  AND parent_object_id = OBJECT_ID(N'game.Game')
)
BEGIN
  SET @Message = 'FOREIGN KEY for Table game.Game already exist, skipping....';
  RAISERROR(@Message, 0,1) WITH NOWAIT;
  EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
  ALTER TABLE game.Game
   ADD CONSTRAINT FK_Game_Type_TypeID FOREIGN KEY (TypeID)
      REFERENCES game.Type (TypeID),
      CONSTRAINT FK_Game_Partner_PartnerID FOREIGN KEY (PartnerID)
  REFERENCES game.Partner (PartnerID);

  SET @Message = 'Completed adding FOREIGN KEY for TABLE game.Game.';
  RAISERROR(@Message, 0,1) WITH NOWAIT;
  EXEC game.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed adding FOREIGN KEY for Table game.GameTeam.';

IF EXISTS (SELECT *
FROM sys.foreign_keys
WHERE object_id = OBJECT_ID(N'game.FK_GameTeam_Game_GameID')
  AND parent_object_id = OBJECT_ID(N'game.GameTeam')
)
BEGIN
  SET @Message = 'FOREIGN KEY for Table game.GameTeam already exist, skipping....';
  RAISERROR(@Message, 0,1) WITH NOWAIT;
  EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
  ALTER TABLE game.GameTeam
   ADD CONSTRAINT FK_GameTeam_Game_GameID FOREIGN KEY (GameID)
      REFERENCES game.Game (GameID),
      CONSTRAINT FK_GameTeam_Team_TeamID FOREIGN KEY (TeamID)
  REFERENCES game.Team (TeamID);

  SET @Message = 'Completed adding FOREIGN KEY for TABLE game.GameTeam.';
  RAISERROR(@Message, 0,1) WITH NOWAIT;
  EXEC game.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed adding FOREIGN KEY for Table game.PartnerInfo.';

IF EXISTS (SELECT *
FROM sys.foreign_keys
WHERE object_id = OBJECT_ID(N'game.FK_PartnerInfo_Partner_PartnerID')
  AND parent_object_id = OBJECT_ID(N'game.PartnerInfo')
)
BEGIN
  SET @Message = 'FOREIGN KEY for Table game.PartnerInfo already exist, skipping....';
  RAISERROR(@Message, 0,1) WITH NOWAIT;
  EXEC game.InsertHistory @SP = @SP,
        @Status = 'Run',
        @Message = @Message;
END
ELSE
BEGIN
  ALTER TABLE game.PartnerInfo
   ADD CONSTRAINT FK_PartnerInfo_Partner_PartnerID FOREIGN KEY (PartnerID)
       REFERENCES game.Partner (PartnerID);

  SET @Message = 'Completed adding FOREIGN KEY for TABLE game.PartnerInfo.';
  RAISERROR(@Message, 0,1) WITH NOWAIT;
  EXEC game.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
END
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
SET @ErrorText = 'Failed adding FOREIGN KEY for Table game.Order.';

IF EXISTS (SELECT *
FROM sys.foreign_keys
WHERE object_id = OBJECT_ID(N'game.FK_Order_Retailer_RetailerID')
  AND parent_object_id = OBJECT_ID(N'game.Order')
)
BEGIN
  SET @Message = 'FOREIGN KEY for Table game.Order already exist, skipping....';
  RAISERROR(@Message, 0,1) WITH NOWAIT;
  EXEC game.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
END
ELSE
BEGIN
  ALTER TABLE game.[Order]
   ADD CONSTRAINT FK_Order_Retailer_RetailerID FOREIGN KEY (RetailerID)
      REFERENCES game.Retailer (RetailerID),
    CONSTRAINT FK_Order_Game_GameID FOREIGN KEY (GameID)
      REFERENCES game.Game (GameID);

  SET @Message = 'Completed adding FOREIGN KEY for TABLE game.Order.';
  RAISERROR(@Message, 0,1) WITH NOWAIT;
  EXEC game.InsertHistory @SP = @SP,
   @Status = 'Run',
   @Message = @Message;
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

