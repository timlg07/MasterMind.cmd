@echo off
@setlocal enabledelayedexpansion
@color 0f

::--color info;
:: 9 = blau
:: a = grün
:: c = rot
:: e = gelb
:: d = magenta
:: b = zyan
::--standard^
:: f = weiß
:: 6 = ocker
:: 5 = lila
::--all 9 colors;

::def;color

::deleted  xxx   ::set "color=9--a--c--e--d--b--f--6--5"
::deleted  xxx   ::for /f "tokens=%colornum% delims=--" %%a in ("%color%") 

set color1=9
set color2=a
set color3=c
set color4=e
set color5=d
set color6=b
set color7=f
set color8=6
set color9=5


::--mode info;
:: mode1 = jede Farbe nur ein mal
:: mode2 = jede Farbe darf öfters vorkommen
::--all 2 modes;


mode con cols=120 lines=40
title MASTERMIND by Tim Greller
::--start =load data
if not exist profileinfo.settings (
  set "colornum=6"
  set "mode=1"
  set "backgroundcolor=0"
  set "score=0"
 ) else (
  set /p profileinfo=<profileinfo.settings
  for /f "tokens=1,2,3,4 delims=:" %%a in ("!profileinfo!") do (
	 set colornum=%%a
	 set mode=%%b
	 set backgroundcolor=%%c
	 set score=%%d
    )
  )
::--end =load data
:startanimation
::--start =startanimation
batbox /g 6  3 /c 0x0c /d "MASTERMINDbatch"   /a 184 /w 200
batbox /g 6  3 /c 0x04 /d "M" /g 7  3 /c 0x0f /d "A" /w 50
batbox /g 7  3 /c 0x04 /d "A" /g 8  3 /c 0x0f /d "S" /w 50
batbox /g 8  3 /c 0x04 /d "S" /g 9  3 /c 0x0f /d "T" /w 50
batbox /g 9  3 /c 0x04 /d "T" /g 10 3 /c 0x0f /d "E" /w 50
batbox /g 10 3 /c 0x04 /d "E" /g 11 3 /c 0x0f /d "R" /w 50
batbox /g 11 3 /c 0x04 /d "R" /g 12 3 /c 0x0f /d "M" /w 50
batbox /g 12 3 /c 0x04 /d "M" /g 13 3 /c 0x0f /d "I" /w 50
batbox /g 13 3 /c 0x04 /d "I" /g 14 3 /c 0x0f /d "N" /w 50
batbox /g 14 3 /c 0x04 /d "N" /g 15 3 /c 0x0f /d "D" /w 50
batbox /g 15 3 /c 0x04 /d "D" /g 16 3 /c 0x0f /d "b" /w 50
batbox /g 16 3 /c 0x04 /d "b" /g 17 3 /c 0x0f /d "a" /w 50
batbox /g 17 3 /c 0x04 /d "a" /g 18 3 /c 0x0f /d "t" /w 50
batbox /g 18 3 /c 0x04 /d "t" /g 19 3 /c 0x0f /d "c" /w 50
batbox /g 19 3 /c 0x04 /d "c" /g 20 3 /c 0x0f /d "h" /w 50
batbox /g 20 3 /c 0x04 /d "h" /g 21 3 /c 0x0f /a 184 /w 200
batbox /g 6  3 /c 0x04 /d "MASTERMINDbatch" /a 184 /w 200 
batbox /g 6  3 /c 0x0c /d "MASTERMINDbatch" /a 184 /w 200 
batbox /g 6  3 /c 0x04 /d "MASTERMINDbatch" /a 184 /w 200 
batbox /g 6  3 /c 0x0c /d "MASTERMINDbatch" /a 184 /w 200 
::--end =startanimation
batbox /g 8 6 /c 0x0F /d ">>starten"
batbox /g 8 8 /c 0x09 /d "Einstellungen"
batbox /g 119 39
:stanmenu
for /f "tokens=1,2 delims=:" %%a in ('batbox /m') do (
  set x=%%a
  set y=%%b
 )
if %x% GEQ 6 if %x% LEQ 22 (
  if %y%==6 cls && goto gstart
  if %y%==8 cls && goto settings
  if %y%==3        goto startanimation
 )
goto stanmenu

:gstart
title GameSTART;
set  "versuchnr=1"
set /a   "count=1"
set /a verlaufY=11

::--festlegen der Farben


:festlege
if %mode%==2 goto m2festle
SET /a Zufall=1+(%colornum%-1+1)*%random%/32768 
echo:%festgelegtefarben%|findstr /c:"!color%Zufall%!." >nul && goto festlege
set rfield!count!=!color%Zufall%!
set festgelegtefarben=%festgelegtefarben%!color%Zufall%!.
set /a count+=1
if %count%==5 goto intrface
goto festlege

:intrface
::--building interface
batbox /g 4 3 /c 0x%backgroundcolor%7 /d "Farben:"
set /a count=1
 :intfloop
 set /a ylevel=count+4
 batbox /g 4 %ylevel% /c 0x%backgroundcolor%!color%count%! /d "O"
 if %count% GEQ %colornum% goto inteface
 set /a count+=1
 goto intfloop
:inteface
title Tragen sie ihre Vermutung ein:
batbox /g 30  3 /c 0x%backgroundcolor%7 /d "Erst eines der Felder dann eine farbe anklicken"
batbox /g 30  5 /c 0x%backgroundcolor%f /d "+----+----+----+----+"
batbox /g 30  6 /c 0x%backgroundcolor%f /d "|    |    |    |    |   >EINLOGGEN"
batbox /g 30  7 /c 0x%backgroundcolor%f /d "|    |    |    |    |"
batbox /g 30  8 /c 0x%backgroundcolor%f /d "+----+----+----+----+"
batbox /g 20 10 /c 0x%backgroundcolor%f /d "Verlauf:"

::--auswahl eines Feldes und einer Farbe

:auswahl1
for /f "tokens=1,2 delims=:" %%a in ('batbox /m') do (
  set x=%%a
  set y=%%b
 )


if %y%==6 if %x% GEQ 53 if %x% LEQ 65 goto rfctest1

if %y% GEQ 6 if %y% LEQ 7 (
 if %x% GEQ 32 ( 
  if %x% LEQ 35 ( batbox /g 31 6 /c 0x%backgroundcolor%f /d " xx " /g 31 7 /d " xx " 
    set "afeld=1" 
	goto auswahlc
	)
  if %x% LEQ 40 ( batbox /g 36 6 /c 0x%backgroundcolor%f /d " xx " /g 36 7 /d " xx " 
    set "afeld=2" 
	goto auswahlc
	)
  if %x% LEQ 45 ( batbox /g 41 6 /c 0x%backgroundcolor%f /d " xx " /g 41 7 /d " xx " 
    set "afeld=3"
	goto auswahlc
	)
  if %x% LEQ 50 ( batbox /g 46 6 /c 0x%backgroundcolor%f /d " xx " /g 46 7 /d " xx " 
    set "afeld=4"
	goto auswahlc
	)
 )
)

goto auswahl1

:auswahlc
for /f "tokens=1,2 delims=:" %%a in ('batbox /m') do (
  set x=%%a
  set y=%%b
 )
if %x% GEQ 3 if %x% LEQ 5 (
  if %y% GEQ 5 if %y% LEQ %ylevel% (
	goto ausgewlt
   )
 )
goto auswahlc

:ausgewlt
set /a c=y-4
set field%afeld%=!color%c%!

::--anzeigen der ausgewählten Farbe 
:showcolr
if defined field1 batbox /g 31 6 /c 0x%backgroundcolor%%field1% /d " xx " /g 31 7 /d " xx "
if defined field2 batbox /g 36 6 /c 0x%backgroundcolor%%field2% /d " xx " /g 36 7 /d " xx "
if defined field3 batbox /g 41 6 /c 0x%backgroundcolor%%field3% /d " xx " /g 41 7 /d " xx "
if defined field4 batbox /g 46 6 /c 0x%backgroundcolor%%field4% /d " xx " /g 46 7 /d " xx "

goto auswahl1

::--ende;
 

:rfctest1
::--testen wie viele Farben enthalten sind
set /a colorRight=positionRight=0

for /L %%i in (1,1,4) do (
	if [!field%%i!]==[] goto intrface
	echo:%festgelegtefarben%|findstr /c:"!field%%i!.">nul && set /a colorRight+=1
	if "!field%%i!"=="!rfield%%i!" set /a positionRight+=1
)

::--anzeigen des Verlaufs
batbox /g 21 %verlaufY% /c 0x%backgroundcolor%f /d "%versuchnr%.)  "
for /L %%i in (1,1,4) do (
	batbox /c 0x%backgroundcolor%!field%%i! /d "O "
	set "field%%i="
)
batbox /g 35 %verlaufY% /c 0x%backgroundcolor%f /d "| Farbe richtig: %colorRight%, Position richtig: %positionRight%"
if %positionRight% EQU 4 goto :WIN
::--update der Variablen
set /a versuchnr+=1
set /a verlaufY+=1
::--neuer Versuch
goto intrface

:m2festle


:settings
cls&echo noch nicht verfuegbar.&timeout /t 2
goto startanimation

:WIN
title GEWONNEN
set /a verlaufY+=2
batbox /c 0x%backgroundcolor%E
:_win
batbox /g 28 %verlaufY% /d "   RICHTIG!   " /w 50
batbox /g 28 %verlaufY% /d ">  RICHTIG!  <" /w 50
batbox /g 28 %verlaufY% /d ">> RICHTIG! <<" /w 50
batbox /g 28 %verlaufY% /d " >>RICHTIG!<< " /w 50
batbox /g 28 %verlaufY% /d ">> RICHTIG! <<" /w 50
batbox /g 28 %verlaufY% /d ">  RICHTIG!  <" /w 50
goto _win