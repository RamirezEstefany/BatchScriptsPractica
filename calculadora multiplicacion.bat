@echo off
:MULTIPLICACION
set /p num1=ingrese el primer numero=
set /p num2=ingrese el segundo numero=
set /a mul=num1*num2
echo %num1%x%num2%=%mul%

IF %mul% GTR 12 (
    echo El resultado es mayor que 12
) ELSE IF %mul% LSS 12 (
    echo El resultado es menor que 12
) ELSE (
    echo El resultado es igual que 12 
)

goto MULTIPLICACION
pause