; Deathmatch Pack install script
; Copyright © Orospu Çocuğu Erdoğan Sikimi Yesin Software

;================================================================
; Preparation

!include MUI2.nsh
!include LogicLib.nsh

Name "Deathmatch Pack"
OutFile "dm_inst.exe"
Unicode True
InstallDir "H:\Apps\Deathmatch"
RequestExecutionLevel user
ShowInstDetails show
BrandingText "Orospu ${U+00C7}ocu${U+011F}u Erdo${U+011F}an Sikimi Yesin Software"

Var Dialog
Var Label
Var Text
Var DoomName

;================================================================
; Settings

!define MUI_ABORTWARNING
!define MUI_FINISHPAGE_NOREBOOTSUPPORT
!define MUI_WELCOMEFINISHPAGE_BITMAP "wizard_mq_logo.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "wizard_mq_logo.bmp"

;================================================================
; Pages

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "license.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
Page custom nsDialogsPage nsDialogsPageLeave
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;================================================================
; Language

!insertmacro MUI_LANGUAGE "English"

;================================================================
; Username

Function nsDialogsPage
	!insertmacro MUI_HEADER_TEXT "Enter Name" "Define your Doom screen name."
	nsDialogs::Create 1018
	Pop $Dialog
	${If} $Dialog == error
		Abort
	${EndIf}
	${NSD_CreateLabel} 0 0 100% 12u "This is the name other players see whilst in network matches and in the chat."
	Pop $Label
	${NSD_CreateText} 0 49u 100% 12u "Player"
	Pop $Text
	nsDialogs::Show
FunctionEnd

Function nsDialogsPageLeave
	${NSD_GetText} $Text $0
	${If} $0 == ""
		StrCpy $0 "Player"
	${EndIf}
	Push $0
FunctionEnd

;================================================================
; Installer

Section "Base Application" SecBase
	SectionIn RO
	SetOutPath $INSTDIR
	File /a files\freedm.wad
	File /a files\game_host.bat
	File /a files\game_join.bat
	File /a files\game_support.pk3
	File /a files\game_widescreen_gfx.pk3
	File /a files\gzdoom.exe
	File /a files\gzdoom.ini
	File /a files\gzdoom.pk3
	File /a files\gzdoom.sf2
	File /a files\libsndfile-1.dll
	File /a files\openal32.dll
	File /a files\zmusic.dll
	Pop $DoomName
	WriteINIStr $OUTDIR\gzdoom.ini Doom.Player name $DoomName
	WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd

Section "Create Shortcuts" SecLnk
	SetOutPath $INSTDIR
	CreateShortCut "$DESKTOP\Host Deathmatch Game.lnk" $OUTDIR\game_host.bat
	CreateShortCut "$DESKTOP\Join Deathmatch Game.lnk" $OUTDIR\game_join.bat
SectionEnd

;================================================================
; Component stuff

LangString DESC_SecBase ${LANG_ENGLISH} "The base components (required)."
LangString DESC_SecLnk ${LANG_ENGLISH} "Create shortcuts on desktop."

!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro MUI_DESCRIPTION_TEXT ${SecBase} $(DESC_SecBase)
	!insertmacro MUI_DESCRIPTION_TEXT ${SecLnk} $(DESC_SecLnk)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;================================================================
; Uninstaller

Section "Uninstall"
	Delete $INSTDIR\Uninstall.exe
	Delete $INSTDIR\freedm.wad
	Delete $INSTDIR\game_host.bat
	Delete $INSTDIR\game_join.bat
	Delete $INSTDIR\game_support.pk3
	Delete $INSTDIR\game_widescreen_gfx.pk3
	Delete $INSTDIR\gzdoom.exe
	Delete $INSTDIR\gzdoom.ini
	Delete $INSTDIR\gzdoom.pk3
	Delete $INSTDIR\gzdoom.sf2
	Delete $INSTDIR\libsndfile-1.dll
	Delete $INSTDIR\openal32.dll
	Delete $INSTDIR\zmusic.dll
	RMDir $INSTDIR
SectionEnd