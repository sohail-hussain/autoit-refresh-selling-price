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


Func ProcessRetainerAssignment($RetainerImageFileName, $RetainerNumber, $RetainerLocation)
	Global $RetainerOk
	Local $sleepTime = 1

	ConsoleWrite('ReadRetainerLocation: Retainer is ' & $RetainerImageFileName & @CRLF)
;	Sleep($sleepTime * 1000)

; select the retainer
	clickOnImage("ProcessMarketUpdate", "select retainer", $RetainerImageFileName);
	LeftClickLocation ("ProcessRetainerAssignment", "OK", $RetainerLocation[$RetainerOk][0], $RetainerLocation[$RetainerOk][1], $sleepTime)

	; now click report
	clickOnImage("ProcessMarketUpdate", "venture complete", "venture complete.png");

	; next reassign
	clickOnImage("ProcessMarketUpdate", "reassign", "reassign.png");

	; next assign
	clickOnImage("ProcessMarketUpdate", "assign", "assign.png");
	LeftClickLocation ("ProcessRetainerAssignment", "OK", $RetainerLocation[$RetainerOk][0], $RetainerLocation[$RetainerOk][1], $sleepTime)
; may need an ok click
	; lastly quit
	clickOnImage("ProcessMarketUpdate", "quit", "quit.png");
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
ProcessRetainerAssignment("Miner-weapons-gear.png", $RetainerA, $retainerLocation)
ProcessRetainerAssignment("Botanist-armor-sales.png", $RetainerB, $retainerLocation)
ProcessRetainerAssignment("Retainer-ccc.png", $RetainerC, $retainerLocation)


ConsoleWrite('main: after process' & @CRLF)
; make sure the last click goes thru before leaving
Sleep(5000)
ConsoleWrite('Main: End of Program' & @CRLF)