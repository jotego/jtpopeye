JTPOPEYE FPGA Clone of Popeye arcade games by Jose Tejada (@topapate)
=========================================================================

This clone has been made thanks to Scralings' suggestion. He is a director patron and introduced me to this big game. Thanks Scralings!

You can show your appreciation through
    * Patreon: https://patreon.com/topapate
    * Paypal: https://paypal.me/topapate

Yes, you always wanted to have a Popeye arcade board at home. First you couldn't get it because your parents somehow did not understand you. Then you grow up and your wife doesn't understand you either. Don't worry, MiST(er) is here to the rescue.

What you get with this is an extremely accurate (allegedly 100% accurate) clone of the original hardware.

I hope you will have as much fun with it as I had it while making it!

Supported Games
===============

* Popeye
* Sky Skipper

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

Clone Structure
===============

The top level module is called jtpopeye_mist for MiST and jtpopeye_mister for MiSTer. This is the module that is really dependent on the board. If you want to port jtgng to a different FPGA board you will need to modify this file. Most other files will likely stay the same

The game itself in module jtpopeye_game. It is written using an arbitrary clock (active on positive edge) and a clock enable signal (switching on the negative edge). From jtpopeye_game down the hierarchy, everything should be highly portable.

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
