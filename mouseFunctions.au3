#cs ----------------------------------------------------------------------------

	 Author:         Sohail Hussain
	 Script Function: mouse moving and location functions

#ce ----------------------------------------------------------------------------

#include-once
#include "ImageSearchDLL_UDF.au3"

;
; called to click on the image on the screen
;       not finding image is fatal
;
Func clickOnImage($caller, $reason, $imageName)
	Local $aResult = findImage($imageName)
	If $aResult[0][0] <> 1 Then
		ConsoleWrite('clickOnImage: ' & StringFormat("%s: %s image not found on screen >>>%s<<< ... exiting", $caller, $reason, $imageName) & @CRLF)
		Exit
	EndIf
	ConsoleWrite('clickOnImage: ' & StringFormat("%s found at (%d, %d)", $imageName, $aResult[1][0], $aResult[1][1]) & @CRLF)
	myMouseClick("left", $aResult[1][0], $aResult[1][1], 1, 1000)
	;Sleep(500)
	Sleep(250)
EndFunc

Func myMouseClick($button, $x, $y, $count, $speed)
	MouseMove($x, $y, 10)
	MouseDown($button)
	; 1. used 1000 - always worked
	;Sleep($speed)
	; 2. 500 seems reliable
	;Sleep(500)
	Sleep(250)
	MouseUp($button)
EndFunc


;
; called to find an image on the screen
;
Func findImage($imageFileName, $numberOfRetries = 5, $sleepInterval = 2000)
	If not FileExists($imageFileName) Then
		ConsoleWrite("findImage: fatal: unable to find file  " & $imageFileName & @CRLF)
		exit
    EndIf

	For $i = 1 To $numberOfRetries
		Local $aResult = _ImageSearch($imageFileName)
		If $aResult[0][0] = 0 Then
			; we did not find it
			Sleep($sleepInterval)
			;Sleep(2000)
		Else
			Return $aResult
		EndIf
	Next
	return $aResult
EndFunc

;
; called to move to a location and click left click
;
Func LeftClickLocation($caller, $message, $x, $y, $enableDebug)
	Local $pauseTimeBeforeMove = 0 * $enableDebug
	Local $pauseTimeBeforeClick = 0 * $enableDebug
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
	myMouseClick ( "left", $x, $y, 1, 1000)

	If $pauseTimeAfterClick >  0 Then
		ConsoleWrite('LeftClickLocation: ' & StringFormat("sleeping %d sec after moving to (%d, %d)", $pauseTimeAfterClick, $x, $y) & @CRLF)
		Sleep($pauseTimeAfterClick * 1000)
	EndIf
EndFunc

