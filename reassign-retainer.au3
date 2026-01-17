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

;~ reads location of retainer as array from ini file
Func ReadRetainerLocation($iniFile, $section)
	Global $RetainerA, $RetainerB, $RetainerC, $RetainerOk, $RetainerQuit
	Global $VentureReport, $VentureReassign, $VentureConfirm, $VentureAssign
	Global $RetainerLocationArraySize
	Local $RetainerLocation[$RetainerLocationArraySize][2]
	ConsoleWrite('ReadRetainerLocation: RetainerA is ' & $RetainerA & @CRLF)
    $RetainerLocation[$RetainerA][0] = IniRead($iniFile, $section, 'retainerA_x', '')
	$RetainerLocation[$RetainerA][1] = IniRead($iniFile, $section, 'retainerA_y', '')

    $RetainerLocation[$RetainerB][0] = IniRead($iniFile, $section, 'retainerB_x', '')
	$RetainerLocation[$RetainerB][1] = IniRead($iniFile, $section, 'retainerB_y', '')

	$RetainerLocation[$RetainerC][0] = IniRead($iniFile, $section, 'retainerC_x', '')
	$RetainerLocation[$RetainerC][1] = IniRead($iniFile, $section, 'retainerC_y', '')

	$RetainerLocation[$RetainerOk][0] = IniRead($iniFile, $section, 'retainerOk_x', '')
	$RetainerLocation[$RetainerOk][1] = IniRead($iniFile, $section, 'retainerOk_y', '')

	$RetainerLocation[$RetainerQuit][0] = IniRead($iniFile, $section, 'retainerQuit_x', '')
	$RetainerLocation[$RetainerQuit][1] = IniRead($iniFile, $section, 'retainerQuit_y', '')

	$RetainerLocation[$VentureReport][0] = IniRead($iniFile, $section, 'ventureReport_x', '')
	$RetainerLocation[$VentureReport][1] = IniRead($iniFile, $section, 'ventureReport_y', '')

	$RetainerLocation[$VentureReassign][0] = IniRead($iniFile, $section, 'ventureReassign_x', '')
	$RetainerLocation[$VentureReassign][1] = IniRead($iniFile, $section, 'ventureReassign_y', '')

	$RetainerLocation[$VentureConfirm][0] = IniRead($iniFile, $section, 'ventureConfirm_x', '')
	$RetainerLocation[$VentureConfirm][1] = IniRead($iniFile, $section, 'ventureConfirm_y', '')

	$RetainerLocation[$VentureAssign][0] = IniRead($iniFile, $section, 'ventureAssign_x', '')
	$RetainerLocation[$VentureAssign][1] = IniRead($iniFile, $section, 'ventureAssign_y', '')

	Return $RetainerLocation
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


; Script Start - Add your code below here
#include <MsgBoxConstants.au3>

ConsoleWrite('Main: Start of Program' & @CRLF)

$RetainerA = 0
$RetainerB = 1
$RetainerC = 2
$RetainerOk = 3
$RetainerQuit = 4
$VentureReport = 5
$VentureReassign = 6
$VentureConfirm = 7
$VentureAssign = 8
$RetainerLocationArraySize = 9

$iniFile = 'config.ini'

; read from the config file
$programName = IniRead($iniFile, 'ReassignRetainer', 'ProgramName', '')
$winName = IniRead($iniFile, 'ReassignRetainer', 'WindowName', '')
$sleepTime = IniRead($iniFile, 'ReassignRetainer', 'sleepTime', '')
$retainerLocation = ReadRetainerLocation($iniFile, 'Retainer')
ConsoleWrite('Main: ' & StringFormat("winName is %s", $winName) & @CRLF)

; grab the window
$hWin = WinGetHandle($winName)
LeftClickLocation("main", "select application", 1000, 800, 1)


; do the work
ProcessRetainerAssignment($RetainerA, $retainerLocation)
;ProcessRetainerAssignment($RetainerB, $retainerLocation)
;ProcessRetainerAssignment($RetainerC, $retainerLocation)

; make sure the last click goes thru before leaving
Sleep(5000)
ConsoleWrite('Main: End of Program' & @CRLF)