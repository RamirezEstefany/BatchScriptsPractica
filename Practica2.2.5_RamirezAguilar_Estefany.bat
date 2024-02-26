@echo off
setlocal enabledelayedexpansion
set "infousuarios=infousuarios.txt"

:menu
cls
echo ========== MENU PRINCIPAL ===========
echo 1 - REGISTRARSE 
echo 2 - INICIAR SESION 
echo 3 - SALIR
echo ======================================

REM SOLICITAMOS AL USUARIO SELECIONAR UNA OPCION CON EL SIGUIENTE COMANDO :
set /p opcion=ingrese una opcion y presione Enter :

if "%opcion%"=="1" goto :REGISTRARSE
if "%opcion%"=="2" goto :INICIARSESION
if "%opcion%"=="3" exit


REM MENSAJE DE ERROR EN CASO DE NO SELECCIONAR UNA OPCION CORRECTA 
echo opcion invalida, intente de nuevo, pulsa cualquier tecla para volver al menu

REM UTILIZAMOS COMANDO TIMEOUT O TIEMPO DE ESPERA CON 
REM /nobreak que evita que el usuario interrumpa el tiempo de espera presionando una tecla
REM /t que especifica el tiempo de espera 
REM >nul que significa que no se muestre ningun mensaje de tiempo de espera e la pantalla 
REM ME INFORMO DE ESTE UN COMPAÑERO Y POR NO ROBARLE EL MERITO DECIDI NO UTILIZARLO Y SEGUIR CON PAUSE
timeout /nobreak /t 1 >nul
goto menu 



:REGISTRARSE
cls
ECHO       REGISTRO
ECHO  ===================
SET /P USUARIO=INTRODUZCA UN NOMBRE DE USUARIO :
SET /P CONTRASEÑA=INTRODUZCA UNA CONTRASEÑA :
SET /P PASS=CONFIRME LA CONTRASEÑA :

REM VERIFICACION DE CONTRASENAS
IF "%PASS%" NEQ "%CONTRASEÑA%"  (
  ECHO CONTRASEÑA INVALIDA
  pause
  goto REGISTRARSE
)

REM GUARDAMOS LA INFORMACION DE LOS USUARIOS
echo %USUARIO%:%CONTRASEÑA%>> infousuarios.txt
 echo Se ha registrado con exito.
 pause
goto menu

:INICIARSESION
cls
REM SOLICITAMOS LOS DATOS DE INICIO DE SESION DEL USUARIO 
SET /P NOM_USUARIO=INGRESE SU NOMBRE DE USUARIO :
SET /P CONTRASEÑA=INGRESE SU CONTRASEÑA :

findstr /b /c:"%NOM_USUARIO%:%CONTRASEÑA%" "%infousuarios%">nul
REM MENSAJE DE USUARIO NO ENCONTRADO 
IF %errorlevel% EQU 0 (
    echo ¡¡Bienvenido!!
    pause
    goto iniciosesion2
) else (
    echo Nombre de usuario o contraseña incorrectos.
    pause
    goto menu
)

:InicioSesion2
cls
REM Solicitar al usuario que ingrese una opcion posterior al inicio de sesion 
echo     OPCIONES
echo ================
echo  1. Modificar contraseña
echo  2. Eliminar usuario
echo  3. Cerrar sesión

set /p opcion=Seleccione una opción:

IF "%opcion%"=="1" goto :ModificarContraseña
IF "%opcion%"=="2" goto :EliminarUsuario
IF "%opcion%"=="3" goto menu

ECHO opcion invalida. Intentelo de nuevo 
pause 
goto InicioSesion2

:ModificarContraseña
cls
REM SOLICITMOS AL USUARIO UN NUEVO INGRESO DE CONTRASEÑA
set /p nueva_contraseña=NUEVA CONTRASEÑA :

REM ACTUALIZMOS LA CONTRASEÑA EN EL ARCHIVO ANTERIOR "INFOUSUARIOS.TXT".
 FOR /f "tokens=1,* delims=:" %%a in ('type "%infousuarios%"') do (
    if "%%a"=="%NOM_USUARIO%" (
        echo %NOM_USUARIO%:%nueva_contraseña%
    ) else (
        echo %%a:%%b
    )
    REM CREAMOS UN ARCHIVO TEMPORAL PARA MODIFICAR LA CONTRASEÑA Y LUEGO PASA A "INFOUSUARIOS.TXT".
 ) >"%infousuarios%.tmp"

REM "MOVE /Y" mueve el archivo especificado sin pedir confirmación si un archivo con el mismo nombre ya existe en el destino. 
del "%infousuarios%"
rename "%infousuarios%.tmp" "%infousuarios%"
echo Modificacion de contraseña exitosamente.
pause
goto menu

:EliminarUsuario
cls
REM Eliminamos el usuario de infousuarios.txt.
for /f "tokens=1,* delims=:" %%a in ('type "%infousuarios%"') do (
    if not "%%a"=="%NOM_USUARIO%" (
        echo %%a:%%b
    )
) >"%infousuarios%.tmp"
del "%infousuarios%"
rename "%infousuarios%.tmp" %infousuarios%
echo El usuario se elimino  exitosamente.
echo Gracias por usar el programa.
pause 
goto menu