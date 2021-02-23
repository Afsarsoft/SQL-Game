# SQL-Game
A Sample OLTP database for fictional Game production company. <br />

# Recommended Prerequisites
-https://github.com/Afsarsoft/SQL101 <br />
-https://github.com/Afsarsoft/SQL-AnimalShelter <br />

# Manual Installation 
1- In a new or existing SQL DB or Azure SQL DB, from "Script1" folder, install script CreateSchema.sql <br />
2- From "SP" folder install all SPs (ignore any warnings) <br />
3- From "Script2" folder, run all scripts starting with 01_% to 04_% <br />

# Automated Installation 
1- Create a folder "C:\game" <br />
2- Copy folders "Script1", "Script2" and "SP" in folder "C:\game" <br /> 
3- For SQL DB, change connection "DB_Connection" according to your environment and Run SSIS package BuildGameDB <br />
3- For Azure SQL DB, change connection "AzureDB_Connection" according to your environment and Run SSIS package BuildGameDBAzure <br />

