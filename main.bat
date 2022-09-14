@ECHO OFF
CHCP 65001
TITLE Afficher le mot de passe WiFi enregistré

:begin
test&cls

ECHO Bienvenue dans l'utilitaire permettant de retrouver un mot de passe WiFi enregistré. 
ECHO.
ECHO Veuillez saisir le nom exact de la connexion WiFi, en respectant la casse. (ex : Livebox-b464) 
ECHO.
ECHO.

SET /p SSID=Nom de la connexion wifi : 

FOR /f "delims=" %%A IN ('"netsh wlan show profile name=%SSID% key=clear | findstr Key"') DO SET wifi_key=%%A
IF /I "%wifi_key%" EQU "" goto :ErrorEmpty
SET wifi_key=%wifi_key:~29%
CLS
ECHO **********************************************************
ECHO   Nom de la connexion :  %SSID%            
ECHO   Mot de passe :         %wifi_key%
ECHO **********************************************************
ECHO.

:choice
set /P c=Voulez-vous copier le mot de passe [O/N]?
if /I "%c%" EQU "O" goto :oui
if /I "%c%" EQU "N" goto :non
goto :choice


:oui 
ECHO %wifi_key% | clip
ECHO SUCCÈS : Mot de passe copié dans le presse-papier.

PAUSE
EXIT

:non
EXIT

:ErrorEmpty

ECHO ERREUR : Le nom de la connexion WiFi n'est pas reconnu ou vide.
PAUSE
GOTO :begin