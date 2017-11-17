#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=icons8-video-editing.ico
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Comment=https://github.com/Red5goahead/Lenkeng-Hdmi-Extender-Encoder
#AutoIt3Wrapper_Res_Fileversion=1.3.0.0
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
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
#include <GuiEdit.au3>

#Region ### START Koda GUI section ### Form=MainForm.kxf
$MainForm = GUICreate("Lenkeng/ESYNiC HDMI Extender Encoder", 1061, 596, 195, 119)
$GroupInOut = GUICtrlCreateGroup("&Source && Destination", 8, 16, 1041, 153)
GUICtrlSetResizing(-1, $GUI_DOCKTOP)
$InputIpAddress = GUICtrlCreateInput("239.255.42.42", 112, 35, 121, 21)
$InputPort = GUICtrlCreateInput("5004", 278, 35, 53, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlSetLimit(-1, 5)
$InputFFMpegFolder = GUICtrlCreateInput("", 112, 66, 573, 21)
GUICtrlSetTip(-1, "Leave blank to use ffmpeg executables in ffmeg folder (default)")
$ButtonSetFFMPegFolder = GUICtrlCreateButton("...", 691, 65, 35, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetTip(-1, "Select FFMpeg folder binaries")
$ButtonResetFFMPegFolder = GUICtrlCreateButton("Reset", 732, 66, 35, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetTip(-1, "Reset FFMpeg folder to default")
$InputDestinationFolder = GUICtrlCreateInput("", 112, 100, 573, 21)
$ButtonSetDestination = GUICtrlCreateButton("...", 692, 98, 35, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetTip(-1, "Select destination folder")
$ButtonResetDestination = GUICtrlCreateButton("Reset", 732, 98, 35, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetTip(-1, "Reset destination folder to default")
$InputUStreamUrl = GUICtrlCreateInput("", 112, 133, 324, 21)
GUICtrlSetTip(-1, "Link Url RMTP")
$InputUStreamChannelKey = GUICtrlCreateInput("", 447, 133, 237, 21)
GUICtrlSetTip(-1, "Channel Key")
$LabelBroadcastIp = GUICtrlCreateLabel("Broadcast IP", 16, 41, 65, 17)
$LabelDestinationFolder = GUICtrlCreateLabel("DestinationFolder", 16, 103, 86, 17)
$LabelFFMpegFolder = GUICtrlCreateLabel("FFMpeg folder", 16, 71, 72, 17)
$LabelPort = GUICtrlCreateLabel("Port", 248, 39, 23, 17)
$LabelUStream = GUICtrlCreateLabel("uStream.tv", 17, 138, 55, 17)
$ButtonUStreamReset = GUICtrlCreateButton("Reset", 692, 130, 35, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetTip(-1, "Reset uStream configuration")
GUICtrlCreateGroup("", -99, -99, 1, 1)
$GroupEncodingProfile = GUICtrlCreateGroup("Profile", 8, 176, 1041, 352)
$ComboContainer = GUICtrlCreateCombo("", 16, 212, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "mp4|ts|mkv|m2ts", "ts")
$ComboPreset = GUICtrlCreateCombo("", 192, 212, 97, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "default|ultrafast|superfast|veryfast|faster|fast|medium|slow", "default")
$ComboVCodec = GUICtrlCreateCombo("", 16, 268, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "copy|h264 (CBR)|h264 (CRF)|h264_nvenc (CBR)|mpeg2video (CBR)|mpeg2video (QSCALE)", "copy")
$ComboScaleTo = GUICtrlCreateCombo("", 191, 268, 97, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "720:480|704:480|720:576|704:576|1280:720|1920:1080", "1280:720")
$InputVBitrate = GUICtrlCreateInput("5000", 321, 267, 75, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlSetLimit(-1, 5)
GUICtrlSetTip(-1, "Cbr (costant bitrate)")
$InputVCrf = GUICtrlCreateInput("18", 417, 267, 75, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlSetLimit(-1, 2)
GUICtrlSetTip(-1, "Constant Rate Factor")
$InputVQScale = GUICtrlCreateInput("5", 513, 267, 75, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlSetLimit(-1, 2)
GUICtrlSetTip(-1, "Quantizer scale")
$ComboACodec = GUICtrlCreateCombo("", 16, 324, 145, 25, BitOR($CBS_DROPDOWNLIST,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "copy|aac|ac3|libmp3lame|mp2", "copy")
$InputABitrate = GUICtrlCreateInput("192", 321, 323, 75, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_NUMBER))
GUICtrlSetLimit(-1, 5)
$CheckboxDeint = GUICtrlCreateCheckbox("Deinterlace", 16, 363, 74, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$CheckboxDeint2x = GUICtrlCreateCheckbox("Deinterlace (2x)", 104, 363, 95, 17)
$CheckboxUStream = GUICtrlCreateCheckbox("Stream to uStream.tv", 214, 363, 135, 17)
GUICtrlSetTip(-1, "Encode to uStream.Tv")
$InputRawProcess = GUICtrlCreateInput("", 16, 413, 1020, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
GUICtrlSetTip(-1, "Link Url RMTP")
$InputMainProcess = GUICtrlCreateInput("", 16, 461, 1020, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_READONLY))
GUICtrlSetTip(-1, "Link Url RMTP")
$ButtonProfileLoad = GUICtrlCreateButton("Load", 437, 494, 75, 25)
$ButtonProfileSave = GUICtrlCreateButton("Save", 525, 494, 75, 25)
$LabelContainer = GUICtrlCreateLabel("Container", 16, 194, 49, 17)
$LabelVCodec = GUICtrlCreateLabel("Video codec", 18, 250, 64, 17)
$LabelACodec = GUICtrlCreateLabel("Audio codec", 18, 306, 64, 17)
$LabelScaleTo = GUICtrlCreateLabel("Scale to", 191, 250, 43, 17)
$LabelPreset = GUICtrlCreateLabel("Preset", 192, 194, 34, 17)
$LabelVBitrate = GUICtrlCreateLabel("Video bitrate (Kb.)", 320, 250, 88, 17)
$LabelAVCodec = GUICtrlCreateLabel("Audio bitrate (Kb.)", 320, 306, 88, 17)
$LabelVCrf = GUICtrlCreateLabel("CRF (0-51)", 416, 250, 55, 17)
$LabelVQScale = GUICtrlCreateLabel("QScale (0-31)", 512, 250, 69, 17)
$LabelMainProcess = GUICtrlCreateLabel("Transport stream process command line", 17, 394, 191, 17)
$LabelMainProces = GUICtrlCreateLabel("Main process command line", 17, 442, 135, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$ButtonEncode = GUICtrlCreateButton("Encode (CTRL+E)", 300, 538, 103, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetTip(-1, "Start encoding")
$ButtonPreview = GUICtrlCreateButton("Preview", 413, 538, 103, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetTip(-1, "Preview")
$ButtonAbort = GUICtrlCreateButton("Abort (CTRL+A)", 528, 538, 103, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetTip(-1, "Abort encoding")
$ButtonExit = GUICtrlCreateButton("Exit (CTRL+X)", 644, 538, 103, 25, $BS_DEFPUSHBUTTON)
GUICtrlSetTip(-1, "Exit")
$StatusBar = _GUICtrlStatusBar_Create($MainForm)
Dim $StatusBar_PartsWidth[4] = [100, 910, 1000, -1]
_GUICtrlStatusBar_SetParts($StatusBar, $StatusBar_PartsWidth)
_GUICtrlStatusBar_SetText($StatusBar, "Ready", 0)
_GUICtrlStatusBar_SetText($StatusBar, "", 1)
_GUICtrlStatusBar_SetText($StatusBar, "", 2)
_GUICtrlStatusBar_SetText($StatusBar, "v 1.04", 3)
GUISetState(@SW_SHOW)
Dim $MainForm_AccelTable[3][2] = [["^e", $ButtonEncode],["^a", $ButtonAbort],["^x", $ButtonExit]]
GUISetAccelerators($MainForm_AccelTable)
#EndRegion ### END Koda GUI section ###

Opt("WinTitleMatchMode", -2) ;1=start, 2=subStr, 3=exact, 4=advanced, -1 to -4=Nocase
Global $Delay = 2000
Global $Config = @ScriptDir & "\config"
Global $sFFMPegFolder = ""
Global $iPIDFFMpegDest = 0
Global $iPIDFFMpegRaw = 0
Global $iPIDMPlayer = 0
Global $guidPIDFFMpegDest = ""
Global $guidPIDFFMpegRaw = ""
Global $sFileNameFFMpegDest = ""
Global $sFileNameFFMpegRaw = ""
Global $sFileFFMpegDest = ""
Global $sFileFFMpegRaw = ""
Global $sEncoding = False
Global $dTimeEncode = _NowCalc();
Global $dStartTimeEncode = _NowCalc();
Global $sUStream = ""

Global $bGrabMode = false;
Global $bEncodeToFileMode = false;
Global $bEncodeToUStreamMode = false;

Global $sCommandRaw = ""
Global $sCommand = ""

LoadConfiguration()

if not FileExists($Config) then
	SaveConfiguration()
EndIf

_GUICtrlButton_SetFocus($ButtonExit, true)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			if $sEncoding = True Then
				Abort()
			EndIf
			Exit
		Case $InputIpAddress
			HandleControls()
		Case $InputPort
			HandleControls()
		Case $InputUStreamUrl
			HandleControls()
		Case $InputUStreamChannelKey
			HandleControls()
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
		Case $ButtonUStreamReset
			GUICtrlSetData($InputUStreamUrl, "")
			GUICtrlSetData($InputUStreamChannelKey, "")
			SaveConfiguration()
		Case $ComboContainer
			HandleControls()
		Case $ComboPreset
			HandleControls()
		Case $ComboVCodec
			HandleControls()
		Case $ComboScaleTo
			HandleControls()
		Case $InputVBitrate
			HandleControls()
		Case $InputVCrf
			HandleControls()
		Case $InputVQScale
			HandleControls()
		Case $ComboACodec
			HandleControls()
		Case $InputABitrate
			HandleControls()
		Case $CheckboxDeint
			if GUICtrlRead($CheckboxDeint) = $GUI_CHECKED Then
				GUICtrlSetState($CheckboxDeint2x, $GUI_UNCHECKED)
			EndIf
			HandleControls()
		Case $CheckboxDeint2x
			if GUICtrlRead($CheckboxDeint2x) = $GUI_CHECKED Then
				GUICtrlSetState($CheckboxDeint, $GUI_UNCHECKED)
			EndIf
			HandleControls()
		Case $CheckboxUStream
			HandleControls()
		Case $ButtonProfileLoad
			LoadProfile()
		Case $ButtonProfileSave
			SaveProfile()
		Case $ButtonEncode
			Encode()
		Case $ButtonPreview
			Preview()
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

Func Preview()
		$sFFMPegFolder=GUICtrlRead($InputFFMpegFolder)
		if $sFFMPegFolder = "" Then
			$sFFMPegFolder = @ScriptDir & "\FFMPEG"
		EndIf
		Local $sExeMPlayer = "FFPLAY"
		Local $sCommandMPlayer = StringFormat("-ss %s -loglevel quiet -i %s -vf yadif=1,scale=640:-1,setdar=16/9 -window_title ""Lenkeng/ESYNiC HDMI Extender Encoder - Preview %s""", _
			_GUICtrlStatusBar_GetText($StatusBar, 2), _
			$sFileFFMpegRaw, _
			$sFileNameFFMpegRaw)
		$iPIDMPlayer = ShellExecute($sExeMPlayer, $sCommandMPlayer, $sFFMPegFolder, $SHEX_OPEN, @SW_HIDE)
EndFunc

Func Encode()
	GUICtrlSetState($ButtonAbort, $GUI_ENABLE)
	GUICtrlSetState($ButtonEncode, $GUI_DISABLE)
	GUICtrlSetState($ButtonExit, $GUI_DISABLE)

	$sFFMPegFolder=GUICtrlRead($InputFFMpegFolder)
	if $sFFMPegFolder = "" Then
		$sFFMPegFolder = @ScriptDir & "\FFMPEG"
	EndIf
	Local $sExe = $sFFMPegFolder & "\FFMPEG"

	Global $sEncoding = True
	$dStartTimeEncode = _NowCalc();
	$dTimeEncode = $dStartTimeEncode;

	Local $sInputDestinationFolder = GUICtrlRead($InputDestinationFolder)

 	if $sCommandRaw = "" then
		_GUICtrlStatusBar_SetText($StatusBar, "Encoding ...", 0)
		$iPIDFFMpegDest = ShellExecute($sExe, $sCommand, $sInputDestinationFolder, $SHEX_OPEN, @SW_HIDE)
		Local $hWnd = WinWait("ffmpeg", "", 5)
		$guidPIDFFMpegDest = _WinAPI_CreateGUID ( )
		WinSetTitle($hWnd, "", $guidPIDFFMpegDest)

		$tWaitFileRaw = TimerInit()
		While TimerDiff($tWaitFileRaw) < 5000
			If FileExists($sFileFFMpegRaw) then ExitLoop
		WEnd
		if TimerDiff($tWaitFileRaw) > 5000 Then
			_GUICtrlStatusBar_SetText($StatusBar, "Check broacast. No Signal?", 1)
			Abort()
			Return
		EndIf

	Else

		_GUICtrlStatusBar_SetText($StatusBar, "Starting ...", 0)
		$iPIDFFMpegRaw = ShellExecute($sExe, $sCommandRaw, $sInputDestinationFolder, $SHEX_OPEN, @SW_HIDE)
		Local $hWndRaw = WinWait("ffmpeg", "", 5)
		$guidPIDFFMpegRaw = _WinAPI_CreateGUID ( )
		WinSetTitle($hWndRaw, "", $guidPIDFFMpegRaw)

		$tWaitFileRaw = TimerInit()
		While TimerDiff($tWaitFileRaw) < 5000
			If FileExists($sFileFFMpegRaw) then ExitLoop
		WEnd
		if TimerDiff($tWaitFileRaw) > 5000 Then
			_GUICtrlStatusBar_SetText($StatusBar, "Check broacast. No Signal?", 1)
			Abort()
			Return
		EndIf

		Sleep($Delay)

		$dStartTimeEncode = _NowCalc();
		$dTimeEncode = $dStartTimeEncode;

		_GUICtrlStatusBar_SetText($StatusBar, "Encoding ...", 0)
		$iPIDFFMpegDest = ShellExecute($sExe, $sCommand, $sInputDestinationFolder, $SHEX_OPEN, @SW_HIDE)
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
		if $bEncodeToUStreamMode = False then
			_GUICtrlStatusBar_SetText($StatusBar, StringUpper($sFileNameFFMpegDest), 1)
		Else
			_GUICtrlStatusBar_SetText($StatusBar, GUICtrlRead($InputUStreamUrl), 1)
		EndIf
		_GUICtrlStatusBar_SetText($StatusBar, Sec_2_Time_Format($sElapsedSS), 2)
	EndIf
	if $iPIDFFMpegRaw > 0 Then
		if ProcessExists($iPIDFFMpegRaw) = 0 Then
			_GUICtrlStatusBar_SetText($StatusBar, "Error...", 0)
		EndIf
	EndIf
	if $iPIDFFMpegDest > 0 Then
		if ProcessExists($iPIDFFMpegDest) = 0 Then
			_GUICtrlStatusBar_SetText($StatusBar, "Error...", 0)
		EndIf
	EndIf
	if ProcessExists($iPIDMPlayer) = 0 AND _GUICtrlStatusBar_GetText($StatusBar, 2) <> "" Then
		if GUICtrlGetState($ButtonPreview) <> $GUI_ENABLE then
			GUICtrlSetState($ButtonPreview, $GUI_ENABLE)
		EndIf
	Else
		if GUICtrlGetState($ButtonPreview) <> $GUI_DISABLE then
			GUICtrlSetState($ButtonPreview, $GUI_DISABLE)
		EndIf
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
	GUICtrlSetState ($ComboVCodec,$GUI_ENABLE)
	GUICtrlSetState ($InputVBitrate,$GUI_ENABLE)
	GUICtrlSetState ($InputVCrf,$GUI_ENABLE)
	GUICtrlSetState ($ComboACodec,$GUI_ENABLE)
	GUICtrlSetState ($InputABitrate,$GUI_ENABLE)
	GUICtrlSetState ($CheckboxDeint,$GUI_ENABLE)
	GUICtrlSetState ($CheckboxDeint2x,$GUI_ENABLE)
	if _GUICtrlComboBox_GetCurSel($ComboVCodec) = 0 Then
		GUICtrlSetState ($ComboScaleTo,$GUI_DISABLE)
		GUICtrlSetState ($InputVBitrate,$GUI_DISABLE)
		GUICtrlSetState ($InputVCrf,$GUI_DISABLE)
		GUICtrlSetState ($InputVQScale,$GUI_DISABLE)
		GUICtrlSetState ($CheckboxDeint,$GUI_DISABLE)
		GUICtrlSetState ($CheckboxDeint2x,$GUI_DISABLE)
	EndIf
	if _GUICtrlComboBox_GetCurSel($ComboVCodec) = 1 Then ;~ 	H.264 Cbr
		GUICtrlSetState ($InputVBitrate,$GUI_ENABLE)
		GUICtrlSetState ($InputVCrf,$GUI_DISABLE)
		GUICtrlSetState ($InputVQScale,$GUI_DISABLE)
	ElseIf _GUICtrlComboBox_GetCurSel($ComboVCodec) = 2 then ;~ 	H.264 Crf
		GUICtrlSetState ($InputVCrf,$GUI_ENABLE)
		GUICtrlSetState ($InputVBitrate,$GUI_DISABLE)
		GUICtrlSetState ($InputVQScale,$GUI_DISABLE)
	ElseIf _GUICtrlComboBox_GetCurSel($ComboVCodec) = 3 then ;~ 	H.264 cbr (nvenc)
		GUICtrlSetState ($InputVBitrate,$GUI_ENABLE)
		GUICtrlSetState ($InputVCrf,$GUI_DISABLE)
		GUICtrlSetState ($InputVQScale,$GUI_DISABLE)
	ElseIf _GUICtrlComboBox_GetCurSel($ComboVCodec) = 4 then ;~ 	Mpeg2Video Cbr
		GUICtrlSetState ($InputVBitrate,$GUI_ENABLE)
		GUICtrlSetState ($InputVCrf,$GUI_DISABLE)
		GUICtrlSetState ($InputVQScale,$GUI_DISABLE)
	ElseIf _GUICtrlComboBox_GetCurSel($ComboVCodec) = 5 then ;~ 	Mpeg2Video QScale
		GUICtrlSetState ($InputVQScale,$GUI_ENABLE)
		GUICtrlSetState ($InputVBitrate,$GUI_DISABLE)
		GUICtrlSetState ($InputVCrf,$GUI_DISABLE)
	EndIf
	if _GUICtrlComboBox_GetCurSel($ComboACodec) = 0 Then
		GUICtrlSetState ($InputABitrate,$GUI_DISABLE)
	EndIf
	if GUICtrlRead($CheckboxUStream) = $GUI_UNCHECKED Then
		If (_GUICtrlComboBox_GetCurSel($ComboVCodec) = 0) And (_GUICtrlComboBox_GetCurSel($ComboACodec) = 0) Then
			$bGrabMode = True
			$bEncodeToFileMode = False
			$bEncodeToUStreamMode = False
			GUICtrlSetData  ($ButtonEncode,"Grab (CTRL+E)")
			GUICtrlSetState ($ComboContainer,$GUI_DISABLE)
			GUICtrlSetState ($ComboPreset,$GUI_DISABLE)
		Else
			$bGrabMode = False
			$bEncodeToFileMode = True
			$bEncodeToUStreamMode = False
			GUICtrlSetData  ($ButtonEncode,"Encode (CTRL+E)")
		EndIf
	Else
		$bGrabMode = False
		$bEncodeToFileMode = False
		$bEncodeToUStreamMode = True
		GUICtrlSetState ($ComboContainer,$GUI_DISABLE)
		GUICtrlSetState ($ComboVCodec,$GUI_DISABLE)
		GUICtrlSetState ($InputVBitrate,$GUI_ENABLE)
		GUICtrlSetState ($InputVCrf,$GUI_DISABLE)
		GUICtrlSetState ($ComboScaleTo,$GUI_DISABLE)
		GUICtrlSetState ($ComboACodec,$GUI_DISABLE)
		GUICtrlSetState ($CheckboxDeint2x,$GUI_DISABLE)
		GUICtrlSetData($ButtonEncode,"Stream (CTRL+E)")
	EndIf

	GenerateRawProcessCommandLine()
	GenerateMainProcessCommandLine()

EndFunc

Func GenerateRawProcessCommandLine()

	$sCommandRaw = ""

	Local $ext = GUICtrlRead($ComboContainer)
	Local $sInputDestinationFolder = GUICtrlRead($InputDestinationFolder)
	if GUICtrlRead($ComboVCodec) = "copy" And GUICtrlRead($ComboACodec) = "copy" then
		$ext = "ts"
	EndIf

 	$sFileNameFFMpegRaw = "hdmi" & @MON & @MDAY & "_" & @HOUR & @MIN & @SEC & ".ts"
	$sFileFFMpegRaw = $sInputDestinationFolder & "\" & $sFileNameFFMpegRaw

	if $bEncodeToFileMode = True or $bEncodeToUStreamMode = True then
		$sCommandRaw = StringFormat("-y -loglevel quiet -i udp://@%s:%s ", GUICtrlRead($InputIpAddress), GUICtrlRead($InputPort))
		$sCommandRaw = $sCommandRaw & " "
		$sCommandRaw = $sCommandRaw & "-c:v copy -c:a copy"
		$sCommandRaw = $sCommandRaw & " "
		$sCommandRaw = $sCommandRaw & StringFormat("%s", $sFileNameFFMpegRaw)
	EndIf

	GUICtrlSetData($InputRawProcess, $sCommandRaw)
	_GUICtrlEdit_SetSel($InputRawProcess, 0, 0)

EndFunc

Func GenerateMainProcessCommandLine()

	$sCommand = ""

	Local $ext = GUICtrlRead($ComboContainer)
	Local $sInputDestinationFolder = GUICtrlRead($InputDestinationFolder)
	if GUICtrlRead($ComboVCodec) = "copy" And GUICtrlRead($ComboACodec) = "copy" then
		$ext = "ts"
	EndIf

	$sFileNameFFMpegDest = "out" & @MON & @MDAY & "_" & @HOUR & @MIN & @SEC & "." & $ext
	$sFileFFMpegDest = $sInputDestinationFolder & "\" & $sFileNameFFMpegDest

	Local $sCodec = GUICtrlRead($ComboVCodec)
	Local $bHWEnc = False
	If _GUICtrlComboBox_GetCurSel($ComboVCodec) = 3 Or _GUICtrlComboBox_GetCurSel($ComboVCodec) = 4 Then
		$bHWEnc = True
	EndIf

	; entry & input
	if $bGrabMode then
		$sCommand = StringFormat("-y -loglevel quiet -i udp://@%s:%s", GUICtrlRead($InputIpAddress), GUICtrlRead($InputPort))
		$sCommand = $sCommand & " "
	else
		if $bHWEnc = False then
			$sCommand = StringFormat("-re -y -loglevel quiet -i %s", $sFileNameFFMpegRaw)
		Else
			$sCommand = StringFormat("-re -y -loglevel quiet -c:v h264_cuvid -i %s", $sFileNameFFMpegRaw)
		EndIf
		$sCommand = $sCommand & " "
	EndIf

	; video option
	Local $sVfParam = "-vf "
	if GUICtrlRead($CheckboxDeint) = $GUI_CHECKED Then
		$sVfParam = $sVfParam & "yadif,"
	EndIf
	if GUICtrlRead($CheckboxDeint2x) = $GUI_CHECKED Then
		$sVfParam = $sVfParam & "yadif=1,"
	EndIf

	Local $aScaleTo=StringSplit(GUICtrlRead($ComboScaleTo),":")
	Local $iWidth = $aScaleTo[1]
	Local $iHeight = $aScaleTo[2]

	$sVfParam = $sVfParam & StringFormat("scale=%s:%s", $iWidth, $iHeight)
	if $iWidth/$iHeight < 16/9 then
		$sVfParam = $sVfParam & ",setdar=16/9"
	EndIf
	if GUICtrlRead($ComboVCodec) <> "copy" then
		$sCommand = $sCommand & StringFormat("%s", $sVfParam)
		$sCommand = $sCommand & " "
	EndIf

	if _GUICtrlComboBox_GetCurSel($ComboVCodec) = 1 Then ;~ 	H.264 Cbr
		$sCodec = StringLeft($sCodec, 4)
	ElseIf _GUICtrlComboBox_GetCurSel($ComboVCodec) = 2 Then ;~ 	H.264 Vbr
		$sCodec = StringLeft($sCodec, 4)
	ElseIf _GUICtrlComboBox_GetCurSel($ComboVCodec) = 3 Then ;~ 	H.264 cbr Nvenc
		$sCodec = StringLeft($sCodec, 10)
	ElseIf _GUICtrlComboBox_GetCurSel($ComboVCodec) = 4 Then ;~ 	H.264 qp Nvenc
		$sCodec = StringLeft($sCodec, 10)
	ElseIf _GUICtrlComboBox_GetCurSel($ComboVCodec) = 5 then ;~ 	Mpeg2Video Cbr
		$sCodec = StringLeft($sCodec, 10)
	ElseIf _GUICtrlComboBox_GetCurSel($ComboVCodec) = 6 then ;~ 	Mpeg2Video QScale
		$sCodec = StringLeft($sCodec, 10)
	EndIf
	$sCommand = $sCommand & StringFormat("-c:v %s", $sCodec)
	$sCommand = $sCommand & " "

	if _GUICtrlComboBox_GetCurSel($ComboVCodec) = 1 Then ;~ 	H.264 Cbr
		$sCommand = $sCommand & StringFormat("-b:v %sk", GUICtrlRead($InputVBitrate))
		$sCommand = $sCommand & " "
	Elseif _GUICtrlComboBox_GetCurSel($ComboVCodec) = 2 Then ;~ 	H.264 Vbr
		$sCommand = $sCommand & StringFormat("-crf %s", GUICtrlRead($InputVCrf))
		$sCommand = $sCommand & " "
	Elseif _GUICtrlComboBox_GetCurSel($ComboVCodec) = 3 Then ;~ 	H.264 Cbr Nvenc
		$sCommand = $sCommand & StringFormat("-cbr true -b:v %sk", GUICtrlRead($InputVBitrate))
		$sCommand = $sCommand & " "
	ElseIf _GUICtrlComboBox_GetCurSel($ComboVCodec) = 4 then ;~ 	Mpeg2Video Cbr
		$sCommand = $sCommand & StringFormat("-b:v %sk", GUICtrlRead($InputVBitrate))
		$sCommand = $sCommand & " "
	ElseIf _GUICtrlComboBox_GetCurSel($ComboVCodec) = 5 then ;~ 	Mpeg2Video QScale
		$sCommand = $sCommand & StringFormat("-qscale %s", GUICtrlRead($InputVQScale))
		$sCommand = $sCommand & " "
	EndIf

	; audio option
	$sCommand = $sCommand & StringFormat("-c:a %s", GUICtrlRead($ComboACodec))
	$sCommand = $sCommand & " "

	if _GUICtrlComboBox_GetCurSel($ComboACodec) > 0 Then ;~ 	not copy
		$sCommand = $sCommand & StringFormat("-b:a %sk", GUICtrlRead($InputABitrate))
		$sCommand = $sCommand & " "
	EndIf

	; preset
	if GUICtrlRead($ComboPreset) <> "default" And GUICtrlRead($ComboVCodec) <> "copy" then
		$sCommand = $sCommand & StringFormat("-preset %s", GUICtrlRead($ComboPreset))
		$sCommand = $sCommand & " "
	EndIf

	; destination
	$sCommand = $sCommand & StringFormat("%s", $sFileNameFFMpegDest)

	; ustream
	if $bEncodeToUStreamMode = True then
		$sCommand = StringFormat("-re -y -loglevel quiet -i %s", $sFileNameFFMpegRaw)
		$sCommand = $sCommand & " "

		$sVfParam = "-vf "
		if GUICtrlRead($CheckboxDeint) = $GUI_CHECKED Then
			$sVfParam = $sVfParam & "yadif,"
		EndIf
		$sVfParam = $sVfParam & StringFormat("scale=%s", "1280:720")
		$sCommand = $sCommand & " "

		$sCommand = $sCommand & StringFormat("-c:v %s", "h264")
		$sCommand = $sCommand & " "

		$sCommand = $sCommand & StringFormat("-b:v %sk", GUICtrlRead($InputVBitrate))
		$sCommand = $sCommand & " "

		$sCommand = $sCommand & StringFormat("-c:a %s", "aac")
		$sCommand = $sCommand & " "

		$sCommand = $sCommand & StringFormat("-b:a %sk", GUICtrlRead($InputABitrate))
		$sCommand = $sCommand & " "

		$sCommand = $sCommand & "-g 50 -profile:v main -f flv"
		$sCommand = $sCommand & " "

		$sInputUStreamUrl=GUICtrlRead($InputUStreamUrl)
		$sInputUStreamChannelKey=GUICtrlRead($InputUStreamChannelKey)

		$sUStream = StringFormat("%s/%s", $sInputUStreamUrl, $sInputUStreamChannelKey)

		$sCommand = $sCommand & StringFormat("%s", $sUStream)

	EndIf

	GUICtrlSetData($InputMainProcess, $sCommand)
	_GUICtrlEdit_SetSel($InputMainProcess, 0, 0)

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

	Local $sInputUStreamUrl = IniRead($Config, "General", "UStreamUrl","")
	GUICtrlSetData($InputUStreamUrl, $sInputUStreamUrl)

	Local $sInputUStreamChannelKey = IniRead($Config, "General", "UStreamChannelKey","")
	GUICtrlSetData($InputUStreamChannelKey, $sInputUStreamChannelKey)

	;~ 	Encoding video
	Local $sComboContainer = IniRead($Config, "Encoding", "Container","")
	if $sComboContainer = "" Then
		$sComboContainer = "mp4"
	EndIf
	GUICtrlSetData($ComboContainer, $sComboContainer)

	Local $sComboPreset = IniRead($Config, "Encoding", "Preset","")
	if $sComboPreset = "" Then
		$sComboPreset = "default"
	EndIf
	GUICtrlSetData($ComboPreset, $sComboPreset)

	Local $sComboVCodec = IniRead($Config, "Encoding", "VCodec","")
	if $sComboVCodec = "" Then
		$sComboVCodec = "h264 (CRF)"
	EndIf
	GUICtrlSetData($ComboVCodec, $sComboVCodec)

	Local $sComboScaleTo = IniRead($Config, "Encoding", "ScaleTo","")
	if $sComboScaleTo = "" Then
		$sComboScaleTo = "1280:720"
	EndIf
	GUICtrlSetData($ComboScaleTo, $sComboScaleTo)

	Local $sInputVBitrate = IniRead($Config, "Encoding", "VBitrate","")
	if $sInputVBitrate = "" Then
		$sInputVBitrate = "5000"
	EndIf
	GUICtrlSetData($InputVBitrate, $sInputVBitrate)

	Local $sInputVCrf = IniRead($Config, "Encoding", "VCrf","")
	if $sInputVCrf = "" Then
		$sInputVCrf = "23"
	EndIf
	GUICtrlSetData($InputVCrf, $sInputVCrf)

	Local $sInputVQScale = IniRead($Config, "Encoding", "VQScale","")
	if $sInputVQScale = "" Then
		$sInputVQScale = "5"
	EndIf
	GUICtrlSetData($InputVQScale, $sInputVQScale)

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

	Local $sInputABitrate = IniRead($Config, "Encoding", "ABitrate","")
	if $sInputABitrate = "" Then
		$sInputABitrate = "192"
	EndIf
	GUICtrlSetData($InputABitrate, $sInputABitrate)

	;~ 	Ustream
	Local $sCheckboxUStream = IniRead($Config, "Encoding", "UStream", false)
	if $sCheckboxUStream = "true" Then
		GUICtrlSetState($CheckboxUStream, $GUI_CHECKED)
	Else
		GUICtrlSetState($CheckboxUStream, $GUI_UNCHECKED)
	EndIf


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

	Local $sInputUStreamUrl = GUICtrlRead($InputUStreamUrl)
	IniWrite($Config, "General", "UStreamUrl", $sInputUStreamUrl)

	Local $sUStreamChannelKey = GUICtrlRead($InputUStreamChannelKey)
	IniWrite($Config, "General", "UStreamChannelKey", $sUStreamChannelKey)

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

	Local $sInputVCrf = GUICtrlRead($InputVCrf)
	IniWrite($Config, "Encoding", "VCrf", $sInputVCrf)

	Local $sInputVQScale = GUICtrlRead($InputVQScale)
	IniWrite($Config, "Encoding", "VQScale", $sInputVQScale)

		Local $sCheckboxDeint = GUICtrlRead($CheckboxDeint) = $GUI_CHECKED
	IniWrite($Config, "Encoding", "Deint", $sCheckboxDeint)

	Local $sCheckboxDeint2x = GUICtrlRead($CheckboxDeint2x) = $GUI_CHECKED
	IniWrite($Config, "Encoding", "Deint2x", $sCheckboxDeint2x)

	;~ 	Encoding audio
	Local $sComboACodec = GUICtrlRead($ComboACodec)
	IniWrite($Config, "Encoding", "ACodec", $sComboACodec)

	Local $sInputABitrate = GUICtrlRead($InputABitrate)
	IniWrite($Config, "Encoding", "ABitrate", $sInputABitrate)

	;~ 	Ustream
	Local $sCheckboxUStream = GUICtrlRead($CheckboxUStream) = $GUI_CHECKED
	IniWrite($Config, "Encoding", "UStream", $sCheckboxUStream)

EndFunc

Func LoadProfile()
	$Profile = FileOpenDialog("Load profile", @ScriptDir, "Profile (*.pro)", BitOR($FD_PATHMUSTEXIST,$FD_FILEMUSTEXIST))
	if not @error > 0  then
		$EncodingSection = IniReadSection($Profile, "Encoding")
		IniWriteSection($Config, "Encoding", $EncodingSection)
		LoadConfiguration()
	EndIf
EndFunc

Func SaveProfile()
	$Profile = FileSaveDialog("Save profile", @ScriptDir, "Profile (*.pro)", BitOR($FD_PATHMUSTEXIST,$FD_PROMPTOVERWRITE))
	if not @error > 0  then
		SaveConfiguration()
		$EncodingSection = IniReadSection($Config, "Encoding")
		IniWriteSection($Profile, "Encoding", $EncodingSection)
	EndIf
EndFunc
