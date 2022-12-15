CoordMode, Mouse, Screen
SetTimer, posTooltip, 10
return

posTooltip:
	MouseGetPos, x, y
	ToolTip, % "x: " x "`ny: " y
return


ESC::ExitApp
