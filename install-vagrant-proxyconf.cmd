@echo off
if [%1]==[] goto usage
if [%2]==[] goto usage

REM MAIN
cls
call ./host-scripts/set-host-proxy.cmd

vagrant plugin install vagrant-proxyconf

goto :eof

REM USAGE
:usage
@echo Usage: %0 ^<user^> ^<password^>
exit /B 1


