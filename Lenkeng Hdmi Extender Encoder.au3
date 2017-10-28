#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.2
 Author:         Gilberto Beda (gilberto.beda@gmail.com)

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiIPAddress.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <MsgBoxConstants.au3>
#include <GuiStatusBar.au3>
#include <GUIConstants.au3>
#include <GuiComboBoxEx.au3>
#include <GuiButton.au3>
#include <WinAPICom.au3>
#include <Timers.au3>
#include <Date.au3>

#Region ### START Koda GUI section ### Form=MainForm.kxf
$MainForm = GUICreate("Lenkeng/ESYNiC HDMI Extender Encoder", 767, 432, 195, 119)
$GroupInOut = GUICtrlCreateGroup("&Source && Destination", 9, 8, 721, 129)
GUICtrlSetResizing(-1, $GUI_DOCKTOP)
$InputIpAddress = GUICtrlCreateInput("239.255.42.42", 109, 27, 121, 21)
$InputPort = GUICtrlCreateInput("5004", 275, 27, 53, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlSetLimit(-1, 5)
$InputFFMpegFolder = GUICtrlCreateInput("", 109, 58, 497, 21)
GUICtrlSetTip(-1, "Leave blank to use ffmpeg executables in ffmeg folder (default)")
$ButtonSetFFMPegFolder = GUICtrlCreateButton("...", 609, 57, 35, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetTip(-1, "Select FFMpeg folder binaries")
$ButtonResetFFMPegFolder = GUICtrlCreateButton("Reset", 650, 58, 35, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetTip(-1, "Reset FFMpeg folder to default")
$InputDestinationFolder = GUICtrlCreateInput("", 109, 92, 497, 21)
$ButtonSetDestination = GUICtrlCreateButton("...", 610, 90, 35, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetTip(-1, "Select destination folder")
$ButtonResetDestination = GUICtrlCreateButton("Reset", 650, 90, 35, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetTip(-1, "Reset destination folder to default")
$LabelBroadcastIp = GUICtrlCreateLabel("Broadcast IP", 17, 33, 65, 17)
$LabelDestinationFolder = GUICtrlCreateLabel("DestinationFolder", 17, 95, 86, 17)
$LabelFFMpegFolder = GUICtrlCreateLabel("FFMpeg folder", 17, 63, 72, 17)
$LabelPort = GUICtrlCreateLabel("Port", 245, 31, 23, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$GroupEncoding = GUICtrlCreateGroup("Encoding", 8, 146, 721, 216)
$ComboContainer = GUICtrlCreateCombo("", 16, 182, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "mp4|ts|mkv", "ts")
$ComboPreset = GUICtrlCreateCombo("", 192, 182, 97, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "ultrafast|superfast|veryfast|faster|fast|medium|slow", "superfast")
$ComboVCodec = GUICtrlCreateCombo("", 16, 238, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "copy|h264|mpeg2video", "copy")
$ComboScaleTo = GUICtrlCreateCombo("", 191, 238, 97, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "720:480|704:480|720:576|704:576|1280:720|1920:1080", "1280:720")
$InputVBitrate = GUICtrlCreateInput("5000", 321, 237, 75, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlSetLimit(-1, 5)
$ComboACodec = GUICtrlCreateCombo("", 16, 294, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "copy|aac|ac3|libmp3lame|mp2", "copy")
$InputABitrate = GUICtrlCreateInput("192", 321, 293, 75, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlSetLimit(-1, 5)
$CheckboxDeint = GUICtrlCreateCheckbox("Deinterlace", 16, 333, 74, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$CheckboxDeint2x = GUICtrlCreateCheckbox("Deinterlace (2x)", 104, 333, 95, 17)
$LabelContainer = GUICtrlCreateLabel("Container", 16, 164, 49, 17)
$LabelVCodec = GUICtrlCreateLabel("Video codec", 18, 220, 64, 17)
$LabelACodec = GUICtrlCreateLabel("Audio codec", 18, 276, 64, 17)
$LabelScaleTo = GUICtrlCreateLabel("Scale to", 191, 220, 43, 17)
$LabelPreset = GUICtrlCreateLabel("Preset", 192, 164, 34, 17)
$LabelVBitrate = GUICtrlCreateLabel("Video bitrate (Kb.)", 320, 220, 88, 17)
$LabelAVCodec = GUICtrlCreateLabel("Audio bitrate (Kb.)", 320, 276, 88, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$ButtonEncode = GUICtrlCreateButton("Encode (CTRL+E)", 208, 375, 103, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetTip(-1, "Start encoding")
$ButtonAbort = GUICtrlCreateButton("Abort (CTRL+A)", 320, 375, 103, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetTip(-1, "Abort encoding")
$ButtonExit = GUICtrlCreateButton("Exit (CTRL+X)", 440, 375, 103, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetTip(-1, "Exit")
$StatusBar = _GUICtrlStatusBar_Create($MainForm)
Dim $StatusBar_PartsWidth[4] = [100, 600, 670, -1]
_GUICtrlStatusBar_SetParts($StatusBar, $StatusBar_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar, "Ready", 0)
_GUICtrlStatusBar_SetText($StatusBar, "", 1)
_GUICtrlStatusBar_SetText($StatusBar, "", 2)
_GUICtrlStatusBar_SetText($StatusBar, "v 1.00", 3)
GUISetState(@SW_SHOW)
Dim $MainForm_AccelTable[3][2] = [["^e", $ButtonEncode],["^a", $ButtonAbort],["^x", $ButtonExit]]
GUISetAccelerators($MainForm_AccelTable)
#EndRegion ### END Koda GUI section ###

Opt("WinTitleMatchMode", -2) ;1=start, 2=subStr, 3=exact, 4=advanced, -1 to -4=Nocase
Global $Delay = 5000
Global $Config = @ScriptDir & "\config"
Global $iPIDFFMpegDest = 0
Global $iPIDFFMpegRaw = 0
Global $guidPIDFFMpegDest = ""
Global $guidPIDFFMpegRaw = ""
Global $sFileNameFFMpegDest = ""
Global $sFileNameFFMpegRaw = ""
Global $sFileFFMpegDest = ""
Global $sFileFFMpegRaw = ""
Global $sEncoding = False
Global $dTimeEncode = _NowCalc();
Global $dStartTimeEncode = _NowCalc();

;~ _Timer_SetTimer($MainForm,1000,"EncodeInfo")

LoadConfiguration()

_GUICtrlButton_SetFocus($ButtonExit, true)

;~ _Timer_SetTimer($MainForm, 1000, "HandleEncodingMessage") ; create timer

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			if $sEncoding = True Then
				Abort()
			EndIf
			Exit
		Case $ButtonSetFFMPegFolder
			$sFFMPegFolder=GUICtrlRead($InputFFMpegFolder)
			Local $sFileSelectFolder = FileSelectFolder("Select FFMpeg folder binaries", $sFFMPegFolder)
			if not @error then
				GUICtrlSetData($InputFFMpegFolder,$sFileSelectFolder)
				SaveConfiguration()
			endif
		Case $ButtonResetFFMPegFolder
			GUICtrlSetData($InputFFMpegFolder, "")
			SaveConfiguration()
		Case $ButtonSetDestination
			$sDestinationFolder=GUICtrlRead($InputDestinationFolder)
			Local $sFileSelectFolder = FileSelectFolder("Select destination folder", $sDestinationFolder)
			if not @error then
				GUICtrlSetData($InputDestinationFolder,$sFileSelectFolder)
				SaveConfiguration()
			endif
		Case $ButtonResetDestination
			GUICtrlSetData($InputDestinationFolder, @UserProfileDir & "\Videos")
			SaveConfiguration()
		Case $ComboVCodec
			HandleControls()
		Case $ComboACodec
			HandleControls()
		Case $CheckboxDeint
			if GUICtrlRead($CheckboxDeint) = $GUI_CHECKED Then
				GUICtrlSetState($CheckboxDeint2x, $GUI_UNCHECKED)
			EndIf
		Case $CheckboxDeint2x
			if GUICtrlRead($CheckboxDeint2x) = $GUI_CHECKED Then
				GUICtrlSetState($CheckboxDeint, $GUI_UNCHECKED)
			EndIf
		Case $ButtonEncode
			Encode()
		Case $ButtonAbort
			Abort()
		Case $ButtonExit
			SaveConfiguration()
			Exit
	EndSwitch
	if $sEncoding = True Then
		HandleEncodingMessage()
	EndIf
WEnd

Func Encode()
	GUICtrlSetState($ButtonAbort, $GUI_ENABLE)
	GUICtrlSetState($ButtonEncode, $GUI_DISABLE)
	GUICtrlSetState($ButtonExit, $GUI_DISABLE)

	Local $ext = GUICtrlRead($ComboContainer)
	Local $sInputDestinationFolder = GUICtrlRead($InputDestinationFolder)
	if GUICtrlRead($ComboVCodec) = "copy" And GUICtrlRead($ComboACodec) = "copy" then
		$ext = "ts"
	EndIf

	$sFileNameFFMpegDest = "output" & @YEAR & @MON & @MDAY & "_" & @HOUR & @MIN & @SEC & "." & $ext
	$sFileFFMpegDest = $sInputDestinationFolder & "\" & $sFileNameFFMpegDest

 	$sFileNameFFMpegRaw = "output" & @YEAR & @MON & @MDAY & "_" & @HOUR & @MIN & @SEC & "_raw.ts"
	$sFileFFMpegRaw = $sInputDestinationFolder & "\" & $sFileNameFFMpegRaw

	Local $sFFMPegFolder=GUICtrlRead($InputFFMpegFolder)
	if $sFFMPegFolder = "" Then
		$sFFMPegFolder = @ScriptDir & "\FFMPEG"
	EndIf
	Local $sExe = "FFMPEG"

	Local $sCommandRaw = ""
	if GUICtrlRead($ComboVCodec) <> "copy" Or GUICtrlRead($ComboACodec) <> "copy" then
		$sCommandRaw = StringFormat("-y -loglevel quiet -i udp://@%s:%s ", GUICtrlRead($InputIpAddress), GUICtrlRead($InputPort))
		$sCommandRaw = $sCommandRaw & " "
		$sCommandRaw = $sCommandRaw & "-c:v copy -c:a copy"
		$sCommandRaw = $sCommandRaw & " "
		$sCommandRaw = $sCommandRaw & StringFormat("""%s""", $sFileFFMpegRaw)
	EndIf

	; entry & input
	Local $sCommand = ""
	if $sCommandRaw = "" then
		$sCommand = StringFormat("-y -loglevel quiet -i udp://@%s:%s", GUICtrlRead($InputIpAddress), GUICtrlRead($InputPort))
		$sCommand = $sCommand & " "
	else
		$sCommand = StringFormat("-re -y -loglevel quiet -i ""%s""", $sFileFFMpegRaw)
		$sCommand = $sCommand & " "
	EndIf

	; video option
	Local $sVfParam = "-vf setdar=16/9,scale=" & GUICtrlRead($ComboScaleTo)
	if GUICtrlRead($CheckboxDeint) = $GUI_CHECKED Then
		$sVfParam = $sVfParam & ",yadif"
	EndIf
	if GUICtrlRead($CheckboxDeint2x) = $GUI_CHECKED Then
		$sVfParam = $sVfParam & ",yadif=1"
	EndIf
	if GUICtrlRead($ComboVCodec) <> "copy" then
		if $ext = "mp4" then
			$sCommand = $sCommand & StringFormat("-movflags faststart -pix_fmt yuv420p %s", $sVfParam)
		else
			$sCommand = $sCommand & StringFormat("-pix_fmt yuv420p %s", $sVfParam)
		EndIf
		$sCommand = $sCommand & " "
	EndIf

	$sCommand = $sCommand & StringFormat("-c:v %s", GUICtrlRead($ComboVCodec))
	$sCommand = $sCommand & " "

	if GUICtrlRead($ComboVCodec) <> "copy" then
		$sCommand = $sCommand & StringFormat("-b:v %sk", GUICtrlRead($InputVBitrate))
		$sCommand = $sCommand & " "
	EndIf

	; audio option
	$sCommand = $sCommand & StringFormat("-c:a %s", GUICtrlRead($ComboACodec))
	$sCommand = $sCommand & " "

	if GUICtrlRead($ComboACodec) <> "copy" then
		$sCommand = $sCommand & StringFormat("-b:a %sk", GUICtrlRead($InputABitrate))
		$sCommand = $sCommand & " "
	EndIf

	; preset
	if GUICtrlRead($ComboVCodec) = "h264" then
		$sCommand = $sCommand & StringFormat("-preset %s", GUICtrlRead($ComboPreset))
		$sCommand = $sCommand & " "
	elseif GUICtrlRead($ComboVCodec) = "mpeg2video" Then
		$sCommand = $sCommand & StringFormat("-preset %s", GUICtrlRead($ComboPreset))
		$sCommand = $sCommand & " "
	EndIf

	; destination
	$sCommand = $sCommand & StringFormat("""%s""", $sFileFFMpegDest)

	ConsoleWrite($sCommandRaw & @CRLF)
	ConsoleWrite($sCommand & @CRLF)

	Global $sEncoding = True
	$dStartTimeEncode = _NowCalc();
	$dTimeEncode = $dStartTimeEncode;

 	if $sCommandRaw = "" then
		_GUICtrlStatusBar_SetText($StatusBar, "Encoding ...", 0)
		$iPIDFFMpegDest = ShellExecute($sExe, $sCommand, $sFFMPegFolder, $SHEX_OPEN, @SW_HIDE)
		Local $hWnd = WinWait("ffmpeg", "", 5)

		$guidPIDFFMpegDest = _WinAPI_CreateGUID ( )

		WinSetTitle($hWnd, "", $guidPIDFFMpegDest)
	Else

		_GUICtrlStatusBar_SetText($StatusBar, "Starting ...", 0)
		$iPIDFFMpegRaw = ShellExecute($sExe, $sCommandRaw, $sFFMPegFolder, $SHEX_OPEN, @SW_HIDE)
		Local $hWndRaw = WinWait("ffmpeg", "", 5)
		$guidPIDFFMpegRaw = _WinAPI_CreateGUID ( )
		WinSetTitle($hWndRaw, "", $guidPIDFFMpegRaw)

		While not FileExists($sFileFFMpegRaw)
		WEnd

		Sleep($Delay)

		$dStartTimeEncode = _NowCalc();
		$dTimeEncode = $dStartTimeEncode;

		_GUICtrlStatusBar_SetText($StatusBar, "Encoding ...", 0)
		$iPIDFFMpegDest = ShellExecute($sExe, $sCommand, $sFFMPegFolder, $SHEX_OPEN, @SW_HIDE)
		Local $hWnd = WinWait("ffmpeg", "", 5)
		$guidPIDFFMpegDest = _WinAPI_CreateGUID ( )
		WinSetTitle($hWnd, "", $guidPIDFFMpegDest)
	EndIf

EndFunc

Func HandleEncodingMessage()
	if _DateDiff("s", $dTimeEncode, _NowCalc()) >= 1 Then
		$dTimeEncode = _NowCalc()
		Local $sElapsedHH = _DateDiff("h", $dStartTimeEncode, _NowCalc());
		Local $sElapsedMM = _DateDiff("n", $dStartTimeEncode, _NowCalc());
		Local $sElapsedSS = _DateDiff("s", $dStartTimeEncode, _NowCalc());
		_GUICtrlStatusBar_SetText($StatusBar, StringUpper($sFileNameFFMpegDest), 1)
;~ 		_GUICtrlStatusBar_SetText($StatusBar, StringFormat("%02s", $sElapsedHH) & ":" & StringFormat("%02s", $sElapsedMM) & ":" & StringFormat("%02s", $sElapsedSS), 2)
		_GUICtrlStatusBar_SetText($StatusBar, Sec_2_Time_Format($sElapsedSS), 2)
	EndIf
EndFunc

Func Sec_2_Time_Format($iSec) ;coded by UEZ
    Local $days = 0
    Local $sec = Mod($iSec, 60)
    Local $min = Mod(Int($iSec / 60), 60)
    Local $hr = Int($iSec / 60 ^ 2)
    If $hr > 23 Then
        $days = Floor($hr / 24)
        $hr -= $days * 24
    EndIf
    Return StringFormat("%02i:%02i:%02i", $hr, $min, $sec)
EndFunc   ;==>Sec_2_Time_Format

Func Abort()

	Global $sEncoding = False

	if $iPIDFFMpegRaw > 0 Then
		_GUICtrlStatusBar_SetText($StatusBar, "Closing...", 0)
		Local $hWndRaw = WinWait($guidPIDFFMpegRaw, "", 3)
		ControlSend($hWndRaw, "", "", "q")
		ProcessWaitClose($iPIDFFMpegDest, 10)
		$iPIDFFMpegRaw = 0
		$guidPIDFFMpegRaw = ""
		$sFileFFMpegRaw = ""
		Global $sEncoding = False
		_GUICtrlStatusBar_SetText($StatusBar, "Ready", 0)
		_GUICtrlStatusBar_SetText($StatusBar, "", 2)
	EndIf

	if $iPIDFFMpegDest > 0 Then
		Local $hWnd = WinWait($guidPIDFFMpegDest, "", 3)
		ControlSend($hWnd, "", "", "q")
		$iPIDFFMpegDest = 0
		$guidPIDFFMpegDest = ""
		$sFileFFMpegDest = ""
		_GUICtrlStatusBar_SetText($StatusBar, "Ready", 0)
		_GUICtrlStatusBar_SetText($StatusBar, "", 2)
	EndIf

	GUICtrlSetState($ButtonAbort, $GUI_DISABLE)
	GUICtrlSetState($ButtonEncode, $GUI_ENABLE)
	GUICtrlSetState($ButtonExit, $GUI_ENABLE)

EndFunc

Func HandleControls()
	GUICtrlSetState ($ComboContainer,$GUI_ENABLE)
	GUICtrlSetState ($ComboPreset,$GUI_ENABLE)
	GUICtrlSetState ($ComboScaleTo,$GUI_ENABLE)
	GUICtrlSetState ($InputVBitrate,$GUI_ENABLE)
	GUICtrlSetState ($InputABitrate,$GUI_ENABLE)
	GUICtrlSetState ($CheckboxDeint,$GUI_ENABLE)
	GUICtrlSetState ($CheckboxDeint2x,$GUI_ENABLE)
	if _GUICtrlComboBox_GetCurSel($ComboVCodec) = 0 Then
		GUICtrlSetState ($ComboScaleTo,$GUI_DISABLE)
		GUICtrlSetState ($InputVBitrate,$GUI_DISABLE)
		GUICtrlSetState ($CheckboxDeint,$GUI_DISABLE)
		GUICtrlSetState ($CheckboxDeint2x,$GUI_DISABLE)
	EndIf
	if _GUICtrlComboBox_GetCurSel($ComboACodec) = 0 Then
		GUICtrlSetState ($InputABitrate,$GUI_DISABLE)
	EndIf
	If (_GUICtrlComboBox_GetCurSel($ComboVCodec) = 0) And (_GUICtrlComboBox_GetCurSel($ComboACodec) = 0) Then
		GUICtrlSetData  ($ButtonEncode,"Grab (CTRL+E)")
		GUICtrlSetState ($ComboContainer,$GUI_DISABLE)
		GUICtrlSetState ($ComboPreset,$GUI_DISABLE)
		GUICtrlSetState ($ComboScaleTo,$GUI_DISABLE)
		GUICtrlSetState ($InputVBitrate,$GUI_DISABLE)
		GUICtrlSetState ($InputABitrate,$GUI_DISABLE)
		GUICtrlSetState ($CheckboxDeint,$GUI_DISABLE)
		GUICtrlSetState ($CheckboxDeint2x,$GUI_DISABLE)
	Else
		GUICtrlSetData  ($ButtonEncode,"Encode (CTRL+E)")
	EndIf
EndFunc

Func LoadConfiguration()

	;~ 	General
	Local $sIPAddress = IniRead($Config, "General", "IPAddress", "239.255.42.42")
	GUICtrlSetData($InputIpAddress, $sIPAddress)
	Local $sInputPort = IniRead($Config, "General", "Port", "5004")
	GUICtrlSetData($InputPort, $sInputPort)
	Local $sFFMpegFolder = IniRead($Config, "General", "FFMpegFolder","")
	GUICtrlSetData($InputFFMpegFolder, $sFFMpegFolder)
	Local $sInputDestinationFolder = IniRead($Config, "General", "DestinationFolder","")
	if $sInputDestinationFolder = "" Then
		$sInputDestinationFolder = @UserProfileDir & "\Videos"
	EndIf
	GUICtrlSetData($InputDestinationFolder, $sInputDestinationFolder)

	;~ 	Encoding video
	Local $sComboContainer = IniRead($Config, "Encoding", "Container","")
	if $sComboContainer = "" Then
		$sComboContainer = "mp4"
	EndIf
	GUICtrlSetData($ComboContainer, $sComboContainer)

	Local $sComboPreset = IniRead($Config, "Encoding", "Preset","")
	if $sComboPreset = "" Then
		$sComboPreset = "faster"
	EndIf
	GUICtrlSetData($ComboPreset, $sComboPreset)

	Local $sComboVCodec = IniRead($Config, "Encoding", "VCodec","")
	if $sComboVCodec = "" Then
		$sComboVCodec = "h264"
	EndIf
	GUICtrlSetData($ComboVCodec, $sComboVCodec)

	Local $sComboScaleTo = IniRead($Config, "Encoding", "ScaleTo","")
	if $sComboScaleTo = "" Then
		$sComboScaleTo = "1280:720"
	EndIf
	GUICtrlSetData($ComboScaleTo, $sComboScaleTo)

	Local $InputVBitrate = IniRead($Config, "Encoding", "VBitrate","")
	if $InputVBitrate = "" Then
		$InputVBitrate = "5000"
	EndIf
	GUICtrlSetData($InputVBitrate, $InputVBitrate)

	Local $sCheckboxDeint = IniRead($Config, "Encoding", "Deint", true)
	if $sCheckboxDeint = "true" Then
		GUICtrlSetState($CheckboxDeint, $GUI_CHECKED)
	Else
		GUICtrlSetState($CheckboxDeint, $GUI_UNCHECKED)
	EndIf

	Local $sCheckboxDeint2x = IniRead($Config, "Encoding", "Deint2x", false)
	if $sCheckboxDeint2x = "true" Then
		GUICtrlSetState($CheckboxDeint2x, $GUI_CHECKED)
	Else
		GUICtrlSetState($CheckboxDeint2x, $GUI_UNCHECKED)
	EndIf

	;~ 	Encoding audio
	Local $sComboACodec = IniRead($Config, "Encoding", "ACodec","")
	if $sComboACodec = "" Then
		$sComboACodec = "aac"
	EndIf
	GUICtrlSetData($ComboACodec, $sComboACodec)

	Local $InputABitrate = IniRead($Config, "Encoding", "ABitrate","")
	if $InputABitrate = "" Then
		$InputABitrate = "192"
	EndIf
	GUICtrlSetData($InputABitrate, $InputABitrate)

	HandleControls();

EndFunc

Func SaveConfiguration()

	;~ 	General
	Local $sIPAddress = GUICtrlRead($InputIpAddress)
	IniWrite($Config, "General", "IPAddress", $sIPAddress)

	Local $sInputPort = GUICtrlRead($InputPort)
	IniWrite($Config, "General", "Port", $sInputPort)

	Local $sInputFFMpegFolder = GUICtrlRead($InputFFMpegFolder)
	IniWrite($Config, "General", "FFMpegFolder", $sInputFFMpegFolder)

	Local $sInputDestinationFolder = GUICtrlRead($InputDestinationFolder)
	IniWrite($Config, "General", "DestinationFolder", $sInputDestinationFolder)

	;~ 	Encoding video
	Local $sComboContainer = GUICtrlRead($ComboContainer)
	IniWrite($Config, "Encoding", "Container", $sComboContainer)

	Local $sComboPreset = GUICtrlRead($ComboPreset)
	IniWrite($Config, "Encoding", "Preset", $sComboPreset)

	Local $sComboVCodec = GUICtrlRead($ComboVCodec)
	IniWrite($Config, "Encoding", "VCodec", $sComboVCodec)

	Local $sComboScaleTo = GUICtrlRead($ComboScaleTo)
	IniWrite($Config, "Encoding", "ScaleTo", $sComboScaleTo)

	Local $sInputVBitrate = GUICtrlRead($InputVBitrate)
	IniWrite($Config, "Encoding", "VBitrate", $sInputVBitrate)

	Local $sCheckboxDeint = GUICtrlRead($CheckboxDeint) = $GUI_CHECKED
	IniWrite($Config, "Encoding", "Deint", $sCheckboxDeint)

	Local $sCheckboxDeint2x = GUICtrlRead($CheckboxDeint2x) = $GUI_CHECKED
	IniWrite($Config, "Encoding", "Deint2x", $sCheckboxDeint2x)

	;~ 	Encoding audio
	Local $sComboACodec = GUICtrlRead($ComboACodec)
	IniWrite($Config, "Encoding", "ACodec", $sComboACodec)

	Local $sInputABitrate = GUICtrlRead($InputABitrate)
	IniWrite($Config, "Encoding", "ABitrate", $sInputABitrate)

EndFunc

