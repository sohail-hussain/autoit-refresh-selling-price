#cs ----------------------------------------------------------------------------

	 Author:         Sohail Hussain
	 Script Function: program to refresh the selling prices for retainer items

#ce ----------------------------------------------------------------------------

#include <MsgBoxConstants.au3>
#include <WinAPISys.au3>

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
	Global $confirm

	ConsoleWrite('processOneItem: ' & StringFormat("%s (%d, %d)", $message, $x, $y) & @CRLF)
	; click on the item to be updated
	LeftClickLocation ("processOneItem", $message & "item to update", $x, $y, $enableDebug)

	; click on adjust price
	clickOnImage("processOneItem", $message & " adjust price", "adjust price.png");

;	; click on value
;	$imageName = "asking price.png"
;	Local $askingPrice = findImage($imageName)
;	If $askingPrice[0][0] <> 1 Then
;		ConsoleWrite("processOneItem: image not found on screen >>>" & $imageName & "<<<... exiting" & @CRLF)
;		Exit
;	EndIf
;	$newX = $askingPrice[1][0] + 1355 - 1185
;	ConsoleWrite('processOneItem: ' & StringFormat("%s found at (%d, %d) clicking on (%d, %d)", $imageName, $askingPrice[1][0], $askingPrice[1][1], $newX, $askingPrice[1][1]) & @CRLF)
;	myMouseClick("left", $newX, $askingPrice[1][1], 1, 1000)
;
;	; send copy
;	;Send("^c")
	ClipPut("KnownValueSetByMyProgram")
;	$currentValue = ClipGet()
;	ConsoleWrite('processOneItem: Before ^C clip buffer is >>>' & $currentValue & "<<<" & @CRLF)
;;	Send("{CTRLDOWN}c{CTRLUP}")
;	_WinAPI_Keybd_Event(0x11, 0) ; Press CTRL down
;	;0x30 - 0x39 - (0 - 9) key
;	;0x41 - 0x5A - (A - Z) key
;	_WinAPI_Keybd_Event(0x43, 0) ; Press C down
;	_WinAPI_Keybd_Event(0x43, 2) ; Lift V up
;	_WinAPI_Keybd_Event(0x11, 2) ; Lift CTRL up
;	$currentPrice = ClipGet()
;	ConsoleWrite('processOneItem: After ^C clip buffer is >>>' & $currentPrice & "<<<" & @CRLF)
;	Sleep(1000)

	; click on compare price
	clickOnImage("processOneItem", $message & " compare prices", "compare prices.png");


	; click close compare price
	$imageName = "Search Results.png"
	Local $searchResults = findImage($imageName)
	If $searchResults[0][0] <> 1 Then
		ConsoleWrite("processOneItem: image not found on screen >>>" & $imageName & "<<<... exiting" & @CRLF)
		Exit
	EndIf
	$newX = $searchResults[1][0] + 1807 - 848 ; from where to click minus middle of image found
	ConsoleWrite('processOneItem: ' & StringFormat("%s found at (%d, %d) clicking on (%d, %d)", $imageName, $searchResults[1][0], $searchResults[1][1], $newX, $searchResults[1][1]) & @CRLF)
	myMouseClick("left", $newX, $searchResults[1][1], 1, 1000)

	; after clicking the close compare price the buffer should contain the new price
	$newPrice = ClipGet()
	If "KnownValueSetByMyProgram" = $newPrice Then
		ConsoleWrite("processOneItem: price did not change" & @CRLF)
	Else
		; click on value
		$imageName = "asking price.png"
		Local $askingPrice = findImage($imageName)
		If $askingPrice[0][0] <> 1 Then
			ConsoleWrite("processOneItem: image not found on screen >>>" & $imageName & "<<<... exiting" & @CRLF)
			Exit
		EndIf
		$newX = $askingPrice[1][0] + 1355 - 1185
		ConsoleWrite('processOneItem: ' & StringFormat("%s found at (%d, %d) clicking on (%d, %d)", $imageName, $askingPrice[1][0], $askingPrice[1][1], $newX, $askingPrice[1][1]) & @CRLF)
		myMouseClick("left", $newX, $askingPrice[1][1], 1, 1000)

		; send paste
		;Send("^v") ; 1. tried send ^C - fails sometimes
		;Send("{CTRLDOWN}v{CTRLUP}")  2. tried sending {CTRLDOWN}v{CTRLUP} - fails sometimes
		; 3. tried getting position before send {CTRLDOWN}v{CTRLUP} - fails sometimes
		$currentValue = ClipGet()
		Local $aPos = MouseGetPos()
		;MouseClick("left", $aPos[0], $aPos[1], 1, 1000)
		;ConsoleWrite('processOneItem: Before ^V clip buffer is >>>' & $currentValue & "<<<" & @CRLF)
		ConsoleWrite('processOneItem: ' & StringFormat("Before ^V clip buffer is >>>%s<<< at (%d, %d)", $currentValue, $aPos[0], $aPos[1]) & @CRLF)

		; tried 4. tried keyb eveents - fails sometimes
		;_WinAPI_Keybd_Event(0x11, 0) ; Press CTRL down
		;_WinAPI_Keybd_Event(0x56, 0) ; Press V down
		;_WinAPI_Keybd_Event(0x56, 2) ; Lift V up
		;_WinAPI_Keybd_Event(0x11, 2) ; Lift CTRL up
		; 5. try sleep between key sends
		$keyDelay = 250
		Sleep($keyDelay)
		Send("{CTRLDOWN}")
		Sleep($keyDelay)
		Send("v")
		Sleep($keyDelay)
		Send("{CTRLUP}")


		;Sleep(10000)
	EndIf

	; click confirm
	clickOnImage("processOneItem", $message & "confirm", "confirm.png");
	;Exit

	ConsoleWrite('processOneItem: end' & $message & @CRLF)
EndFunc

Func ProcessMarketUpdate($RetainerImageFileName, $RetainerLocation, $enableDebug)
	Global $RetainerOk, $RetainerQuit
	Global $sellInventory, $sellRow1, $sellRow2, $sellRow3, $sellRow4
	Global $sellRow5, $sellRow6, $sellRow7, $sellRow8, $sellRow9
	Global $sellRow10, $sellRow11, $sellScroll, $sellExit
	Global $scrollCount

	ConsoleWrite('ProcessMarketUpdate: $RetainerImageFileName is ' & $RetainerImageFileName & @CRLF)

	; select the retainer
	clickOnImage("ProcessMarketUpdate", "select retainer", $RetainerImageFileName);
	;Sleep(1000)
	;Local $aPos = MouseGetPos()
	;MouseClick("left", $aPos[0], $aPos[1], 1, 1000)
	LeftClickLocation ("ProcessMarketUpdate", "OK", $RetainerLocation[$RetainerOk][0], $RetainerLocation[$RetainerOk][1], $enableDebug)

	; now click select items in your inventory
	clickOnImage("ProcessMarketUpdate", "sell from inventory", "sell items in inventory.png");

	processOneItem("row1", $RetainerLocation[$sellRow1][0], $RetainerLocation[$sellRow1][1], $enableDebug)
	processOneItem("row2", $RetainerLocation[$sellRow2][0], $RetainerLocation[$sellRow2][1], $enableDebug)
	processOneItem("row3", $RetainerLocation[$sellRow3][0], $RetainerLocation[$sellRow3][1], $enableDebug)
	processOneItem("row4", $RetainerLocation[$sellRow4][0], $RetainerLocation[$sellRow4][1], $enableDebug)
	processOneItem("row5", $RetainerLocation[$sellRow5][0], $RetainerLocation[$sellRow5][1], $enableDebug)
	processOneItem("row6", $RetainerLocation[$sellRow6][0], $RetainerLocation[$sellRow6][1], $enableDebug)
	processOneItem("row7", $RetainerLocation[$sellRow7][0], $RetainerLocation[$sellRow7][1], $enableDebug)
	processOneItem("row8", $RetainerLocation[$sellRow8][0], $RetainerLocation[$sellRow8][1], $enableDebug)
	processOneItem("row9", $RetainerLocation[$sellRow9][0], $RetainerLocation[$sellRow9][1], $enableDebug)
	processOneItem("row10", $RetainerLocation[$sellRow10][0], $RetainerLocation[$sellRow10][1], $enableDebug)
	; loop turn scroll 10 times
	ConsoleWrite('ProcessMarketUpdate: $scrollCount is ' & $scrollCount & @CRLF)
	For $i = 1 To $scrollCount
		ConsoleWrite('ProcessMarketUpdate: i is ' & $i & @CRLF)
		LeftClickLocation("ProcessMarketUpdate", "scroll", $RetainerLocation[$sellScroll][0], $RetainerLocation[$sellScroll][1], $enableDebug)
		processOneItem("row10", $RetainerLocation[$sellRow10][0], $RetainerLocation[$sellRow10][1], $enableDebug)
	Next
	; last one
	processOneItem("row11", $RetainerLocation[$sellRow11][0], $RetainerLocation[$sellRow11][1], $enableDebug)

	; exit market
	$imageName = "markets.png"
	Local $searchResults = findImage($imageName)
	If $searchResults[0][0] <> 1 Then
		ConsoleWrite("ProcessMarketUpdate: image not found on screen >>>" & $imageName & "<<<... exiting" & @CRLF)
		Exit
	EndIf
	$newX = $searchResults[1][0] + 1726 - 910 ; from where to click minus middle of image found
	ConsoleWrite('ProcessMarketUpdate: ' & StringFormat("%s found at (%d, %d) clicking on (%d, %d)", $imageName, $searchResults[1][0], $searchResults[1][1], $newX, $searchResults[1][1]) & @CRLF)
	myMouseClick("left", $newX, $searchResults[1][1], 1, 1000)


	; lastly quit
	clickOnImage("ProcessMarketUpdate", "quit", "quit.png");
	LeftClickLocation ("ProcessMarketUpdate", "OK", $RetainerLocation[$RetainerOk][0], $RetainerLocation[$RetainerOk][1], $enableDebug)

	ConsoleWrite('ProcessMarketUpdate: exit ' & $RetainerImageFileName & @CRLF)
;	ConsoleWrite('ProcessMarketUpdate: stopping' & @CRLF)
;	Exit


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

ProcessMarketUpdate("Miner-weapons-gear.png", $retainerLocation, 1)
;ProcessMarketUpdate("Botanist-armor-sales.png", $retainerLocation, 1)
;ProcessMarketUpdate("Retainer-ccc.png", $retainerLocation, 1)

ConsoleWrite('main: after process' & @CRLF)
; make sure the last click goes thru before leaving
Sleep(5000)
ConsoleWrite('Main: End of Program' & @CRLF)