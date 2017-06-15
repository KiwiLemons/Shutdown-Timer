#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\Pictures\icons\15.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
Global $SDTs
Global $msgR = 0
Global $time = 3600
Global $Input
Global $Param

#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START GUI section
$Form1_1 = GUICreate("Shutdown Timer by KiwiLemons", 443, 100, -1, -1)
$TimeINput = GUICtrlCreateInput("", 24, 16, 121, 21, BitOR($GUI_SS_DEFAULT_INPUT, $ES_NUMBER))
GUICtrlSetTip(-1, "Enter your desired time which can be read as either minutes or hours")
$Cancel = GUICtrlCreateButton("Cancel", 344, 56, 75, 25)
GUICtrlSetTip(-1, "Closes the application")
$Ok = GUICtrlCreateButton("Ok", 256, 56, 75, 25)
GUICtrlSetTip(-1, "Sets a timer")
$RadioM = GUICtrlCreateRadio("Minutes", 168, 16, 57, 17)
$RadioH = GUICtrlCreateRadio("Hours", 264, 16, 57, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
;$Credits = GUICtrlCreateLabel("Created by KiwiLemons", 308, 92, 114, 17)
$Abort = GUICtrlCreateButton("Abort Shutdown", 24, 56, 99, 25)
GUICtrlSetTip(-1, "Cancels a previously ordered shutdown time")
$Shutdown = GUICtrlCreateCombo("Shutdown", 344, 16, 73, 25, BitOR($GUI_SS_DEFAULT_COMBO, $CBS_SIMPLE))
GUICtrlSetData(-1, "Reboot")
GUICtrlSetTip(-1, "Choose what you want to happen when the countdown is complete")
$Boot_A = GUICtrlCreateButton("Advanced Startup", 136, 56, 107, 25)
GUICtrlSetTip(-1, "Instantly reboots your PC into Advanced Startup mode (Does not work on Windows 7)")
GUISetState(@SW_SHOW)
#EndRegion ### END GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
			
		Case $TimeINput
			$SDTs = GUICtrlRead($TimeINput)
			$Input = $SDTs
			
		Case $Cancel
			Exit
			
		Case $Ok
			ShutDownTime()
			
		Case $RadioM
			If GUICtrlRead($RadioM) = 1 Then Global $time = 60
			
		Case $RadioH
			If GUICtrlRead($RadioH) = 1 Then Global $time = 3600
			
		Case $Abort
			AbortShutdown()
			
		Case $Boot_A
			AdvancedBoot()

	EndSwitch
WEnd

Func ShutDownTime()
	If $SDTs <> $Input Then $SDTs = $Input
	If $SDTs = "" Then $msgR = MsgBox(16, "   Invalid Time", "Please enter a valid time")
	If $msgR = 1 Then Return
	If GUICtrlRead($Shutdown) = "Shutdown" Then
		$Param = "-s -t "
	ElseIf GUICtrlRead($Shutdown) = "Log off" Then
		$Param = "-l -t "
	ElseIf GUICtrlRead($Shutdown) = "Hibernate" Then
		$Param = "-h -t "
	ElseIf GUICtrlRead($Shutdown) = "Reboot" Then
		$Param = "-r -t "
	EndIf
	$SDTs *= $time
	RunWait(@ComSpec & " /c" & "shutdown " & $Param & $SDTs, "", @SW_HIDE)
EndFunc   ;==>ShutDownTime

Func AbortShutdown()
	RunWait(@ComSpec & " /c" & "shutdown -a", "", @SW_HIDE)
EndFunc   ;==>AbortShutdown

Func AdvancedBoot()
	RunWait(@ComSpec & " /c" & "shutdown -r -o -t 0", "", @SW_HIDE)
EndFunc   ;==>AdvancedBoot
