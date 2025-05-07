-- Backup the database (using mysqldump from the command line)
-- (syntax)
-- mysqldump -u username -p database_name > backup_file_name.sql
-- example 1 -  open cmd where you need backup and type that into command line or shell
mysqldump -u test01 -p foodAPP > backup_file_foodApp.sql
-- example 2 -  provide location itself
mysqldump -u test01 -p foodAPP > d://backup/backup_file_foodApp.sql

-- Restore the database (using mysql from the command line)
-- syntax
-- mysql -u username -p database_name < backup_file.sql
-- example 1 - open cmd in backup file location 
mysql -u test01 -p foodApp < backup_file_foodApp.sql
-- example 2 - select from locaion to restore
mysql -u test01 -p foodApp < d://backup/backup_file_foodApp.sql

