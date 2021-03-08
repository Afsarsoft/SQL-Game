CREATE OR ALTER VIEW game.vPartner
AS
    SELECT P1.PartnerID, P1.Name, P2.Website, P2.City, P2.[State], P2.Country, P2.Note
    FROM game.Partner P1
        INNER JOIN game.PartnerInfo P2
        ON P1.PartnerID = P2.PartnerID;


