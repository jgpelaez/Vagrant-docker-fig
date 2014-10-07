@echo off
if [%1]==[] goto usage
if [%2]==[] goto usage

REM MAIN
@echo calling vagrant reload

rem VAGRANT_HTTP_PROXY="http://%1:%2@158.169.131.13:8012" 
rem VAGRANT_HTTPS_PROXY="http://%1:%2@158.169.131.13:8012" 
set VAGRANT_NO_PROXY="localhost,127.0.0.1,webgate.ec.europa.eu,158.166.*" 

vagrant reload


goto :eof

REM USAGE
:usage
@echo Usage: %0 ^<user^> ^<password^>
exit /B 1


