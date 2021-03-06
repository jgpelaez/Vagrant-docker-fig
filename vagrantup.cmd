@echo off
if [%1]==[] goto usage
if [%2]==[] goto usage

REM ## MAIN
cls
@echo calling vagrant up
call ./host-scripts/set-host-proxy.cmd %1 %2
set VAGRANT_HTTP_PROXY=http://%1:%2@158.169.131.13:8012 
set VAGRANT_HTTPS_PROXY=http://%1:%2@158.169.131.13:8012
set VAGRANT_NO_PROXY=localhost,127.0.0.1,webgate.ec.europa.eu,158.166.*,158.166.222.120

vagrant up
REM ## call to the reload because of the proxy
REM ## plugin, will modify the config files for docker
vagrant reload

goto :eof

REM USAGE
:usage
@echo Usage: %0 ^<user^> ^<password^>
exit /B 1