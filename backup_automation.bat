@echo off
setlocal

:: Define the password directly in the script (not recommended for security reasons)
set PGPASSWORD=seven7Seven@##

:: Define backup directory
set BACKUP_DIR=C:\Users\Admin\Desktop\db_backup_automation
if not exist %BACKUP_DIR% mkdir %BACKUP_DIR%

:: Fix time formatting issue
set HOUR=%TIME:~0,2%
if "%HOUR:~0,1%"==" " set HOUR=0%HOUR:~1,1%
set TIMESTAMP=%DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2%_%HOUR%-%TIME:~3,2%-%TIME:~6,2%
set BACKUP_FILE=%BACKUP_DIR%\backup_%TIMESTAMP%.backup

:: Find PostgreSQL installation path dynamically
for /d %%D in ("C:\Program Files\PostgreSQL\*") do set PG_PATH=%%D

:: Run pg_dump to create a .backup file (Custom format)
"%PG_PATH%\bin\pg_dump.exe" -U postgres -h localhost -p 5432 -F c -b -v -f %BACKUP_FILE% trial

echo Backup completed: %BACKUP_FILE%

endlocal
