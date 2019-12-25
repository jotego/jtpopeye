JTPOPEYE FPGA Clone of Popeye arcade games by Jose Tejada (@topapate)
=========================================================================

This clone has been made thanks to Scralings' suggestion. He is a director patron and introduced me to this great game. Thanks Scralings!

You can show your appreciation through
    * Patreon: https://patreon.com/topapate
    * Paypal: https://paypal.me/topapate

Yes, you always wanted to have a Popeye arcade board at home. First you couldn't get it because your parents somehow did not understand you. Then you grow up and your wife doesn't understand you either. Don't worry, MiST(er) is here to the rescue.

What you get with this is an extremely accurate (allegedly 100% accurate) clone of the original hardware.

I hope you will have as much fun with it as I had it while making it!

Supported Games
===============

* Popeye (unprotected versions)

To do list
==========

* Add support for protection. 
    I have tried a bit but somehow I don't get the interface right. Schematics and MAME code don't have the same interface and probably protection fails because my interface is wrong. When protection fails the game gets reset when you try to start playing
* Fix sprite bug affecting letter K in the title screen
* Fix graphic glitch affecting one horizontal line on Popeye face    
* Sky Skipper support. This is suppose to be easy to do but I think it requires its own protection module too. This game is a Nintendo rarety.
* Sprite issues
    1. The K of the title is missing, that's a sprite not a character
    2. There is horizontal line missing in Popeye's face

* Interlaced video
    Only sprites are interlaced. It is possible to read the ROM data at high resolution directly without affecting accuracy of the main CPU/GPU interaction. It would be better to produce deinterlaced video in order to show it more cleanly in HDMI screens.


Modules
=======

The FPGA clone uses the following modules:

JT49: For AY-3-8910 sound synthesis. From the same author.
JTFRAME: A common framework for MiST arcades. From the same author.
T80: originally from Daniel Wallner, with edits from Alexey Melnikov (Mister)
hybrid_pwm_sd.v copied from FPGAgen source code. Unknown author

Directory Structure
===================
modules         files shared with other projects and external files
doc             documents related to original PCB
rom             script to convert from MAME rom files to the required format
                simulation files expect the rom files here
hdl             Verilog files of the clone
doc             documents related to the original hardware or the clone
ver             simulation files
syn             synthesis folder

Compile instructions
====================

I use linux as my development system. This means that I use many bash scripts, environment variables and symbolic links. I recommend using linux to compile the cores. 

1. git submodule init
2. git submodule update
3. source setprj.sh
4. MiST:
        jtpopeye
   MiSTer:
        jtpopeye -mr

That will create the output files in the mist(er) folder.

Keyboard (MiST, ZX-UNO)
=======================

On MiSTer keyboard control is configured through the OSD.

For MiST and MiSTer: games can be controlled with both game pads and keyboard. The keyboard follows the same layout as MAME's default.

    F3      Game reset
    P       Pause
    1,2     1P, 2P start buttons
    5,6     Left and right coin inputs

    cursors 1P direction
    CTRL    1P button 1
    ALT     1P button 2
    space   1P button 3

    R,F,G,D 2P direction
    Q,S,A   2P buttons 3,2 and 1


ROM Generation
==============

Copy your .zip files to the rom folder and run the makefile in it. Then copy the .rom file to the SD card with the name jtpopeye.rom. I recommend to use version popeyeu.

SD Card
=======

For MiST(er) copy the file core.rbf to the SD card at the root directory. Copy also the rom you have generated with the name jtpopeye.rom. It will get loaded at start.

Credits
=======

Jose Tejada Gomez. Twitter @topapate
Project is hosted in http://www.github.com/jotego/jtpopeye
License: GPL3, you are obligued to publish your code if you use mine

Special thanks to Scralings and Alexey Melnikov

Patreon supporters for Popeye core
==================================

* Directors *
Scralings   - who asked for this core!
Suvodip Mitra
Frederic Mahe

40wattrange
Alan Steremberg
albconde
Alexander Kholodov
Allen Tipper
Andrew Moore
Andyways
Anthony Bolek
AtariSTFan
Blue1597
Brett McAlpine
Brian Sallee
Bruno Silva
Buster D
Carl Hagstrom
Carlos Del Alamo
Christian Bailey
Christopher Caswell
Christopher rumford
Dacide
Dag J.
Daniel Bauza
Daniel Hochman
Daniel Renner
DarkStar7
Darren Newman
Dave Ross
David Colmenero
Don Gafford
Duane Hembrick
Dustin Hubbard
Ed Balan
Eoin Gibney
Fabio
Fay Dek
Filip Kindt
Frank Wolf
Fredrik Berglind
FULLSET
Funkycochise
furrtek
Geert Oost 
Gonzalo Lopez
Gregory Hogan
Henry R
James DeRose
James Sawford
Jan Beta
Javier Marti­nez
JD
Jeremy Glass
Jerome Moreau
Joe Kalwitz
Johannes Ress
John Klimek
John Silva
John Stringer
Joshua Witt
Juan Diego SÃḂnchez Noguera
Keith Kelly
Kevin Bidwell
Kyle Troutman
Leslie Law
loloC2C
Manuel
Manuel Antoni
Manuel Astudillo
Manuel Fernandez
Manuelfx
Marco Tavian
Mario Salvini
Mary Marshall
Matt Charlesworth
Matt Elder
Matthew Langtry
Michael Stegen
Michael Troelsen
Miguel Angel Rodriguez Jodar
Mike Holzinger
Mr.B
Neil Maguire
Nicolas Hamel
Obiwantje
Oliver Jaksch
Oliver Wndmth
Oscar Jacobsson
Oscar Laguna Garcia
Owlnonymous
Peter Edwards
Phillip McMahon
Popov
Porkchop Express
PsyFX
QcRetro
remowilliams
RetroShop.pt
Rob Young
robert fisher
Roman Buser
Ryan Fig
Rysha
Salvador Perugorria Lorente
SJohansson
SmokeMonster
StalkS
Stefan Nordkvist
Stephen Marshall
Steven Wilson
Thomas Tahsin-Bey
Tony Peters
Travis Brown
type78
UKShark
Ultrarobotninja
Vi­ctor Gomariz Ladron de Guevara
Violeta Martin Fernandez
Visa-Valtteri Pimia
vladimir
William Clemens
Yasri


Thank you all!
