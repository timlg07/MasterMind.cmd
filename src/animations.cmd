goto %~1Animation
exit /b 1

:startAnimation
	batbox /g 6  3 /c 0x04 /d "MASTERMIND batch"         /w 200
	batbox /g 6  3 /c 0x0c /d "M" /g 7  3 /c 0x0f /d "A" /w 50
	batbox /g 7  3 /c 0x0c /d "A" /g 8  3 /c 0x0f /d "S" /w 50
	batbox /g 8  3 /c 0x0c /d "S" /g 9  3 /c 0x0f /d "T" /w 50
	batbox /g 9  3 /c 0x0c /d "T" /g 10 3 /c 0x0f /d "E" /w 50
	batbox /g 10 3 /c 0x0c /d "E" /g 11 3 /c 0x0f /d "R" /w 50
	batbox /g 11 3 /c 0x0c /d "R" /g 12 3 /c 0x0f /d "M" /w 50
	batbox /g 12 3 /c 0x0c /d "M" /g 13 3 /c 0x0f /d "I" /w 50
	batbox /g 13 3 /c 0x0c /d "I" /g 14 3 /c 0x0f /d "N" /w 50
	batbox /g 14 3 /c 0x0c /d "N" /g 15 3 /c 0x0f /d "D" /w 50
	batbox /g 15 3 /c 0x0c /d "D" /g 16 3 /c 0x0f /d " " /w 50
	batbox /g 16 3 /c 0x0c /d " " /g 17 3 /c 0x0f /d "b" /w 50
	batbox /g 17 3 /c 0x0c /d "b" /g 18 3 /c 0x0f /d "a" /w 50
	batbox /g 18 3 /c 0x0c /d "a" /g 19 3 /c 0x0f /d "t" /w 50
	batbox /g 19 3 /c 0x0c /d "t" /g 20 3 /c 0x0f /d "c" /w 50
	batbox /g 20 3 /c 0x0c /d "c" /g 21 3 /c 0x0f /d "h" /w 120
	batbox /g 6  3 /c 0x0c /d "MASTERMIND batch"         /w 120 
	batbox /g 6  3 /c 0x04 /d "MASTERMIND batch"         /w 120 
	batbox /g 6  3 /c 0x0c /d "MASTERMIND batch"         /w 120 
	batbox /g 6  3 /c 0x04 /d "MASTERMIND batch"         /w 120 
	batbox /g 6  3 /c 0x0c /d "MASTERMIND batch"         /w 120 
exit /b 0

:checkButtonAnimation
	batbox /g 54 6 /c 0x%backgroundcolor%%~2 /d ">EINLOGGEN" /w 30
	batbox /g 54 6 /c 0x%backgroundcolor%f   /d ">EINLOGGEN" /w 30
	batbox /g 54 6 /c 0x%backgroundcolor%%~2 /d ">EINLOGGEN" /w 30
	batbox /g 54 6 /c 0x%backgroundcolor%f   /d ">EINLOGGEN" /w 30
	batbox /g 54 6 /c 0x%backgroundcolor%%~2 /d ">EINLOGGEN" /w 30
	batbox /g 54 6 /c 0x%backgroundcolor%f   /d ">EINLOGGEN" /w 30
	batbox /g 54 6 /c 0x%backgroundcolor%%~2 /d ">EINLOGGEN" /w 30
	batbox /g 54 6 /c 0x%backgroundcolor%f   /d ">EINLOGGEN"
exit /b 0

:winAnimation
	batbox /g 28 %history_Y% /d "   RICHTIG!   " /w 50
	batbox /g 28 %history_Y% /d ">  RICHTIG!  <" /w 50
	batbox /g 28 %history_Y% /d ">> RICHTIG! <<" /w 50
	batbox /g 28 %history_Y% /d " >>RICHTIG!<< " /w 50
	batbox /g 28 %history_Y% /d "  >RICHTIG!<  " /w 50
	batbox /g 28 %history_Y% /d "   RICHTIG!   " /w 50
goto winAnimation