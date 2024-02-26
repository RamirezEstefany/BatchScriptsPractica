@echo off
setlocal enabledelayedexpansion
echo tabla del 5
for /l %%R in (1 , 1 ,10) do (
    set /a numero=%%R*5
    echo !numero!
)
pause