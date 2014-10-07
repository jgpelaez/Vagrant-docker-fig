@echo off
if [%1]==[] goto usage
if [%2]==[] goto usage

REM MAIN
@echo setting proxy
set http_proxy=http://%1:%2@158.169.131.13:8012/

goto :eof

REM USAGE
:usage
@echo Usage: %0 ^<user^> ^<password^>
exit /B 1


