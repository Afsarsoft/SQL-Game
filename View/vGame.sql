CREATE OR ALTER VIEW game.vGame
AS
    SELECT G.GameID, G.Name, T.Name AS GameType, P.Name AS Partner, G.Note
    FROM game.Game G
        INNER JOIN game.vPartner P
        ON G.PartnerID = P.PartnerID
        INNER JOIN game.Type T
        ON G.TypeID = T.TypeID



