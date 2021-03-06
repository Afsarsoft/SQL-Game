SELECT TABLE_SCHEMA, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE  TABLE_TYPE = 'BASE TABLE'
    AND TABLE_SCHEMA = 'game'
    AND TABLE_NAME IN ('Discount', 'Game', 'GameTeam', 'Order', 'Partner', 'PartnerInfo', 'Retailer', 'Team', 'Type');