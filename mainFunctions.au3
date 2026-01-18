#cs ----------------------------------------------------------------------------

	 Author:         Sohail Hussain
	 Script Function: functions for start of program
	 based on:       https://github.com/v1lev/ffxiv-simple-crafting-bot/blob/master/auto-craft.au3

#ce ----------------------------------------------------------------------------

#include-once


Func ReadRetainerLocation($iniFile, $section)
	Global $RetainerA, $RetainerB, $RetainerC, $RetainerOk, $RetainerQuit
	Global $VentureReport, $VentureReassign, $VentureConfirm, $VentureAssign
	Global $sellInventory, $sellRow1, $sellRow2, $sellRow3, $sellRow4
	Global $sellRow5, $sellRow6, $sellRow7, $sellRow8, $sellRow9
	Global $sellRow10, $sellRow11, $sellScroll, $sellExit
	Global $adjustPrice, $value, $comparePrice, $closeComparePrice, $confirm
	Global $RetainerLocationArraySize
	Global $scrollCount



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

	$RetainerLocation[$sellInventory][0] = IniRead($iniFile, $section, 'sellInventory_x', '')
	$RetainerLocation[$sellInventory][1] = IniRead($iniFile, $section, 'sellInventory_y', '')

	$RetainerLocation[$sellRow1][0] = IniRead($iniFile, $section, 'sellRow1_x', '')
	$RetainerLocation[$sellRow1][1] = IniRead($iniFile, $section, 'sellRow1_y', '')

	$RetainerLocation[$sellRow2][0] = IniRead($iniFile, $section, 'sellRow2_x', '')
	$RetainerLocation[$sellRow2][1] = IniRead($iniFile, $section, 'sellRow2_y', '')

	$RetainerLocation[$sellRow3][0] = IniRead($iniFile, $section, 'sellRow3_x', '')
	$RetainerLocation[$sellRow3][1] = IniRead($iniFile, $section, 'sellRow3_y', '')

	$RetainerLocation[$sellRow4][0] = IniRead($iniFile, $section, 'sellRow4_x', '')
	$RetainerLocation[$sellRow4][1] = IniRead($iniFile, $section, 'sellRow4_y', '')

	$RetainerLocation[$sellRow5][0] = IniRead($iniFile, $section, 'sellRow5_x', '')
	$RetainerLocation[$sellRow5][1] = IniRead($iniFile, $section, 'sellRow5_y', '')

	$RetainerLocation[$sellRow6][0] = IniRead($iniFile, $section, 'sellRow6_x', '')
	$RetainerLocation[$sellRow6][1] = IniRead($iniFile, $section, 'sellRow6_y', '')

	$RetainerLocation[$sellRow7][0] = IniRead($iniFile, $section, 'sellRow7_x', '')
	$RetainerLocation[$sellRow7][1] = IniRead($iniFile, $section, 'sellRow7_y', '')

	$RetainerLocation[$sellRow8][0] = IniRead($iniFile, $section, 'sellRow8_x', '')
	$RetainerLocation[$sellRow8][1] = IniRead($iniFile, $section, 'sellRow8_y', '')

	$RetainerLocation[$sellRow9][0] = IniRead($iniFile, $section, 'sellRow9_x', '')
	$RetainerLocation[$sellRow9][1] = IniRead($iniFile, $section, 'sellRow9_y', '')

	$RetainerLocation[$sellRow10][0] = IniRead($iniFile, $section, 'sellRow10_x', '')
	$RetainerLocation[$sellRow10][1] = IniRead($iniFile, $section, 'sellRow10_y', '')

	$RetainerLocation[$sellRow11][0] = IniRead($iniFile, $section, 'sellRow11_x', '')
	$RetainerLocation[$sellRow11][1] = IniRead($iniFile, $section, 'sellRow11_y', '')

	$RetainerLocation[$sellScroll][0] = IniRead($iniFile, $section, 'sellScroll_x', '')
	$RetainerLocation[$sellScroll][1] = IniRead($iniFile, $section, 'sellScroll_y', '')

	$RetainerLocation[$sellExit][0] = IniRead($iniFile, $section, 'sellExit_x', '')
	$RetainerLocation[$sellExit][1] = IniRead($iniFile, $section, 'sellExit_y', '')

	$RetainerLocation[$adjustPrice][0] = IniRead($iniFile, $section, 'adjustPrice_x', '')
	$RetainerLocation[$adjustPrice][1] = IniRead($iniFile, $section, 'adjustPrice_y', '')

	$RetainerLocation[$value][0] = IniRead($iniFile, $section, 'value_x', '')
	$RetainerLocation[$value][1] = IniRead($iniFile, $section, 'value_y', '')


	$RetainerLocation[$comparePrice][0] = IniRead($iniFile, $section, 'comparePrice_x', '')
	$RetainerLocation[$comparePrice][1] = IniRead($iniFile, $section, 'comparePrice_y', '')


	$RetainerLocation[$closeComparePrice][0] = IniRead($iniFile, $section, 'closeComparePrice_x', '')
	$RetainerLocation[$closeComparePrice][1] = IniRead($iniFile, $section, 'closeComparePrice_y', '')


	$RetainerLocation[$confirm][0] = IniRead($iniFile, $section, 'confirm_x', '')
	$RetainerLocation[$confirm][1] = IniRead($iniFile, $section, 'confirm_y', '')

	$scrollCount = IniRead($iniFile, $section, 'scroll_count', '')

	Return $RetainerLocation
EndFunc

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; main program initialization
;
$RetainerA = 0
$RetainerB = 1
$RetainerC = 2
$RetainerOk = 3
$RetainerQuit = 4
$VentureReport = 5
$VentureReassign = 6
$VentureConfirm = 7
$VentureAssign = 8
$sellInventory = 9
$sellRow1 = 10
$sellRow2 = 11
$sellRow3 = 12
$sellRow4 = 13
$sellRow5 = 14
$sellRow6 = 15
$sellRow7 = 16
$sellRow8 = 17
$sellRow9 = 18
$sellRow10 = 19
$sellRow11 = 20
$sellScroll = 21
$sellExit = 22
$adjustPrice = 23
$value = 24
$comparePrice = 25
$closeComparePrice = 26
$confirm = 27

$RetainerLocationArraySize = 28
$scrollCount = 0

$iniFile = 'config.ini'

; read from the config file
$programName = IniRead($iniFile, $configSectionName, 'ProgramName', '')
$winName = IniRead($iniFile, 'General', 'WindowName', '')
$sleepTime = IniRead($iniFile, 'ReassignRetainer', 'sleepTime', '')
$retainerLocation = ReadRetainerLocation($iniFile, 'ScreenLocations')
ConsoleWrite('Main: ' & StringFormat("winName is %s", $winName) & @CRLF)

; grab the window
$hWin = WinGetHandle($winName)
LeftClickLocation("main", "select application", 1000, 800, 1)


