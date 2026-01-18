#cs ----------------------------------------------------------------------------

	 Author:         Sohail Hussain
	 Script Function: mouse moving and location functions

#ce ----------------------------------------------------------------------------

#include-once

;
; called to move to a location and click left click
;
Func LeftClickLocation($caller, $message, $x, $y, $enableDebug)
	Local $pauseTimeBeforeMove = 0 * $enableDebug
	Local $pauseTimeBeforeClick = 2 * $enableDebug
	Local $pauseTimeAfterClick = 0 * $enableDebug

	ConsoleWrite('LeftClickLocation: ' & StringFormat("%s: %s (%d, %d) %d", $caller, $message, $x, $y, $enableDebug) & @CRLF)

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

