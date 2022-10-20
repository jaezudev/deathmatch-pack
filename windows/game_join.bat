@echo off
title Join DOOM game
set /p ip="Enter IP address: "
set /p port="Specify port (leave empty for default): "
if "%port%"=="" (
gzdoom -join %ip%
) else (
gzdoom -join %ip% -port %port%
)