#cs ----------------------------------------------------------------------------

	 AutoIt Version: 3.3.18.0
	 Author:         Sohail Hussain
	 Script Function: mouse moving and location functions

#ce ----------------------------------------------------------------------------

#include-once

;
; called to move to a location and click left click
;
Func LeftClickLocation($caller, $message, $x, $y, $sleepTimeMultiplier)
	Local $pauseTimeBeforeMove = 5 * $sleepTimeMultiplier
	Local $pauseTimeBeforeClick = 5 * $sleepTimeMultiplier
	Local $pauseTimeAfterClick = 5 * $sleepTimeMultiplier

	ConsoleWrite('LeftClickLocation: ' & StringFormat("%s: %s (%d, %d) %d", $caller, $message, $x, $y, $sleepTimeMultiplier) & @CRLF)

	If $pauseTimeBeforeMove >  0 Then
		ConsoleWrite('LeftClickLocation: ' & StringFormat("sleeping %d sec before moving to (%d, %d)", $pauseTimeBeforeMove, $x, $y) & @CRLF)
		Sleep($pauseTimeBeforeMove * 1000)
	EndIf
	MouseMove($x, $y, 10)

	If $pauseTimeBeforeClick >  0 Then
		ConsoleWrite('LeftClickLocation: ' & StringFormat("sleeping %d sec before clicking on (%d, %d)", $pauseTimeBeforeClick, $x, $y) & @CRLF)
		Sleep($pauseTimeBeforeClick * 1000)
	EndIf
	MouseClick ( "left", $x, $y, 1, 1)

	If $pauseTimeAfterClick >  0 Then
		ConsoleWrite('LeftClickLocation: ' & StringFormat("sleeping %d sec after moving to (%d, %d)", $pauseTimeAfterClick, $x, $y) & @CRLF)
		Sleep($pauseTimeAfterClick * 1000)
	EndIf
EndFunc

