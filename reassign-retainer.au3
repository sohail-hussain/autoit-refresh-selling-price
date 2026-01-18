#cs ----------------------------------------------------------------------------

	 AutoIt Version: 3.3.18.0
	 Author:         myName
https://github.com/v1lev/ffxiv-simple-crafting-bot/blob/master/auto-craft.au3
	 Script Function:
		Template AutoIt script.

#ce ----------------------------------------------------------------------------

#include <MsgBoxConstants.au3>

#include "mouseFunctions.au3"

Func ExitOnCondition($condition, $message)
    If $condition Then
        MsgBox($MB_OK, 'Program stopped', StringFormat('%s', $message))
		MsgBox(262144, 'Debug line ~' & @ScriptLineNumber, 'Selection:' & @CRLF & '$totalItems,' & @CRLF & @CRLF & 'Return:' & @CRLF ) ;### Debug MSGBOX
        Exit 1
    EndIf
EndFunc


Func ProcessRetainerAssignment($RetainerNumber, $RetainerLocation)
	Global $RetainerOk
	Local $sleepTime = 1

	ConsoleWrite('ReadRetainerLocation: Retainer is ' & $RetainerNumber & @CRLF)
;	Sleep($sleepTime * 1000)

; select the retainer
	ConsoleWrite('ProcessRetainer: left click on ' & $RetainerLocation[$RetainerNumber][0]& "," & $RetainerLocation[$RetainerNumber][1] & @CRLF)
	LeftClickLocation ("ProcessRetainerAssignment", "select retainer", $RetainerLocation[$RetainerNumber][0], $RetainerLocation[$RetainerNumber][1], $sleepTime)
	LeftClickLocation ("ProcessRetainerAssignment", "OK", $RetainerLocation[$RetainerOk][0], $RetainerLocation[$RetainerOk][1], $sleepTime)

	; now click report
	LeftClickLocation ("ProcessRetainerAssignment", "Report", $RetainerLocation[$VentureReport][0], $RetainerLocation[$VentureReport][1], $sleepTime)

	; next reassign
	LeftClickLocation ("ProcessRetainerAssignment", "reassign", $RetainerLocation[$VentureReassign][0], $RetainerLocation[$VentureReassign][1], $sleepTime)

	; next assign
	LeftClickLocation ("ProcessRetainerAssignment", "assign", $RetainerLocation[$VentureAssign][0], $RetainerLocation[$VentureAssign][1], $sleepTime)
; may need an ok click
	; lastly quit
	LeftClickLocation ("ProcessRetainerAssignment", "quit", $RetainerLocation[$RetainerQuit][0], $RetainerLocation[$RetainerQuit][1], $sleepTime)
	LeftClickLocation ("ProcessRetainerAssignment", "OK", $RetainerLocation[$RetainerOk][0], $RetainerLocation[$RetainerOk][1], $sleepTime)
; may need an ok click

EndFunc

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; main program
;

; define the config section, then include the main config reader
$configSectionName = "ReassignRetainer"
#include "mainFunctions.au3"

ConsoleWrite('Main: Start of Program' & $programName & @CRLF)

; do the work
ProcessRetainerAssignment($RetainerA, $retainerLocation)
;ProcessRetainerAssignment($RetainerB, $retainerLocation)
;ProcessRetainerAssignment($RetainerC, $retainerLocation)
ConsoleWrite('main: after process' & @CRLF)
; make sure the last click goes thru before leaving
Sleep(5000)
ConsoleWrite('Main: End of Program' & @CRLF)