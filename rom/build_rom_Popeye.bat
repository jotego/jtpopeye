rem version 2.10 - 2019/07/28
@echo off
setlocal ENABLEDELAYEDEXPANSION
set pwd=%~dp0
MODE CON COLS=132 LINES=50
color 2 
Title Popeye's Arcade Rom Creator
set "verb=> nul"
set /A merged=0
set /A mist=1

:MENU
cls
echo                             .-'''-.                                                                                
echo                            '   _    \                                                                              
echo _________   _...._       /   /` '.   \_________   _...._            __.....__                       __.....__      
echo \        ^|.'      '-.   .   ^|     \  '\        ^|.'      '-.     .-''         '. .-.          .- .-''         '.    
echo  \        .'```'.    '. ^|   '      ^|  '\        .'```'.    '.  /     .-''"'-.  `.\ \        / //     .-''"'-.  `.  
echo   \      ^|       \     \\    \     / /  \      ^|       \     \/     /________\   \\ \      / //     /________\   \ 
echo    ^|     ^|        ^|    ^| `.   ` ..' /    ^|     ^|        ^|    ^|^|                  ^| \ \    / / ^|                  ^| 
echo    ^|      \      /    .     '-...-'`     ^|      \      /    . \    .-------------'  \ \  / /  \    .-------------' 
echo    ^|     ^|\`'-.-'   .'                   ^|     ^|\`'-.-'   .'   \    '-.____...---.   \ `  /    \    '-.____...---. 
echo    ^|     ^| '-....-'`                     ^|     ^| '-....-'`      `.             .'     \  /      `.             .'  
echo   .'     '.                             .'     '.                 `''-...... -'       / /         `''-...... -'    
echo '-----------'                         '-----------'                               ^|`-' /                           
echo                                                                                    '..'                            

echo.
if %merged% EQU 0 (
echo Copy Mame Non-Merged set files to !pwd!MAME folder
) else (
echo Copy Mame Merged set files to !pwd!MAME folder
)
echo Copy HBMame Merged set files to !pwd!HBMAME folder
echo.
if %mist% EQU 1 (
echo Default rom and help is configured for: MIST
) else (
echo Default rom and help is configured for: MISTer
)
echo.
echo Press H for Help
echo.
echo ** MENU **
echo 1 - Popeye (revision D not protected) - popeyeu.zip (Mame) - ORIGINAL
echo 2 - Popeye (bootleg set 3) - popeyeb3.zip (Mame)
echo.

if %merged% EQU 0 (
echo C - Change from Non-Merged to Merged MAME ROM SET
) else (
echo C - Change from Merged to Non-Merged MAME ROM SET
)
if %mist% EQU 1 (
echo M - Change from MIST to MISTer
) else (
echo M - Change from MISTer to MIST
)
echo H - HELP
if "%verb%" EQU "" (
echo V - Set verbose Off
) else (
echo V - Set verbose On
)
echo Q - Quit


if NOT EXIST "!pwd!MAME" mkdir "!pwd!MAME" 2> nul

echo.
SET /P M="Choose option and then press ENTER (or Q to quit): "
IF '%M%'=='1' GOTO POPEYEU
IF '%M%'=='2' GOTO POPEYEB3

IF '%M%'=='c' GOTO CHANGEMERGED
IF '%M%'=='C' GOTO CHANGEMERGED

IF '%M%'=='h' GOTO HELP
IF '%M%'=='H' GOTO HELP
IF '%M%'=='m' GOTO CHANGEFPGA
IF '%M%'=='M' GOTO CHANGEFPGA
IF '%M%'=='v' GOTO VERBOSE
IF '%M%'=='V' GOTO VERBOSE
IF '%M%'=='q' GOTO QUIT
IF '%M%'=='Q' GOTO QUIT

GOTO MENU

:POPEYEU
set zip1m=MAME\popeye.zip
set ifilesm=popeyeu\7a+popeyeb3\bdf-6+popeyeb3\bdf-7+popeyeu\7e+tpp2-v.1e+tpp2-v.1f+tpp2-v.1j+tpp2-v.1k+tpp2-v.5n+tpp2-v.7j+tpp2-c.5b+tpp2-c.5a+tpp2-c.4a+tpp2-c.3a
set zip1=MAME\popeyeu.zip
set ifiles=7a+7b+7c+7e+tpp2-v.1e+tpp2-v.1f+tpp2-v.1j+tpp2-v.1k+tpp2-v.5n+tpp2-v.7j+tpp2-c.5b+tpp2-c.5a+tpp2-c.4a+tpp2-c.3a
set md5valid=b288ce65ce74fedf56c236f113721386
if %mist% EQU 1 (
set ofile=jtpopeye.rom
) else (
set ofile=a.pop.rom
)
set fullname=Popeye (revision D not protected) - popeyeu.zip (Mame)
GOTO START

:POPEYEB3
set zip1m=MAME\popeye.zip
set ifilesm=popeyeb3\bdf-5+popeyeb3\bdf-6+popeyeb3\bdf-7+popeyeb3\bdf-8+tpp2-v.1e+tpp2-v.1f+tpp2-v.1j+tpp2-v.1k+tpp2-v.5n+tpp2-v.7j+tpp2-c.5b+tpp2-c.5a+tpp2-c.4a+tpp2-c.3a
set zip1=MAME\popeyeb3.zip
set ifiles=bdf-5+bdf-6+bdf-7+bdf-8+bdf-4+bdf-3+bdf-2+bdf-1+bdf-9+tpp2-v.7j+tpp2-c.5b+tpp2-c.5a+tpp2-c.4a+tpp2-c.3a
set md5valid=e6ba0b8f7403d854e3f39155942683fc
set ofile=Popeye (bootleg set 3).rom
set fullname=Popeye (bootleg set 3) - popeyeb3.zip (Mame)
GOTO START


:CHANGEMERGED
if %merged% EQU 0 (
	set /A merged=1
	echo.
	echo You will now use Merged MAME ROM SET. Press a key to continue...
) else (
	set /A merged=0
	echo.
	echo You will now use Non-Merged MAME ROM SET. Press a key to continue...
)
pause > nul
GOTO MENU

:CHANGEFPGA
if %mist% EQU 1 (
	set /A mist=0
	echo.
	echo You will now use MISTer configuration. Press a key to continue...
) else (
	set /A mist=1
	echo.
	echo You will now use MIST configuration. Press a key to continue...
)
pause > nul
GOTO MENU

:VERBOSE
if "%verb%" EQU "" (
	set "verb=> nul"
	echo.
	echo Verbose is Off. Press a key to continue...
) else (
	set "verb="
	echo.
	echo Verbose is On. Press a key to continue...
)
pause > nul
GOTO MENU

:START

rem =====================================
echo.
echo.

if %merged% EQU 1 (
	set zip1=%zip1m%
	set ifiles=%ifilesm%
)


if NOT EXIST %zip1% GOTO ERRORZIP1
if NOT EXIST "!pwd!7za.exe" GOTO ERROR7Z
echo.
echo Starting creating rom for %fullname%
echo.
echo Unziping rom file...
echo.
"!pwd!7za" x -y -otmp %zip1% %verb%

	if !ERRORLEVEL! EQU 0 ( 
		cd tmp
		echo.
		echo Creating rom file...
		echo.
		copy /b /y /v %ifiles% "!pwd!%ofile%" %verb%
		
			if !ERRORLEVEL! EQU 0 ( 
				cd "!pwd!"
				
				set "md5="
					echo.
					echo Checking MD5...
					echo.				
					for /f "skip=1 tokens=* delims=" %%# in ('certutil -hashfile "!pwd!%ofile%" MD5') do (
						if not defined md5 (
							for %%Z in (%%#) do  (
								set "md5=%%Z"
							)
						)
					)	
			
				if "%md5valid%" EQU "!md5!" (
					echo.
					echo ** Process is complete! **
					echo.
					echo Copy "%ofile%" into SD card
				) else (
					echo.
					echo ** PROBLEM IN ROM **
					echo.
					echo MD5 DOESN'T MATCH! CHECK YOU ZIP FILE
					echo It could work anyway...
					echo.
					echo MD5 is !md5! but should be "%md5valid%"
				)
			) else (
				GOTO ERRORCOPY
			)
		cd !pwd!
		rmdir /s /q tmp	
		GOTO END		
	) else (
		GOTO ERRORUNZIP
	)

:ERRORZIP1
	echo.
	echo Error: Cannot find "%zip1%" file.
	GOTO END
	
:ERROR7Z
	echo.
	echo Error: Cannot find "7za.exe" file. Put it in the same directory as "%~nx0"!
	GOTO END

:ERRORCOPY
	cd !pwd!
	rmdir /s /q tmp > nul
	echo.
	echo Error: Problem creating rom!
	echo. 
	GOTO END

:ERRORUNZIP
	cd !pwd!
	rmdir /s /q tmp > nul
	echo.
	echo Error: problem unzipping file!
	echo. 
	GOTO END
	

:HELP
color 7
cls
echo                             .-'''-.                                                                                
echo                            '   _    \                                                                              
echo _________   _...._       /   /` '.   \_________   _...._            __.....__                       __.....__      
echo \        ^|.'      '-.   .   ^|     \  '\        ^|.'      '-.     .-''         '. .-.          .- .-''         '.    
echo  \        .'```'.    '. ^|   '      ^|  '\        .'```'.    '.  /     .-''"'-.  `.\ \        / //     .-''"'-.  `.  
echo   \      ^|       \     \\    \     / /  \      ^|       \     \/     /________\   \\ \      / //     /________\   \ 
echo    ^|     ^|        ^|    ^| `.   ` ..' /    ^|     ^|        ^|    ^|^|                  ^| \ \    / / ^|                  ^| 
echo    ^|      \      /    .     '-...-'`     ^|      \      /    . \    .-------------'  \ \  / /  \    .-------------' 
echo    ^|     ^|\`'-.-'   .'                   ^|     ^|\`'-.-'   .'   \    '-.____...---.   \ `  /    \    '-.____...---. 
echo    ^|     ^| '-....-'`                     ^|     ^| '-....-'`      `.             .'     \  /      `.             .'  
echo   .'     '.                             .'     '.                 `''-...... -'       / /         `''-...... -'    
echo '-----------'                         '-----------'                               ^|`-' /                           
echo                                                                                    '..'                            

echo.
echo HELP for this .bat file
echo.
echo ** Merged and Non-Merged mame roms **
echo By default this .bat file uses non-merged version of mame roms. You can change to merged version by pressing C in the menu
echo.
echo ** Verbose **
echo By default the .bat doesn't display the output of some commands (unzip/copy). You can see the output by pressing V in the menu.
echo.
echo ** Rom Creation **
echo Choose a number from the menu to create a rom from the zip files from mame. This .bat file checks the md5 for the rom created.
echo Having a different md5 doesn't mean that the rom doesn't work.
echo.
echo ** Copy Files to SD Card **
if %mist% EQU 1 (
echo Copy jtpopeye.rom to SDCard's root and the other roms to jtpopeye folder.
) else (
echo Copy a.pop.rom to SDCard's root or bootrom folder and the other roms to a.pop folder.
)
echo.
echo ** For reference **
echo.
echo Merged Set:
echo A merged set takes the parent set and one or more clone sets and puts them all inside the parent set^'s storage. To use the 
echo existing Pac-Man example, combining the Puckman, Midway Pac-Man (USA) sets, along with various bootleg versions - and combining 
echo it all into PUCKMAN.ZIP, would be making a merged set.
echo Remark: The parent games in a merged set DO NOT include BIOS or DEVICE files - they are separate files within the set (An example 
echo would be 100lions (No BIOS in the parent) and Galaga (No device file in the parent) - This is per MAME design.
echo.
echo Non-Merged Set:
echo A non-merged set is one that contains absolutely everything necessary for a given game to run in one ZIP file.
echo The non-merged set is ideal for those people that work on Arcade PCBs as ALL roms/devices/bios files are contained within the game. 
echo This set is also great for those that for instance create their own arcade cabinets and want to copy only very specific games to 
echo their PC/Rapsberry/Other, the game.zip file contain all the files needed, no more searching for the dependent parent files, BIOS 
echo files, device files - just copy galaga.zip and you are set.
echo.
echo.
echo Press a key to return to menu...
pause > nul
color 2 
GOTO MENU



:END
echo.
echo.
echo Press a key to return to menu...
pause > nul
GOTO MENU

:QUIT

