-- TRUNCATE TABLE game.Retailer;
-- GO
-- TRUNCATE TABLE game.Discount;
-- GO
-- TRUNCATE TABLE game.[Order];
-- GO
-- TRUNCATE TABLE game.Game;
-- GO
-- TRUNCATE TABLE game.Type;
-- GO
-- TRUNCATE TABLE game.GameTeam;
-- GO
-- TRUNCATE TABLE game.Team;
-- GO
-- TRUNCATE TABLE game.Partner;
-- GO
-- TRUNCATE TABLE game.PartnerInfo;


SELECT *
FROM game.Game;

SELECT *
FROM game.Retailer;

SELECT *
FROM game.[Order];

EXEC game.InsertOrder @GameID = 1,
                @RetailerID = 1,
                @Quantity = 200;

EXEC game.InsertOrder @GameID = 2,
                @RetailerID = 2,
                @Quantity = 1100;

EXEC game.InsertOrder @GameID = 3,
                @RetailerID = 3,
                @Quantity = 1100;

EXEC game.InsertOrder @GameID = 4,
                @RetailerID = 4,
                @Quantity = 1000;

EXEC game.InsertOrder @GameID = 2,
                @RetailerID = 2,
                @Quantity = 100;

EXEC game.InsertOrder @GameID = 3,
                @RetailerID = 4,
                @Quantity = 100;

EXEC game.InsertOrder @GameID = 5,
                @RetailerID = 1,
                @Quantity = 10000;

EXEC game.InsertOrder @GameID = 3,
                @RetailerID = 2,
                @Quantity = 10000;

SELECT *
FROM game.[Order]

SELECT *
FROM game.History
ORDER BY RowID DESC