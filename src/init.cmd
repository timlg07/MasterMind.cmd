setlocal enabledelayedexpansion

set color[1]=9
set color[2]=a
set color[3]=c
set color[4]=e
set color[5]=d
set color[6]=b
set color[7]=f
set color[8]=6
set color[9]=5

set /a colornum = 6
set /a score = 0
set /a cols = 120
set /a lines = 30
set /a bottom = lines - 1
set /a right = cols - 1
set "backgroundcolor=0"

mode con cols=%cols% lines=%lines%
color %backgroundcolor%f
title MASTERMIND

if not exist batbox.exe call createBatbox

main