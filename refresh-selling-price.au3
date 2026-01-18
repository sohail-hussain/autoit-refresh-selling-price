#cs ----------------------------------------------------------------------------

	 Author:         Sohail Hussain
	 Script Function: program to refresh the selling prices for retainer items

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


Func processOneItem($message, $x, $y, $enableDebug)
	Global $RetainerLocation
	Global $adjustPrice, $value, $comparePrice, $closeComparePrice

	ConsoleWrite('processOneItem: ' & StringFormat("%s (%d, %d)", $message, $x, $y) & @CRLF)
	; click on the item to be updated
	LeftClickLocation ("processOneItem", $message & "item to update", $x, $y, $enableDebug)

	; click on adjust price
	LeftClickLocation ("processOneItem", $message & "adjust price", $RetainerLocation[$adjustPrice][0], $RetainerLocation[$adjustPrice][1], $enableDebug)

	; click on value
	LeftClickLocation ("processOneItem", $message & "select value", $RetainerLocation[$value][0], $RetainerLocation[$value][1], $enableDebug)

	; send copy
	Send("^c")

	; click on compare price
	LeftClickLocation ("processOneItem", $message & "compare price", $RetainerLocation[$comparePrice][0], $RetainerLocation[$comparePrice][1], $enableDebug)

	; click close compare price
	LeftClickLocation ("processOneItem", $message & "close compare price", $RetainerLocation[$closeComparePrice][0], $RetainerLocation[$closeComparePrice][1], $enableDebug)

	; click on value
	LeftClickLocation ("processOneItem", $message & "select value", $RetainerLocation[$value][0], $RetainerLocation[$value][1], $enableDebug)

	; send paste
	Send("^v")

	; click confirm
	LeftClickLocation ("processOneItem", $message & "confirm", $RetainerLocation[$confirm][0], $RetainerLocation[$confirm][1], $enableDebug)

	ConsoleWrite('processOneItem: end' & $message & @CRLF)
EndFunc

Func ProcessMarketUpdate($RetainerNumber, $RetainerLocation, $enableDebug)
	Global $RetainerOk
	Global $sellInventory, $sellRow1, $sellRow2, $sellRow3, $sellRow4
	Global $sellRow5, $sellRow6, $sellRow7, $sellRow8, $sellRow9
	Global $sellRow10, $sellRow11, $sellScroll, $sellExit

	ConsoleWrite('ProcessMarketUpdate: Retainer is ' & $RetainerNumber & @CRLF)

	; select the retainer
	ConsoleWrite('ProcessMarketUpdate: left click on ' & $RetainerLocation[$RetainerNumber][0]& "," & $RetainerLocation[$RetainerNumber][1] & @CRLF)
	LeftClickLocation ("ProcessMarketUpdate", "select retainer", $RetainerLocation[$RetainerNumber][0], $RetainerLocation[$RetainerNumber][1], $enableDebug)
	LeftClickLocation ("ProcessMarketUpdate", "OK", $RetainerLocation[$RetainerOk][0], $RetainerLocation[$RetainerOk][1], $enableDebug)

	; now click select items in your inventory
	LeftClickLocation ("ProcessMarketUpdate", "Report", $RetainerLocation[$sellInventory][0], $RetainerLocation[$sellInventory][1], $enableDebug)

	; loop thru 1st row N times
	processOneItem("row1 count1", $RetainerLocation[$sellRow1][0], $RetainerLocation[$sellRow1][1], $enableDebug)
	processOneItem("row2", $RetainerLocation[$sellRow2][0], $RetainerLocation[$sellRow2][1], $enableDebug)

	; exit market
	LeftClickLocation ("ProcessMarketUpdate", "exit market", $RetainerLocation[$sellExit][0], $RetainerLocation[$sellExit][1], $enableDebug)
; may need an ok click
	; lastly quit
	LeftClickLocation ("ProcessMarketUpdate", "quit", $RetainerLocation[$RetainerQuit][0], $RetainerLocation[$RetainerQuit][1], $enableDebug)
	LeftClickLocation ("ProcessMarketUpdate", "OK", $RetainerLocation[$RetainerOk][0], $RetainerLocation[$RetainerOk][1], $enableDebug)

	ConsoleWrite('ProcessMarketUpdate: exit Retainer is ' & $RetainerNumber & @CRLF)
EndFunc

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; main program
;

; define the config section, then include the main config reader
$configSectionName = "RefreshSellingPrice"
#include "mainFunctions.au3"

ConsoleWrite('Main: Start of Program' & $programName & @CRLF)

; do the work
ProcessMarketUpdate($RetainerA, $retainerLocation, 1)
;ProcessMarketUpdate($RetainerB, $retainerLocation, 1)
;ProcessMarketUpdate($RetainerC, $retainerLocation, 1)
ConsoleWrite('main: after process' & @CRLF)
; make sure the last click goes thru before leaving
Sleep(5000)
ConsoleWrite('Main: End of Program' & @CRLF)