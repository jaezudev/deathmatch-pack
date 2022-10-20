@echo off
title Host DOOM game
set /p players="How many players (w/ host)? "
set /p port="Specify port (leave empty for default: "
if "%port%"=="" (
gzdoom -host %players% -deathmatch
) else (
gzdoom -host %players% -deathmatch -port %port%
)