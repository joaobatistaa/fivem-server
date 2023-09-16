@echo off

echo JohnnyServer

color 02

IF EXIST %~dp0\cache\ (
rmdir /s /q %~dp0\cache\ 
)

%~dp0\..\server\FXServer.exe +exec server.cfg