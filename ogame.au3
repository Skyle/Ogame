#include <IE.au3>
#include <GUIConstantsEx.au3>

Opt("GUIOnEventMode", 1)  ; Change to OnEvent mode 
$mainwindow = GUICreate("Ogame Bot", 480, 320)
$LoginButton = GUICtrlCreateButton("Login", 170, 1, 60,20)
$MetallMineButton = GUICtrlCreateButton("Metallmine", 1, 30, 100,20)
$KristallMineButton = GUICtrlCreateButton("Kristallmine", 1, 52, 100,20)
$DeuteriumMineButton = GUICtrlCreateButton("Deuteriummine", 1, 72, 100,20)
GUISetOnEvent($GUI_EVENT_CLOSE, "CLOSEClicked")
$BenutzerName = GUICtrlCreateInput ( "Skyle", 1, 1 , 75 , 20 )
$BenutzerPassword = GUICtrlCreateInput ( "devilvok55", 80,  1)
GUICtrlSetOnEvent($LoginButton, "LoginKomplett")
GUICtrlSetOnEvent($MetallMineButton, "MetallmineBauen")
GUICtrlSetOnEvent($KristallMineButton, "KristallmineBauen")
GUICtrlSetOnEvent($DeuteriumMineButton, "DeuteriummineBauen")
GUISetState(@SW_SHOW)


While 1
  Sleep(1000)  ; Idle around
WEnd

Func Login($oIE,$name,$password)
   $oForm = _IEGetObjById($oIE, "usernameLogin")
   _IEFormElementSetValue($oForm, $name)
   $oForm = _IEGetObjById($oIE, "passwordLogin")
   _IEFormElementSetValue($oForm, $password)
   $oForm = _IEGetObjById($oIE, "serverLogin")
   _IEFormElementOptionSelect($oForm, "uni114.ogame.de")
EndFunc

Func IstLoginAuf($oIE)
   $LoginId = _IEGetObjById($oIE, "login")
   $LoginString = _IEPropertyGet($LoginId, "outerhtml")
   $LoginStringFinal = StringMid($LoginString, 1, 60 )
   $StringCheckDisplayBlock = StringRegExp($LoginStringFinal,'display: block')
   Return $StringCheckDisplayBlock
EndFunc

Func ButtonClick($oIE, $ButtonId)
   Local $Button = _IEGetObjById($oIE, $ButtonId)
   _IEAction($Button, "click")
EndFunc

Func LoginKomplett()
   Global $oIE = _IECreate("ogame.de")
   Local $password = GUICtrlRead($BenutzerPassword)
   Local $name = GUICtrlRead($BenutzerName)
   If IstLoginAuf($oIE) == 1 Then
	  Login($oIE,$name,$password)
	  ButtonClick($oIE,"loginSubmit")
   ElseIf IstLoginAuf($oIE) == 0 Then
	  ButtonClick($oIE,"loginBtn")
	  Login($oIE,$name,$password)
	  ButtonClick($oIE,"loginSubmit")
   EndIf
EndFunc

Func LinkClick($LinkName)
   _IELinkClickByText($oIE, $LinkName)
EndFunc

Func VersorgungAufrufen()
   _IELinkClickByText($oIE, "Versorgung")
EndFunc   
   
Func DeuteriummineBauen()
   VersorgungAufrufen()
   _IELinkClickByText($oIE, "Deuterium-Synthetisierer")
EndFunc

Func CLOSEClicked()
    Exit
EndFunc
