:startAnimation
	call animations start
:startMenu
	batbox /g 8 6 /c 0x0F /d ">>starten"
	batbox /g 8 8 /c 0x07 /d "Anzahl der Farben: " /c 0x0c /d "[-]" /c 0x0f /d " %colornum% " /c 0x0a /d "[+]"
	batbox /g %right% %bottom%
	for /f "tokens=1,2 delims=:" %%x in ('batbox /m') do (
		if %%y equ 6 if %%x geq 8 if %%x leq 17 (
			cls
			goto startGame
		)
		if %%y equ 8 (
			if %%x gtr 26 if %%x lss 30 if %colornum% gtr 4 (
				set /a colornum -= 1
				goto startMenu
			)
			if %%x gtr 32 if %%x lss 36 if %colornum% lss 9 (
				set /a colornum += 1
				goto startMenu
			)
		)
	)
goto startMenu

:startGame
	set /a tryCount = 1
	set /a history_Y = 11
	set "secretColors="
	set /a _i = 1
	
	:chooseColors
		:: pick random color from the array:
		set /a _index = 1 + colornum * %random%/32768 
		set "_color=!color[%_index%]!"
		:: make sure no color occurs twice:
		for /L %%i in (1 1 %_i%) do (
			if "!secretColors[%%i]!"=="%_color%" (
				goto chooseColors
			)
		)
		set "secretColors[%_i%]=%_color%"
		if %_i% geq 4 goto render
	set /a _i += 1
	goto chooseColors
	

:render
	batbox /g 4 3 /c 0x%backgroundcolor%7 /d "Farben:"
	set /a _i = 1
		:colorSelection
			set /a ylevel = _i + 4
			batbox /g 4 %ylevel% /c 0x%backgroundcolor%!color[%_i%]! /d "O"
			set /a _i += 1
		if %_i% leq %colornum% goto colorSelection

	batbox /g 30  3 /c 0x%backgroundcolor%7 /d "Erst eines der Felder dann eine farbe anklicken"
	batbox /g 30  5 /c 0x%backgroundcolor%f /d "+----+----+----+----+"
	batbox /g 30  6 /c 0x%backgroundcolor%f /d "|    |    |    |    |   >EINLOGGEN"
	batbox /g 30  7 /c 0x%backgroundcolor%f /d "|    |    |    |    |"
	batbox /g 30  8 /c 0x%backgroundcolor%f /d "+----+----+----+----+"
	batbox /g 20 10 /c 0x%backgroundcolor%f /d "Verlauf:"

:selectField
	for /f "tokens=1,2 delims=:" %%x in ('batbox /m') do (
		if %%y equ 6 if %%x geq 53 if %%x leq 65 goto checkSelection
		if %%y geq 6 if %%y leq 7 (
			if %%x geq 32 ( 
				if %%x leq 35 ( 
					batbox /g 31 6 /c 0x%backgroundcolor%f /d " xx " /g 31 7 /d " xx " 
					set /a fieldIndex = 1 
					goto selectColor
				)
				if %%x leq 40 ( 
					batbox /g 36 6 /c 0x%backgroundcolor%f /d " xx " /g 36 7 /d " xx " 
					set /a fieldIndex = 2
					goto selectColor
				)
				if %%x leq 45 (
					batbox /g 41 6 /c 0x%backgroundcolor%f /d " xx " /g 41 7 /d " xx " 
					set /a fieldIndex = 3
					goto selectColor
				)
				if %%x leq 50 ( 
					batbox /g 46 6 /c 0x%backgroundcolor%f /d " xx " /g 46 7 /d " xx " 
					set /a fieldIndex = 4
					goto selectColor
				)
			)
		)
	)
goto selectField

:selectColor
	for /f "tokens=1,2 delims=:" %%x in ('batbox /m') do (
		if %%x geq 3 if %%x leq 5 (
			if %%y geq 5 if %%y leq %ylevel% (
				set /a colorIndex = %%y - 4
				goto selectionFinished
			)
		)
	)
goto selectColor

:selectionFinished
	set field[%fieldIndex%]=!color[%colorIndex%]!

	:showColor
	if defined field[1] batbox /g 31 6 /c 0x%backgroundcolor%%field[1]% /d " xx " /g 31 7 /d " xx "
	if defined field[2] batbox /g 36 6 /c 0x%backgroundcolor%%field[2]% /d " xx " /g 36 7 /d " xx "
	if defined field[3] batbox /g 41 6 /c 0x%backgroundcolor%%field[3]% /d " xx " /g 41 7 /d " xx "
	if defined field[4] batbox /g 46 6 /c 0x%backgroundcolor%%field[4]% /d " xx " /g 46 7 /d " xx "

goto selectField

 

:checkSelection
	set /a correctColors = correctPositions = 0

	for /L %%i in (1 1 4) do (
		if not defined field[%%i] (
			call animations checkButton c
			goto selectField
		)
		
		for /L %%j in (1 1 4) do (
			
			if %%i neq %%j if "!field[%%i]!"=="!field[%%j]!" (
				call animations checkButton c
				goto selectField
			)
		
			if "!secretColors[%%j]!"=="!field[%%i]!" (
				set /a correctColors += 1
			)
		)
		if "!secretColors[%%i]!"=="!field[%%i]!" (
			set /a correctPositions += 1
		)
	)
	
	call animations checkButton a
	
	::show history:
	batbox /g 21 %history_Y% /c 0x%backgroundcolor%f /d "%tryCount%.)  "
	for /L %%i in (1 1 4) do (
		batbox /c 0x%backgroundcolor%!field[%%i]! /d "O "
		set "field[%%i]="
	)
	batbox /g 35 %history_Y% /c 0x%backgroundcolor%f /d "| Farben richtig: %correctColors%, Positionen richtig: %correctPositions%"
	
	if %correctPositions% equ 4 goto win
	
	set /a tryCount  += 1
	set /a history_Y += 1
	
goto render


:win
	title MASTERMIND - GEWONNEN
	set /a history_Y += 2
	batbox /c 0x%backgroundcolor%E
	call animations win