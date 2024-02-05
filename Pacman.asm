;Author: Muhammad Iqrash Qureshi
;Pacman
;COAL Project
.386
.model flat, stdcall
.stack 4096

INCLUDE Irvine32.inc
includelib Winmm.lib

BUFFER_SIZE = 501
.data

GhostSound db 'C:\Users\Iqrash\Pictures\new\ghostkill.wav',0
PacmanIntro db 'C:\Users\Iqrash\Pictures\new\pacman_beginning.wav',0

PlaySound  PROTO, pszSound:PTR BYTE, hmod:DWORD, fdwSound:DWORD

ground BYTE "------------------------------------------------------------------------------------------------------------------------",0
ground3 BYTE "-----------------------------------------------------------------------------",0
ground1 BYTE "|",0ah,0
ground2 BYTE "|",0
ground4 BYTE "-",0

wall BYTE "-----------------------------"
temp byte ?
line1bool DB 0


strScore BYTE "Your score is: ",0
score BYTE ?

xPos BYTE 40
yPos BYTE 19

xCoinPos BYTE ?
yCoinPos BYTE ?

inputChar BYTE ?

inputName BYTE "Enter your name: ",0
outputName BYTE ?

gameName BYTE "PACMAN :) ",0ah,0
pageNumber BYTE ?
menuPage BYTE "HOMEPAGE.",0ah,0ah,0
startGame BYTE "Press s to start the game.",0ah,0
instruction BYTE "Press i to read the instructions.",0ah,0
instructionHeading BYTE "INSTRUCTIONS",0ah,0
forExiting BYTE "Press e to exit the game.",0ah,0
ready BYTE "READY?",0ah,0
instruction1 BYTE "There are 3 levels in this game each with different complexity.",0ah,0
instruction2 BYTE "The player movement is controlled by W, A, S, D.",0ah,0
instruction3 BYTE "Collect coins to increase your score byte 1.",0ah,0
instruction4 BYTE "Beaware of the ghost.",0ah,0
instruction5 BYTE "Press s to start the game.",0ah,0
instruction6 BYTE "Press r to return to menu.",0ah,0
instruction7 BYTE "Fruit increases your score by 5.",0ah,0

pauseDisplay db "Your game is paused. Press r to resume.",0

endGame db "Game END.",0ah,0
scoreShow db "Your score is: ",0

stdLevel db "Level: ",0 
levelcount db 1

buffer BYTE BUFFER_SIZE DUP(?)
file BYTE "output.txt",0
fileHandle HANDLE ?
stringLength dword ?
bytesWritten dword ?
str1 db "Cannot create file",0dh,0ah,0
str2 db "Cannot open file. ",0
output db "Name: ",0
fileName db "output.txt"
notOpen db "Error.",0
cantOpen db "Cannot open file.",0

key db 0

star1X db 7
star1Y db 3

star2X db 7
star2Y db 7

star3X db 7
star3Y db 11

star4X db 7
star4Y db 15

star5X db 7
star5Y db 19

star6X db 7
star6Y db 23

star7X db 7
star7Y db 27

star8X db 26
star8Y db 28

star9X db 43
star9Y db 28

star10X db 60
star10Y db 28

star11X db 81
star11Y db 28

star12X db 98
star12Y db 28

star13X db 26
star13Y db 3

star14X db 43
star14Y db 3

star15X db 60
star15Y db 3

star16X db 81
star16Y db 3

star17X db 98
star17Y db 3

star18X db 114
star18Y db 3

star19X db 114
star19Y db 7

star20X db 114
star20Y db 11

star21X db 114
star21Y db 15

star22X db 114
star22Y db 19

star23X db 114
star23Y db 23

star24X db 114
star24Y db 27

star25X db 30
star25Y db 5

star26X db 30
star26Y db 9

star27X db 30
star27Y db 13

star28X db 30
star28Y db 17

star29X db 30
star29Y db 21

star30X db 30
star30Y db 25

star31X db 94
star31Y db 5

star32X db 94
star32Y db 9

star33X db 94
star33Y db 13

star34X db 94
star34Y db 17

star35X db 94
star35Y db 21

star36X db 94
star36Y db 25

star37X db 40
star37Y db 5

star38X db 40
star38Y db 9

star39X db 40
star39Y db 13

star40X db 40
star40Y db 17

star41X db 40
star41Y db 21

star42X db 40
star42Y db 25

star43X db 84
star43Y db 5

star44X db 84
star44Y db 9

star45X db 84
star45Y db 13

star46X db 84
star46Y db 17

star47X db 84
star47Y db 21

star48X db 84
star48Y db 25

star49X db 45
star49Y db 13

star50X db 60
star50Y db 13

star51X db 78
star51Y db 13

star52X db 45
star52Y db 17

star53X db 60
star53Y db 17

star54X db 78
star54Y db 17

star101X db 5
star101Y db 3

star102X db 5
star102Y db 7

star103X db 5
star103Y db 11

;Fruit
star104X db 5
star104Y db 15

star105X db 5
star105Y db 19

star106X db 5
star106Y db 23

star107X db 5
star107Y db 27

star108X db 114
star108Y db 3

star109X db 114
star109Y db 7

star110X db 114
star110Y db 11

star111X db 114
star111Y db 15

star112X db 114
star112Y db 19

star113X db 114
star113Y db 23

star114X db 114
star114Y db 27

star115X db 15
star115Y db 28

star116X db 30
star116Y db 28

star117X db 45
star117Y db 28

star118X db 60
star118Y db 28

star119X db 75
star119Y db 28

star120X db 90
star120Y db 28

star121X db 105
star121Y db 28

star122X db 22
star122Y db 4

star123X db 22
star123Y db 9

star124X db 22
star124Y db 14

star125X db 22
star125Y db 19

star126X db 14
star126Y db 4

star127X db 14
star127Y db 9

star128X db 14
star128Y db 14

star129X db 14
star129Y db 19

star130X db 14
star130Y db 24

star131X db 30
star131Y db 4

star132X db 30
star132Y db 9

star133X db 30
star133Y db 14

star134X db 106
star134Y db 4

star135X db 106
star135Y db 9

star136X db 106
star136Y db 14

star137X db 106
star137Y db 19

star138X db 106
star138Y db 24

star139X db 98
star139Y db 4

star140X db 98
star140Y db 9

star141X db 98
star141Y db 14

star142X db 98
star142Y db 19

star143X db 90
star143Y db 4

star144X db 90
star144Y db 9

star145X db 90
star145Y db 14

;Level3
star201X db 5
star201Y db 5

star202X db 5
star202Y db 10

star203X db 5
star203Y db 15

star204X db 5
star204Y db 20

star205X db 5
star205Y db 25

star206X db 10
star206Y db 28

star207X db 20
star207Y db 28

star208X db 30
star208Y db 28

star209X db 40
star209Y db 28

star210X db 50
star210Y db 28

star211X db 60
star211Y db 28

star212X db 70
star212Y db 28

star213X db 80
star213Y db 28

star214X db 90
star214Y db 28

star215X db 100
star215Y db 28

star216X db 110
star216Y db 28

star217X db 115
star217Y db 5

star218X db 115
star218Y db 10

star219X db 115
star219Y db 15

star220X db 115
star220Y db 20

star221X db 115
star221Y db 25

star222X db 24
star222Y db 7

star223X db 24
star223Y db 12

star224X db 24
star224Y db 17

star225X db 24
star225Y db 22

star226X db 96
star226Y db 7

star227X db 96
star227Y db 12

star228X db 96
star228Y db 17

star229X db 96
star229Y db 22

star230X db 30
star230Y db 7

star231X db 45
star231Y db 7

star232X db 60
star232Y db 7

star233X db 75
star233Y db 7

star234X db 90
star234Y db 7

star235X db 30
star235Y db 22

star236X db 45
star236Y db 22

star237X db 60
star237Y db 22

star238X db 75
star238Y db 22

star239X db 90
star239Y db 22

star240X db 31
star240Y db 10

star241X db 45
star241Y db 10

star242X db 60
star242Y db 10

star243X db 75
star243Y db 10

star244X db 89
star244Y db 10

star245X db 31
star245Y db 19

star246X db 45
star246Y db 19

star247X db 60
star247Y db 19

star248X db 75
star248Y db 19

star249X db 89
star249Y db 19

stdLives db "Lives: ",0
lives db 3

;Ghost Level1
xPosG1L1 db  20
yPosG1L1 db  4
moveG1L1 db 'd'

xPosG2L1 db  105
yPosG2L1 db  4
moveG2L1 db 'd'

;Ghost Level2
xPosG1L2 db  39
yPosG1L2 db  8
moveG1L2 db 'u'

xPosG2L2 db  80
yPosG2L2 db  8
moveG2L2 db 'd'

xPosG3L2 db  60
yPosG3L2 db  24
moveG3L2 db 'l'

xPosG4L2 db  62
yPosG4L2 db  20
moveG4L2 db 'r'

xPosG5L2 db  60
yPosG5L2 db  16
moveG5L2 db 'r'

xPosG6L2 db  60
yPosG6L2 db  3
moveG6L2 db 'l'

;Ghost Level3
xPosG1L3 db  17
yPosG1L3 db  8
moveG1L3 db 'd'

xPosG2L3 db  12
yPosG2L3 db  20
moveG2L3 db 'u'

xPosG3L3 db  102
yPosG3L3 db  20
moveG3L3 db 'u'

xPosG4L3 db  109
yPosG4L3 db  8
moveG4L3 db 'd'

xPosG5L3 db  60
yPosG5L3 db  5
moveG5L3 db 'l'

xPosG6L3 db  60
yPosG6L3 db  25
moveG6L3 db 'r'

xPosG7L3 db  60
yPosG7L3 db  12
moveG7L3 db 'l'

xPosG8L3 db  60
yPosG8L3 db  16
moveG8L3 db 'r'

.code
jmp main

DrawPlayer PROC
    ; draw player at (xPos,yPos):
    mov eax,yellow ;(blue*16)
    call SetTextColor
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al,"X"
    call WriteChar
    ret
DrawPlayer ENDP

DrawPlayer2 PROC
    ; draw player at (xPos,yPos):
    mov eax,yellow ;(blue*16)
    call SetTextColor
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al,"X"
    call WriteChar
    ret
DrawPlayer2 ENDP

UpdatePlayer PROC
    mov dl,xPos
    mov dh,yPos
    call Gotoxy
    mov al," "
    call WriteChar
    ret
UpdatePlayer ENDP

DrawCoin PROC
    mov eax,yellow ;(red * 16)
    call SetTextColor
    mov dl,xCoinPos
    mov dh,yCoinPos
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawCoin ENDP

DrawStar1 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star1X
    mov dh,star1Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar1 ENDP

DrawStar2 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star2X
    mov dh,star2Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar2 ENDP

DrawStar3 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star3X
    mov dh,star3Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar3 ENDP

DrawStar4 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star4X
    mov dh,star4Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar4 ENDP

DrawStar5 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star5X
    mov dh,star5Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar5 ENDP

DrawStar6 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star6X
    mov dh,star6Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar6 ENDP

DrawStar7 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star7X
    mov dh,star7Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar7 ENDP

DrawStar8 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star8X
    mov dh,star8Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar8 ENDP

DrawStar9 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star9X
    mov dh,star9Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar9 ENDP

DrawStar10 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star10X
    mov dh,star10Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar10 ENDP

DrawStar11 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star11X
    mov dh,star11Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar11 ENDP

DrawStar12 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star12X
    mov dh,star12Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar12 ENDP

DrawStar13 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star13X
    mov dh,star13Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar13 ENDP

DrawStar14 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star14X
    mov dh,star14Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar14 ENDP

DrawStar15 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star15X
    mov dh,star15Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar15 ENDP

DrawStar16 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star16X
    mov dh,star16Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar16 ENDP

DrawStar17 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star17X
    mov dh,star17Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar17 ENDP

DrawStar18 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star18X
    mov dh,star18Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar18 ENDP

DrawStar19 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star19X
    mov dh,star19Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar19 ENDP

DrawStar20 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star20X
    mov dh,star20Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar20 ENDP

DrawStar21 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star21X
    mov dh,star21Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar21 ENDP

DrawStar22 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star22X
    mov dh,star22Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar22 ENDP

DrawStar23 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star23X
    mov dh,star23Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar23 ENDP

DrawStar24 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star24X
    mov dh,star24Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar24 ENDP

DrawStar25 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star25X
    mov dh,star25Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar25 ENDP

DrawStar26 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star26X
    mov dh,star26Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar26 ENDP

DrawStar27 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star27X
    mov dh,star27Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar27 ENDP

DrawStar28 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star28X
    mov dh,star28Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar28 ENDP

DrawStar29 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star29X
    mov dh,star29Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar29 ENDP

DrawStar30 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star30X
    mov dh,star30Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar30 ENDP

DrawStar31 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star31X
    mov dh,star31Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar31 ENDP

DrawStar32 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star32X
    mov dh,star32Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar32 ENDP

DrawStar33 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star33X
    mov dh,star33Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar33 ENDP

DrawStar34 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star34X
    mov dh,star34Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar34 ENDP

DrawStar35 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star35X
    mov dh,star35Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar35 ENDP

DrawStar36 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star36X
    mov dh,star36Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar36 ENDP

DrawStar37 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star37X
    mov dh,star37Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar37 ENDP

DrawStar38 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star38X
    mov dh,star38Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar38 ENDP

DrawStar39 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star39X
    mov dh,star39Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar39 ENDP

DrawStar40 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star40X
    mov dh,star40Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar40 ENDP

DrawStar41 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star41X
    mov dh,star41Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar41 ENDP

DrawStar42 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star42X
    mov dh,star42Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar42 ENDP

DrawStar43 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star43X
    mov dh,star43Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar43 ENDP

DrawStar44 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star44X
    mov dh,star44Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar44 ENDP

DrawStar45 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star45X
    mov dh,star45Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar45 ENDP

DrawStar46 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star46X
    mov dh,star46Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar46 ENDP

DrawStar47 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star47X
    mov dh,star47Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar47 ENDP

DrawStar48 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star48X
    mov dh,star48Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar48 ENDP

DrawStar49 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star49X
    mov dh,star49Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar49 ENDP

DrawStar50 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star50X
    mov dh,star50Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar50 ENDP

DrawStar51 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star51X
    mov dh,star51Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar51 ENDP

DrawStar52 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star52X
    mov dh,star52Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar52 ENDP

DrawStar53 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star53X
    mov dh,star53Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar53 ENDP

DrawStar54 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star54X
    mov dh,star54Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar54 ENDP

DrawStar101 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star101X
    mov dh,star101Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar101 ENDP

DrawStar102 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star102X
    mov dh,star102Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar102 ENDP

DrawStar103 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star103X
    mov dh,star103Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar103 ENDP

DrawStar104 PROC
    mov eax, magenta
    call SetTextColor
    mov dl,star104X
    mov dh,star104Y
    call Gotoxy
    mov al,"O"
    call WriteChar
    ret
DrawStar104 ENDP

DrawStar105 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star105X
    mov dh,star105Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar105 ENDP

DrawStar106 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star106X
    mov dh,star106Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar106 ENDP

DrawStar107 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star107X
    mov dh,star107Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar107 ENDP

DrawStar108 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star108X
    mov dh,star108Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar108 ENDP

DrawStar109 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star109X
    mov dh,star109Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar109 ENDP

DrawStar110 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star110X
    mov dh,star110Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar110 ENDP

DrawStar111 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star111X
    mov dh,star111Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar111 ENDP

DrawStar112 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star112X
    mov dh,star112Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar112 ENDP

DrawStar113 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star113X
    mov dh,star113Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar113 ENDP

DrawStar114 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star114X
    mov dh,star114Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar114 ENDP

DrawStar115 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star115X
    mov dh,star115Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar115 ENDP

DrawStar116 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star116X
    mov dh,star116Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar116 ENDP

DrawStar117 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star117X
    mov dh,star117Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar117 ENDP

DrawStar118 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star118X
    mov dh,star118Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar118 ENDP

DrawStar119 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star119X
    mov dh,star119Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar119 ENDP

DrawStar120 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star120X
    mov dh,star120Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar120 ENDP

DrawStar121 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star121X
    mov dh,star121Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar121 ENDP

DrawStar122 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star122X
    mov dh,star122Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar122 ENDP

DrawStar123 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star123X
    mov dh,star123Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar123 ENDP

DrawStar124 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star124X
    mov dh,star124Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar124 ENDP

DrawStar125 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star125X
    mov dh,star125Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar125 ENDP

DrawStar126 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star126X
    mov dh,star126Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar126 ENDP

DrawStar127 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star127X
    mov dh,star127Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar127 ENDP

DrawStar128 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star128X
    mov dh,star128Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar128 ENDP

DrawStar129 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star129X
    mov dh,star129Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar129 ENDP

DrawStar130 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star130X
    mov dh,star130Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar130 ENDP

DrawStar131 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star131X
    mov dh,star131Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar131 ENDP

DrawStar132 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star132X
    mov dh,star132Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar132 ENDP

DrawStar133 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star133X
    mov dh,star133Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar133 ENDP

DrawStar134 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star134X
    mov dh,star134Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar134 ENDP

DrawStar135 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star135X
    mov dh,star135Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar135 ENDP

DrawStar136 PROC
    mov eax, magenta
    call SetTextColor
    mov dl,star136X
    mov dh,star136Y
    call Gotoxy
    mov al,"O"
    call WriteChar
    ret
DrawStar136 ENDP

DrawStar137 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star137X
    mov dh,star137Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar137 ENDP

DrawStar138 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star138X
    mov dh,star138Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar138 ENDP

DrawStar139 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star139X
    mov dh,star139Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar139 ENDP

DrawStar140 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star140X
    mov dh,star140Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar140 ENDP

DrawStar141 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star141X
    mov dh,star141Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar141 ENDP

DrawStar142 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star142X
    mov dh,star142Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar142 ENDP

DrawStar143 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star143X
    mov dh,star143Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar143 ENDP

DrawStar144 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star144X
    mov dh,star144Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar144 ENDP

DrawStar145 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star145X
    mov dh,star145Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar145 ENDP

DrawStar201 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star201X
    mov dh,star201Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar201 ENDP

DrawStar202 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star202X
    mov dh,star202Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar202 ENDP

DrawStar203 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star203X
    mov dh,star203Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar203 ENDP

DrawStar204 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star204X
    mov dh,star204Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar204 ENDP

DrawStar205 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star205X
    mov dh,star205Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar205 ENDP

DrawStar206 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star206X
    mov dh,star206Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar206 ENDP

DrawStar207 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star207X
    mov dh,star207Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar207 ENDP

DrawStar208 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star208X
    mov dh,star208Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar208 ENDP

DrawStar209 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star209X
    mov dh,star209Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar209 ENDP

DrawStar210 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star210X
    mov dh,star210Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar210 ENDP

DrawStar211 PROC
    mov eax, magenta
    call SetTextColor
    mov dl,star211X
    mov dh,star211Y
    call Gotoxy
    mov al,"O"
    call WriteChar
    ret
DrawStar211 ENDP

DrawStar212 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star212X
    mov dh,star212Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar212 ENDP

DrawStar213 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star213X
    mov dh,star213Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar213 ENDP

DrawStar214 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star214X
    mov dh,star214Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar214 ENDP

DrawStar215 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star215X
    mov dh,star215Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar215 ENDP

DrawStar216 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star216X
    mov dh,star216Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar216 ENDP

DrawStar217 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star217X
    mov dh,star217Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar217 ENDP

DrawStar218 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star218X
    mov dh,star218Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar218 ENDP

DrawStar219 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star219X
    mov dh,star219Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar219 ENDP

DrawStar220 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star220X
    mov dh,star220Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar220 ENDP

DrawStar221 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star221X
    mov dh,star221Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar221 ENDP

DrawStar222 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star222X
    mov dh,star222Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar222 ENDP

DrawStar223 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star223X
    mov dh,star223Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar223 ENDP

DrawStar224 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star224X
    mov dh,star224Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar224 ENDP

DrawStar225 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star225X
    mov dh,star225Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar225 ENDP

DrawStar226 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star226X
    mov dh,star226Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar226 ENDP

DrawStar227 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star227X
    mov dh,star227Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar227 ENDP

DrawStar228 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star228X
    mov dh,star228Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar228 ENDP

DrawStar229 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star229X
    mov dh,star229Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar229 ENDP

DrawStar230 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star230X
    mov dh,star230Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar230 ENDP

DrawStar231 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star231X
    mov dh,star231Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar231 ENDP

DrawStar232 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star232X
    mov dh,star232Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar232 ENDP

DrawStar233 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star233X
    mov dh,star233Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar233 ENDP

DrawStar234 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star234X
    mov dh,star234Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar234 ENDP

DrawStar235 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star235X
    mov dh,star235Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar235 ENDP

DrawStar236 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star236X
    mov dh,star236Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar236 ENDP

DrawStar237 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star237X
    mov dh,star237Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar237 ENDP

DrawStar238 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star238X
    mov dh,star238Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar238 ENDP

DrawStar239 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star239X
    mov dh,star239Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar239 ENDP

DrawStar240 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star240X
    mov dh,star240Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar240 ENDP

DrawStar241 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star241X
    mov dh,star241Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar241 ENDP

DrawStar242 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star242X
    mov dh,star242Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar242 ENDP

DrawStar243 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star243X
    mov dh,star243Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar243 ENDP

DrawStar244 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star244X
    mov dh,star244Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar244 ENDP

DrawStar245 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star245X
    mov dh,star245Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar245 ENDP

DrawStar246 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star246X
    mov dh,star246Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar246 ENDP

DrawStar247 PROC
    mov eax, magenta
    call SetTextColor
    mov dl,star247X
    mov dh,star247Y
    call Gotoxy
    mov al,"O"
    call WriteChar
    ret
DrawStar247 ENDP

DrawStar248 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star248X
    mov dh,star248Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar248 ENDP

DrawStar249 PROC
    mov eax, lightgray
    call SetTextColor
    mov dl,star249X
    mov dh,star249Y
    call Gotoxy
    mov al,"*"
    call WriteChar
    ret
DrawStar249 ENDP

;Right side smallest line. Collison done.
line1 PROC
        cmp bl,90
        jne done
        cmp bh,20
        jg done
        cmp bh,10
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line1 ENDP
;Left side smallest line. Collison done.
line2 PROC
        cmp bl,35
        jne done
        cmp bh,20
        jg done
        cmp bh,10
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line2 ENDP
;Right side biggest line. Collison done.
line3 PROC
        cmp bl,110
        jne done
        cmp bh,24
        jg done
        cmp bh,5
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line3 ENDP
;Left side biggest line. Collison done.
line4 PROC
        cmp bl,15
        jne done
        cmp bh,24
        jg done
        cmp bh,5
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line4 ENDP
;Left side middle line. Collison done.
line5 PROC
        cmp bl,25
        jne done
       cmp bh,22
        jg done
        cmp bh,8
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line5 ENDP
;Right side middle line. Collison done.
line6 PROC
        cmp bl,100
        jne done
        cmp bh,22
        jg done
        cmp bh,8
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line6 ENDP
;Lower vertical line. Collison done.
line7 PROC
        cmp bl,60
        jne done
        cmp bh,23
        jg done
        cmp bh,22
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line7 ENDP
;Upper vertical line. Collison done.
line8 PROC
        cmp bl,60
        jne done
        cmp bh,8
        jg done
        cmp bh,7
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line8 ENDP
;Middle of 3 small horizontal line. Collison done.
line9 PROC
        cmp bh,15
        jne done
        cmp bl,79
        jg done
        cmp bl,45
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line9 ENDP
;Upper of 3 small horizontal lines. Collison done.
line10 PROC
        cmp bh,11
        jne done
        cmp bl,79
        jg done
        cmp bl,45
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line10 ENDP
;Lower of 3 small horizontal lines. Collison done.
line11 PROC
        cmp bh,19
        jne done
        cmp bl,79
        jg done
        cmp bl,45
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line11 ENDP
;Top most horizontal line. Collison done.
line12 PROC
        cmp bh,4
        jne done
        cmp bl,100
        jg done
        cmp bl,25
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line12 ENDP
;Bottom most horizontal line. Collison done.
line13 PROC
        cmp bh,26
        jne done
        cmp bl,100
        jg done
        cmp bl,25
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line13 ENDP


;LEVEL 2
;Vertical lines.
line21 PROC
        cmp bl,110
        jne done
        cmp bh,25
        jg done
        cmp bh,4
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line21 ENDP

line22 PROC
        cmp bl,10
        jne done
        cmp bh,25
        jg done
        cmp bh,4
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line22 ENDP

line24 PROC
        cmp bl,18
        jne done
        cmp bh,21
        jg done
        cmp bh,4
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line24 ENDP

line25 PROC
        cmp bl,102
        jne done
        cmp bh,21
        jg done
        cmp bh,4
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line25 ENDP

line27 PROC
        cmp bl,94
        jne done
        cmp bh,17
        jg done
        cmp bh,4
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line27 ENDP

line28 PROC
        cmp bl,26
        jne done
        cmp bh,17
        jg done
        cmp bh,4
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line28 ENDP

line30 PROC
        cmp bl,34
        jne done
        cmp bh,13
        jg done
        cmp bh,4
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line30 ENDP

line31 PROC
        cmp bl,86
        jne done
        cmp bh,13
        jg done
        cmp bh,4
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line31 ENDP

;Horizontal lines
line23 PROC
        cmp bh,26
        jne done
        cmp bl,105
        jg done
        cmp bl,15
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line23 ENDP

line26 PROC
        cmp bh,22
        jne done
        cmp bl,97
        jg done
        cmp bl,23
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line26 ENDP

line29 PROC
        cmp bh,18
        jne done
        cmp bl,89
        jg done
        cmp bl,31
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line29 ENDP

line32 PROC
        cmp bh,14
        jne done
        cmp bl,81
        jg done
        cmp bl,39
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line32 ENDP

line33 PROC
        cmp bh,4
        jne done
        cmp bl,81
        jg done
        cmp bl,39
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line33 ENDP

;LEVEL3
;Vertical line
line60 PROC
        cmp bl,110
        jne done
        cmp bh,26
        jg done
        cmp bh,3
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line60 ENDP

line61 PROC
        cmp bl,10
        jne done
        cmp bh,26
        jg done
        cmp bh,3
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line61 ENDP

line64 PROC
        cmp bl,101
        jne done
        cmp bh,23
        jg done
        cmp bh,6
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line64 ENDP

line65 PROC
        cmp bl,19
        jne done
        cmp bh,23
        jg done
        cmp bh,6
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line65 ENDP

line68 PROC
        cmp bl,91
        jne done
        cmp bh,20
        jg done
        cmp bh,9
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line68 ENDP

line69 PROC
        cmp bl,29
        jne done
        cmp bh,20
        jg done
        cmp bh,9
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line69 ENDP

;Horizontal lines
line62 PROC
        cmp bh,26
        jne done
        cmp bl,108
        jg done
        cmp bl,11
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line62 ENDP

line63 PROC
        cmp bh,3
        jne done
        cmp bl,106
        jg done
        cmp bl,11
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line63 ENDP

line66 PROC
        cmp bh,6
        jne done
        cmp bl,100
        jg done
        cmp bl,20
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line66 ENDP

line67 PROC
        cmp bh,23
        jne done
        cmp bl,96
        jg done
        cmp bl,20
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line67 ENDP

line70 PROC
        cmp bh,20
        jne done
        cmp bl,91
        jg done
        cmp bl,30
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line70 ENDP

line71 PROC
        cmp bh,9
        jne done
        cmp bl,86
        jg done
        cmp bl,30
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line71 ENDP

line72 PROC
        cmp bh,14
        jne done
        cmp bl,90
        jg done
        cmp bl,35
        jge done3
        jmp done
    done3:
         mov line1bool,1
    done:
    ret
line72 ENDP

TeleportHorizontal1 PROC

cmp yPos,2
jne done

cmp xPos,1
jne done

cmp inputChar,'a'
jne done

call UpdatePlayer
mov yPos,28
mov xPos,118
call UpdatePlayer

done:
    ret
TeleportHorizontal1 ENDP

TeleportHorizontal2 PROC

cmp yPos,2
jne done

cmp xPos,118
jne done

cmp inputChar,'d'
jne done

call UpdatePlayer
mov yPos,28
mov xPos,1
call UpdatePlayer

done:
    ret
TeleportHorizontal2 ENDP

TeleportHorizontal3 PROC

cmp yPos,28
jne done

cmp xPos,118
jne done

cmp inputChar,'d'
jne done

call UpdatePlayer
mov yPos,2
mov xPos,1
call UpdatePlayer

done:
    ret
TeleportHorizontal3 ENDP

TeleportHorizontal4 PROC

cmp yPos,28
jne done

cmp xPos,1
jne done

cmp inputChar,'a'
jne done

call UpdatePlayer
mov yPos,2
mov xPos,118
call UpdatePlayer

done:
    ret
TeleportHorizontal4 ENDP

;Ghosts

DrawG1L1 PROC
    mov eax,lightgray 
    call SetTextColor
    mov dl,xPosG1L1
    mov dh,yPosG1L1 
    call Gotoxy
    mov al,"$"
    call WriteChar
    ret
DrawG1L1 ENDP

Ghost1Lev1  PROC
    mov dl,xPosG1L1 
    mov dh,yPosG1L1
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, moveG1L1 
    cmp al, 'd'
    je downG1
    
    dec yPosG1L1 
    jmp endG1    
downG1:
    inc yPosG1L1   
endG1:
    cmp yPosG1L1 , 28
    je positionup
    cmp yPosG1L1 , 2
    je positiondown
    jmp done
positionup:
    mov moveG1L1 , 'u'
    jmp done    
positiondown:
    mov moveG1L1 , 'd'   
done:
    ret
Ghost1Lev1 ENDP

G1L1Collision PROC
    cmp bh, yPosG1L1 
    jne done
    cmp bl, xPosG1L1 
    jne done
    dec lives
    mov al, 1
    done:
      ret
G1L1Collision ENDP

DrawG2L1 PROC
    mov eax,lightgray 
    call SetTextColor
    mov dl,xPosG2L1
    mov dh,yPosG2L1 
    call Gotoxy
    mov al,"$"
    call WriteChar
    ret
DrawG2L1 ENDP

Ghost2Lev1  PROC
    mov dl,xPosG2L1 
    mov dh,yPosG2L1
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, moveG2L1 
    cmp al, 'd'
    je downG1
    
    dec yPosG2L1 
    jmp endG1    
downG1:
    inc yPosG2L1   
endG1:
    cmp yPosG2L1 , 28
    je positionup
    cmp yPosG2L1 , 2
    je positiondown
    jmp done
positionup:
    mov moveG2L1 , 'u'
    jmp done    
positiondown:
    mov moveG2L1 , 'd'   
done:
    ret
Ghost2Lev1 ENDP

G2L1Collision PROC
    cmp bh, yPosG2L1 
    jne done
    cmp bl, xPosG2L1 
    jne done
    dec lives
    mov al, 1
    done:
      ret
G2L1Collision ENDP

DrawG1L2 PROC
    mov eax,lightgray 
    call SetTextColor
    mov dl,xPosG1L2
    mov dh,yPosG1L2 
    call Gotoxy
    mov al,"$"
    call WriteChar
    ret
DrawG1L2 ENDP

Ghost1Lev2  PROC
    mov dl,xPosG1L2 
    mov dh,yPosG1L2
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, moveG1L2 
    cmp al, 'd'
    je downG1
    
    dec yPosG1L2 
    jmp endG1    
downG1:
    inc yPosG1L2   
endG1:
    cmp yPosG1L2 , 13
    je positionup
    cmp yPosG1L2 , 5
    je positiondown
    jmp done
positionup:
    mov moveG1L2 , 'u'
    jmp done    
positiondown:
    mov moveG1L2 , 'd'   
done:
    ret
Ghost1Lev2 ENDP

G1L2Collision PROC
    cmp bh, yPosG1L2 
    jne done
    cmp bl, xPosG1L2 
    jne done
    dec lives
    mov al, 1
    done:
      ret
G1L2Collision ENDP

DrawG2L2 PROC
    mov eax,lightgray 
    call SetTextColor
    mov dl,xPosG2L2
    mov dh,yPosG2L2 
    call Gotoxy
    mov al,"$"
    call WriteChar
    ret
DrawG2L2 ENDP

Ghost2Lev2  PROC
    mov dl,xPosG2L2 
    mov dh,yPosG2L2
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, moveG2L2 
    cmp al, 'd'
    je downG1
    
    dec yPosG2L2 
    jmp endG1    
downG1:
    inc yPosG2L2   
endG1:
    cmp yPosG2L2 , 13
    je positionup
    cmp yPosG2L2 , 5
    je positiondown
    jmp done
positionup:
    mov moveG2L2 , 'u'
    jmp done    
positiondown:
    mov moveG2L2 , 'd'   
done:
    ret
Ghost2Lev2 ENDP

G2L2Collision PROC
    cmp bh, yPosG2L2 
    jne done
    cmp bl, xPosG2L2 
    jne done
    dec lives
    mov al, 1
    done:
      ret
G2L2Collision ENDP

DrawG3L2 PROC
    mov eax,lightgray 
    call SetTextColor
    mov dl,xPosG3L2
    mov dh,yPosG3L2 
    call Gotoxy
    mov al,"$"
    call WriteChar
    ret
DrawG3L2 ENDP

Ghost3Lev2  PROC
    mov dl,xPosG3L2 
    mov dh,yPosG3L2
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, moveG3L2 
    cmp al, 'l'
    je left
    
    dec xPosG3L2 
    jmp endG1    
left:
    inc xPosG3L2   
endG1:
    cmp xPosG3L2 , 17
    je positionleft
    cmp xPosG3L2 , 103
    je positionright
    jmp done
positionleft:
    mov moveG3L2 , 'l'
    jmp done    
positionright:
    mov moveG3L2 , 'r'   
done:
    ret
Ghost3Lev2 ENDP

G3L2Collision PROC
    cmp bh, yPosG2L2 
    jne done
    cmp bl, xPosG2L2 
    jne done
    dec lives
    mov al, 1
    done:
      ret
G3L2Collision ENDP

DrawG4L2 PROC
    mov eax,lightgray 
    call SetTextColor
    mov dl,xPosG4L2
    mov dh,yPosG4L2 
    call Gotoxy
    mov al,"$"
    call WriteChar
    ret
DrawG4L2 ENDP

Ghost4Lev2  PROC
    mov dl,xPosG4L2 
    mov dh,yPosG4L2
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, moveG4L2 
    cmp al, 'l'
    je left
    
    dec xPosG4L2 
    jmp endG1    
left:
    inc xPosG4L2   
endG1:
    cmp xPosG4L2 , 24
    je positionleft
    cmp xPosG4L2 , 95
    je positionright
    jmp done
positionleft:
    mov moveG4L2 , 'l'
    jmp done    
positionright:
    mov moveG4L2 , 'r'   
done:
    ret
Ghost4Lev2 ENDP

G4L2Collision PROC
    cmp bh, yPosG4L2 
    jne done
    cmp bl, xPosG4L2 
    jne done
    dec lives
    mov al, 1
    done:
      ret
G4L2Collision ENDP

DrawG5L2 PROC
    mov eax,lightgray 
    call SetTextColor
    mov dl,xPosG5L2
    mov dh,yPosG5L2 
    call Gotoxy
    mov al,"$"
    call WriteChar
    ret
DrawG5L2 ENDP

Ghost5Lev2  PROC
    mov dl,xPosG5L2 
    mov dh,yPosG5L2
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, moveG5L2 
    cmp al, 'l'
    je left
    
    dec xPosG5L2 
    jmp endG1    
left:
    inc xPosG5L2   
endG1:
    cmp xPosG5L2 , 33
    je positionleft
    cmp xPosG5L2 , 85
    je positionright
    jmp done
positionleft:
    mov moveG5L2 , 'l'
    jmp done    
positionright:
    mov moveG5L2 , 'r'   
done:
    ret
Ghost5Lev2 ENDP

G5L2Collision PROC
    cmp bh, yPosG5L2 
    jne done
    cmp bl, xPosG5L2 
    jne done
    dec lives
    mov al, 1
    done:
      ret
G5L2Collision ENDP

DrawG6L2 PROC
    mov eax,lightgray 
    call SetTextColor
    mov dl,xPosG6L2
    mov dh,yPosG6L2 
    call Gotoxy
    mov al,"$"
    call WriteChar
    ret
DrawG6L2 ENDP

Ghost6Lev2  PROC
    mov dl,xPosG6L2 
    mov dh,yPosG6L2
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, moveG6L2 
    cmp al, 'l'
    je left
    
    dec xPosG6L2 
    jmp endG1    
left:
    inc xPosG6L2   
endG1:
    cmp xPosG6L2 , 8
    je positionleft
    cmp xPosG6L2 , 110
    je positionright
    jmp done
positionleft:
    mov moveG6L2 , 'l'
    jmp done    
positionright:
    mov moveG6L2 , 'r'   
done:
    ret
Ghost6Lev2 ENDP

G6L2Collision PROC
    cmp bh, yPosG6L2 
    jne done
    cmp bl, xPosG6L2 
    jne done
    dec lives
    mov al, 1
    done:
      ret
G6L2Collision ENDP
;Ghost Level3
DrawG1L3 PROC
    mov eax,lightgray 
    call SetTextColor
    mov dl,xPosG1L3
    mov dh,yPosG1L3 
    call Gotoxy
    mov al,"$"
    call WriteChar
    ret
DrawG1L3 ENDP

Ghost1Lev3  PROC
    mov dl,xPosG1L3 
    mov dh,yPosG1L3
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, moveG1L3 
    cmp al, 'd'
    je downG1
    
    dec yPosG1L3 
    jmp endG1    
downG1:
    inc yPosG1L3   
endG1:
    cmp yPosG1L3 , 25
    je positionup
    cmp yPosG1L3 , 5
    je positiondown
    jmp done
positionup:
    mov moveG1L3 , 'u'
    jmp done    
positiondown:
    mov moveG1L3 , 'd'   
done:
    ret
Ghost1Lev3 ENDP

G1L3Collision PROC
    cmp bh, yPosG1L3 
    jne done
    cmp bl, xPosG1L3 
    jne done
    dec lives
    mov al, 1
    done:
      ret
G1L3Collision ENDP

DrawG2L3 PROC
    mov eax,lightgray 
    call SetTextColor
    mov dl,xPosG2L3
    mov dh,yPosG2L3 
    call Gotoxy
    mov al,"$"
    call WriteChar
    ret
DrawG2L3 ENDP

Ghost2Lev3  PROC
    mov dl,xPosG2L3 
    mov dh,yPosG2L3
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, moveG2L3 
    cmp al, 'd'
    je downG1
    
    dec yPosG2L3 
    jmp endG1    
downG1:
    inc yPosG2L3   
endG1:
    cmp yPosG2L3 , 25
    je positionup
    cmp yPosG2L3 , 4
    je positiondown
    jmp done
positionup:
    mov moveG2L3 , 'u'
    jmp done    
positiondown:
    mov moveG2L3 , 'd'   
done:
    ret
Ghost2Lev3 ENDP

G2L3Collision PROC
    cmp bh, yPosG2L3 
    jne done
    cmp bl, xPosG2L3 
    jne done
    dec lives
    mov al, 1
    done:
      ret
G2L3Collision ENDP

DrawG3L3 PROC
    mov eax,lightgray 
    call SetTextColor
    mov dl,xPosG3L3
    mov dh,yPosG3L3 
    call Gotoxy
    mov al,"$"
    call WriteChar
    ret
DrawG3L3 ENDP

Ghost3Lev3  PROC
    mov dl,xPosG3L3 
    mov dh,yPosG3L3
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, moveG3L3 
    cmp al, 'd'
    je downG1
    
    dec yPosG3L3 
    jmp endG1    
downG1:
    inc yPosG3L3   
endG1:
    cmp yPosG3L3 , 25
    je positionup
    cmp yPosG3L3 , 5
    je positiondown
    jmp done
positionup:
    mov moveG3L3 , 'u'
    jmp done    
positiondown:
    mov moveG3L3 , 'd'   
done:
    ret
Ghost3Lev3 ENDP

G3L3Collision PROC
    cmp bh, yPosG3L3 
    jne done
    cmp bl, xPosG3L3 
    jne done
    dec lives
    mov al, 1
    done:
      ret
G3L3Collision ENDP

DrawG4L3 PROC
    mov eax,lightgray 
    call SetTextColor
    mov dl,xPosG4L3
    mov dh,yPosG4L3 
    call Gotoxy
    mov al,"$"
    call WriteChar
    ret
DrawG4L3 ENDP

Ghost4Lev3  PROC
    mov dl,xPosG4L3 
    mov dh,yPosG4L3
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, moveG4L3 
    cmp al, 'd'
    je downG1
    
    dec yPosG4L3 
    jmp endG1    
downG1:
    inc yPosG4L3   
endG1:
    cmp yPosG4L3 , 25
    je positionup
    cmp yPosG4L3 , 5
    je positiondown
    jmp done
positionup:
    mov moveG4L3 , 'u'
    jmp done    
positiondown:
    mov moveG4L3 , 'd'   
done:
    ret
Ghost4Lev3 ENDP

G4L3Collision PROC
    cmp bh, yPosG4L3 
    jne done
    cmp bl, xPosG4L3 
    jne done
    dec lives
    mov al, 1
    done:
      ret
G4L3Collision ENDP

DrawG5L3 PROC
    mov eax,lightgray 
    call SetTextColor
    mov dl,xPosG5L3
    mov dh,yPosG5L3 
    call Gotoxy
    mov al,"$"
    call WriteChar
    ret
DrawG5L3 ENDP

Ghost5Lev3  PROC
    mov dl,xPosG5L3 
    mov dh,yPosG5L3
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, moveG5L3 
    cmp al, 'l'
    je left
    
    dec xPosG5L3 
    jmp endG1    
left:
    inc xPosG5L3   
endG1:
    cmp xPosG5L3 , 19
    je positionleft
    cmp xPosG5L3 , 101
    je positionright
    jmp done
positionleft:
    mov moveG5L3 , 'l'
    jmp done    
positionright:
    mov moveG5L3 , 'r'   
done:
    ret
Ghost5Lev3 ENDP

G5L3Collision PROC
    cmp bh, yPosG5L3 
    jne done
    cmp bl, xPosG5L3 
    jne done
    dec lives
    mov al, 1
    done:
      ret
G5L3Collision ENDP

DrawG6L3 PROC
    mov eax,lightgray 
    call SetTextColor
    mov dl,xPosG6L3
    mov dh,yPosG6L3 
    call Gotoxy
    mov al,"$"
    call WriteChar
    ret
DrawG6L3 ENDP

Ghost6Lev3  PROC
    mov dl,xPosG6L3 
    mov dh,yPosG6L3
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, moveG6L3 
    cmp al, 'l'
    je left
    
    dec xPosG6L3 
    jmp endG1    
left:
    inc xPosG6L3   
endG1:
    cmp xPosG6L3 , 19
    je positionleft
    cmp xPosG6L3 , 101
    je positionright
    jmp done
positionleft:
    mov moveG6L3 , 'l'
    jmp done    
positionright:
    mov moveG6L3 , 'r'   
done:
    ret
Ghost6Lev3 ENDP

G6L3Collision PROC
    cmp bh, yPosG6L3 
    jne done
    cmp bl, xPosG6L3 
    jne done
    dec lives
    mov al, 1
    done:
      ret
G6L3Collision ENDP

DrawG7L3 PROC
    mov eax,lightgray 
    call SetTextColor
    mov dl,xPosG7L3
    mov dh,yPosG7L3 
    call Gotoxy
    mov al,"$"
    call WriteChar
    ret
DrawG7L3 ENDP

Ghost7Lev3  PROC
    mov dl,xPosG7L3 
    mov dh,yPosG7L3
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, moveG7L3 
    cmp al, 'l'
    je left
    
    dec xPosG7L3 
    jmp endG1    
left:
    inc xPosG7L3   
endG1:
    cmp xPosG7L3 , 30
    je positionleft
    cmp xPosG7L3 , 90
    je positionright
    jmp done
positionleft:
    mov moveG7L3 , 'l'
    jmp done    
positionright:
    mov moveG7L3 , 'r'   
done:
    ret
Ghost7Lev3 ENDP

G7L3Collision PROC
    cmp bh, yPosG7L3 
    jne done
    cmp bl, xPosG7L3 
    jne done
    dec lives
    mov al, 1
    done:
      ret
G7L3Collision ENDP

DrawG8L3 PROC
    mov eax,lightgray 
    call SetTextColor
    mov dl,xPosG8L3
    mov dh,yPosG8L3 
    call Gotoxy
    mov al,"$"
    call WriteChar
    ret
DrawG8L3 ENDP

Ghost8Lev3  PROC
    mov dl,xPosG8L3 
    mov dh,yPosG8L3
    call Gotoxy
    mov al," "
    call WriteChar
    
    mov al, moveG8L3 
    cmp al, 'l'
    je left
    
    dec xPosG8L3 
    jmp endG1    
left:
    inc xPosG8L3   
endG1:
    cmp xPosG8L3 , 30
    je positionleft
    cmp xPosG8L3 , 90
    je positionright
    jmp done
positionleft:
    mov moveG8L3 , 'l'
    jmp done    
positionright:
    mov moveG8L3 , 'r'   
done:
    ret
Ghost8Lev3 ENDP

G8L3Collision PROC
    cmp bh, yPosG8L3 
    jne done
    cmp bl, xPosG8L3 
    jne done
    dec lives
    mov al, 1
    done:
      ret
G8L3Collision ENDP

main PROC

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;MENU;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    INVOKE PlaySound, OFFSET PacmanIntro, NULL, 11h
     mov eax,900
     call delay
    ; INVOKE PlaySound, OFFSET GhostSound, NULL, 0h
    ; mov eax,900
    ; call delay

    mov eax,yellow (brown*16)
    call SetTextColor
    call clrscr

    mov dl,0
    mov dh,0
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,3
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,6
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,9
    call Gotoxy
    mov edx,OFFSET ground
    call writestring
    
    mov dl,0
    mov dh,17
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,20
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,23
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,26
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,56
    mov dh,12
    call Gotoxy
    mov edx,OFFSET gameName
    call writestring

;Writing in File.
    mov edx, OFFSET filename
    call CreateOutputFile
    mov fileHandle, eax
    cmp eax, INVALID_HANDLE_VALUE
    jne writing
    mov edx, OFFSET inputName
    call WriteString
    jmp menu
writing:
    mov dl,52
    mov dh,13
    call Gotoxy  
    mov edx, OFFSET inputName
    call WriteString
    mov ecx, BUFFER_SIZE
    mov edx, OFFSET buffer
    call ReadString
    mov eax, fileHandle
    mov edx, OFFSET buffer
    mov ecx, eax
    call WriteToFile
    call CloseFile

menu:
    INVOKE PlaySound, OFFSET PacmanIntro, NULL, 0h
     mov eax,200
     call delay
    mov eax,yellow (brown*16)
    call SetTextColor
    call clrscr

    mov dl,0
    mov dh,0
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,5
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,24
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,19
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,10
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,15
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,55
    mov dh,3
    call Gotoxy
    mov edx,OFFSET menuPage
    call WriteString

    mov dl,48
    mov dh,20
    call Gotoxy
    mov edx,OFFSET startGame
    call WriteString

    mov dl,45
    mov dh,21
    call Gotoxy
    mov edx,OFFSET instruction
    call WriteString

    mov dl,49
    mov dh,22
    call Gotoxy
    mov edx,OFFSET forExiting
    call WriteString

    mov dl,57
    mov dh,23
    call Gotoxy
    mov edx,OFFSET ready
    call WriteString

    call readchar
    mov inputChar,al
    
    cmp inputChar,"s"
    je startingGame

    cmp inputChar,"i"
    je instructionStart
    
    cmp inputChar,"e"
    je exitGame

instructionStart:
INVOKE PlaySound, OFFSET PacmanIntro, NULL, 0h
     mov eax,200
     call delay
    mov eax,yellow (brown*16)
    call SetTextColor
    call clrscr

    mov dl,0
    mov dh,0
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,5
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,10
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,18
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,23
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,55
    mov dh,3
    call Gotoxy
    mov edx,OFFSET instructionHeading
    call WriteString

    mov dl,30
    mov dh,12
    call Gotoxy
    mov edx,OFFSET instruction1
    call WriteString

    mov dl,40
    mov dh,13
    call Gotoxy
    mov edx,OFFSET instruction2
    call WriteString
    
    mov dl,42
    mov dh,14
    call Gotoxy
    mov edx,OFFSET instruction3
    call WriteString

    mov dl,50
    mov dh,15
    call Gotoxy
    mov edx,OFFSET instruction4
    call WriteString

    mov dl,45
    mov dh,16
    call Gotoxy
    mov edx,OFFSET instruction7
    call WriteString

    mov dl,49
    mov dh,25
    call Gotoxy
    mov edx,OFFSET instruction5
    call WriteString

    mov dl,49
    mov dh,27
    call Gotoxy
    mov edx,OFFSET instruction6
    call WriteString

    call readchar
    mov inputChar,al

    cmp inputChar,"s"
    je startingGame
    
    cmp inputChar,"r"
    je menu

pauseGame:

    mov eax,yellow (brown*16)
    call SetTextColor
    call clrscr
    
    mov dl,0
    mov dh,0
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,3
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,6
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,9
    call Gotoxy
    mov edx,OFFSET ground
    call writestring
    
    mov dl,0
    mov dh,17
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,20
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,23
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,0
    mov dh,26
    call Gotoxy
    mov edx,OFFSET ground
    call writestring

    mov dl,40
    mov dh,13
    call Gotoxy
    mov edx,OFFSET pauseDisplay
    call WriteString

    call readchar
    mov inputChar,al
    cmp inputChar,"r"
    je done
    done:
        cmp levelcount,1
        je startingGame
        cmp levelcount,2
        je level2
        cmp levelcount,3
        je level3
        
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LEVEL1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
startingGame:

     mov eax,black (black)
     call SetTextColor
     call clrscr

   ; draw ground at (0,29):
    mov eax,lightblue (lightblue * 16)
    call SetTextColor
    INVOKE PlaySound, OFFSET GhostSound, NULL, 0h
     mov eax,900
     call delay
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString

    mov dl,0
    mov dh,1
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString

    mov ecx,27
    mov dh,2
    mov temp,dh
    l1:
    mov dh,temp
    mov dl,0
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    ;inc dh
    loop l1

    mov ecx,27
    mov dh,2
    mov temp,dh
    l2:
    mov dh,temp
    mov dl,119
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l2


    ;Horizontal Wall
;Middle of 3 small horizontal line. Collison done.
    mov ecx,35
    mov dl,45
    mov temp,dl
    l13:
    mov dl,temp
    mov dh,15
    call Gotoxy
    mov edx,OFFSET ground4
    call WriteString
    inc temp
    loop l13
;Upper of 3 small horizontal lines. Collison done.
    mov ecx,35
    mov dl,45
    mov temp,dl
    l14:
    mov dl,temp
    mov dh,11
    call Gotoxy
    mov edx,OFFSET ground4
    call WriteString
    inc temp
    loop l14
;Lower of 3 small horizontal lines. Collison done.
   mov ecx,35
    mov dl,45
    mov temp,dl
    l15:
    mov dl,temp
    mov dh,19
    call Gotoxy
    mov edx,OFFSET ground4
    call WriteString
    inc temp
    loop l15

;Top most horizontal line. Collison done.
    mov ecx,76
    mov dl,25
    mov temp,dl
    l11:
    mov dl,temp
    mov dh,4
    call Gotoxy
    mov edx,OFFSET ground4
    call WriteString
    inc temp
    loop l11

;Bottom most horizontal line. Collison done.
    mov ecx,76
    mov dl,25
    mov temp,dl
    l12:
    mov dl,temp
    mov dh,26
    call Gotoxy
    mov edx,OFFSET ground4
    call WriteString
    inc temp
    loop l12


    ;Vertical Walls
;Right side smallest line. Collison done.
    mov ecx,11
    mov dh,10
    mov temp,dh
    l3:
    mov dh,temp
    mov dl,90
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l3
;Left side smallest line. Collison done.
    mov ecx,11
    mov dh,10
    mov temp,dh
    l4:
    mov dh,temp
    mov dl,35
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l4
;Right side biggest line. Collison done.
    mov ecx,20
    mov dh,5
    mov temp,dh
    l5:
    mov dh,temp
    mov dl,110
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l5
;Left side biggest line. Collison done.
    mov ecx,20
    mov dh,5
    mov temp,dh
    l6:
    mov dh,temp
    mov dl,15
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l6
;Left side middle line. Collison done.
    mov ecx,15
    mov dh,8
    mov temp,dh
    l7:
    mov dh,temp
    mov dl,25
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l7
;Right side middle line. Collison done.
    mov ecx,15
    mov dh,8
    mov temp,dh
    l8:
    mov dh,temp
    mov dl,100
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l8
;Lower vertical line. Collison done.
    mov ecx,2
    mov dh,22
    mov temp,dh
    l9:
    mov dh,temp
    mov dl,60
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l9
;Upper vertical line. Collison done.
    mov ecx,2
    mov dh,7
    mov temp,dh
    l10:
    mov dh,temp
    mov dl,60
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop l10

    call DrawPlayer
    call DrawStar1
    call DrawStar2
    call DrawStar3
    call DrawStar4
    call DrawStar5
    call DrawStar6
    call DrawStar7
    call DrawStar8
    call DrawStar9
    call DrawStar10
    call DrawStar11
    call DrawStar12
    call DrawStar13
    call DrawStar14
    call DrawStar15
    call DrawStar16
    call DrawStar17
    call DrawStar18
    call DrawStar19
    call DrawStar20
    call DrawStar21
    call DrawStar22
    call DrawStar23
    call DrawStar24
    call DrawStar25
    call DrawStar26
    call DrawStar27
    call DrawStar28
    call DrawStar29
    call DrawStar30
    call DrawStar31
    call DrawStar32
    call DrawStar33
    call DrawStar34
    call DrawStar35
    call DrawStar36
    call DrawStar37
    call DrawStar38
    call DrawStar39
    call DrawStar40
    call DrawStar41
    call DrawStar42
    call DrawStar43
    call DrawStar44
    call DrawStar45
    call DrawStar46
    call DrawStar47
    call DrawStar48
    call DrawStar49
    call DrawStar50
    call DrawStar51
    call DrawStar52
    call DrawStar53
    call DrawStar54
   

    gameLoop:
        mov bl,xPos
        mov bh,yPos

        call Ghost1Lev1
        call DrawG1L1

        call Ghost2Lev1
        call DrawG2L1
    
        call G2L1Collision
        call G1L1Collision
            mov bl,xPos
            cmp bl,star1X
            jne check2
            mov bl,yPos
            cmp bl,star1Y
            jne check2
            inc score
            mov star1X,0
            mov star1Y,0

        check2:
            mov bl,xPos
            cmp bl,star2X
            jne check3
            mov bl,yPos
            cmp bl,star2Y
            jne check3
            inc score
            mov star2X,0
            mov star2Y,0
        
        check3:
            mov bl,xPos
            cmp bl,star3X
            jne check4
            mov bl,yPos
            cmp bl,star3Y
            jne check4
            inc score
            mov star3X,0
            mov star3Y,0

        check4:
            mov bl,xPos
            cmp bl,star4X
            jne check5
            mov bl,yPos
            cmp bl,star4Y
            jne check5
            inc score
            mov star4X,0
            mov star4Y,0
       
       check5:
            mov bl,xPos
            cmp bl,star5X
            jne check6
            mov bl,yPos
            cmp bl,star5Y
            jne check6
            inc score
            mov star5X,0
            mov star5Y,0

        check6:
            mov bl,xPos
            cmp bl,star6X
            jne check7
            mov bl,yPos
            cmp bl,star6Y
            jne check7
            inc score
            mov star6X,0
            mov star6Y,0

        check7:
            mov bl,xPos
            cmp bl,star7X
            jne check8
            mov bl,yPos
            cmp bl,star7Y
            jne check8
            inc score
            mov star7X,0
            mov star7Y,0

         check8:
            mov bl,xPos
            cmp bl,star8X
            jne check9
            mov bl,yPos
            cmp bl,star8Y
            jne check9
            inc score
            mov star8X,0
            mov star8Y,0

        check9:
            mov bl,xPos
            cmp bl,star9X
            jne check10
            mov bl,yPos
            cmp bl,star9Y
            jne check10
            inc score
            mov star9X,0
            mov star9Y,0

        check10:
            mov bl,xPos
            cmp bl,star10X
            jne check11
            mov bl,yPos
            cmp bl,star10Y
            jne check11
            inc score
            mov star10X,0
            mov star10Y,0

        check11:
            mov bl,xPos
            cmp bl,star11X
            jne check12
            mov bl,yPos
            cmp bl,star11Y
            jne check12
            inc score
            mov star11X,0
            mov star11Y,0

        check12:
            mov bl,xPos
            cmp bl,star12X
            jne check13
            mov bl,yPos
            cmp bl,star12Y
            jne check13
            inc score
            mov star12X,0
            mov star12Y,0

        check13:
            mov bl,xPos
            cmp bl,star13X
            jne check14
            mov bl,yPos
            cmp bl,star13Y
            jne check14
            inc score
            mov star13X,0
            mov star13Y,0

        check14:
            mov bl,xPos
            cmp bl,star14X
            jne check15
            mov bl,yPos
            cmp bl,star14Y
            jne check15
            inc score
            mov star14X,0
            mov star14Y,0
            
        check15:
            mov bl,xPos
            cmp bl,star15X
            jne check16
            mov bl,yPos
            cmp bl,star15Y
            jne check16
            inc score
            mov star15X,0
            mov star15Y,0

        check16:
            mov bl,xPos
            cmp bl,star16X
            jne check17
            mov bl,yPos
            cmp bl,star16Y
            jne check17
            inc score
            mov star16X,0
            mov star16Y,0

        check17:
            mov bl,xPos
            cmp bl,star17X
            jne check18
            mov bl,yPos
            cmp bl,star17Y
            jne check18
            inc score
            mov star17X,0
            mov star17Y,0

        check18:
            mov bl,xPos
            cmp bl,star18X
            jne check19
            mov bl,yPos
            cmp bl,star18Y
            jne check19
            inc score
            mov star18X,0
            mov star18Y,0

        check19:
            mov bl,xPos
            cmp bl,star19X
            jne check20
            mov bl,yPos
            cmp bl,star19Y
            jne check20
            inc score
            mov star19X,0
            mov star19Y,0

        check20:
            mov bl,xPos
            cmp bl,star20X
            jne check21
            mov bl,yPos
            cmp bl,star20Y
            jne check21
            inc score
            mov star20X,0
            mov star20Y,0

        check21:
            mov bl,xPos
            cmp bl,star21X
            jne check22
            mov bl,yPos
            cmp bl,star21Y
            jne check22
            inc score
            mov star21X,0
            mov star21Y,0

        check22:
            mov bl,xPos
            cmp bl,star22X
            jne check23
            mov bl,yPos
            cmp bl,star22Y
            jne check23
            inc score
            mov star22X,0
            mov star22Y,0

        check23:
            mov bl,xPos
            cmp bl,star23X
            jne check24
            mov bl,yPos
            cmp bl,star23Y
            jne check24
            inc score
            mov star23X,0
            mov star23Y,0

        check24:
            mov bl,xPos
            cmp bl,star24X
            jne check25
            mov bl,yPos
            cmp bl,star24Y
            jne check25
            inc score
            mov star24X,0
            mov star24Y,0

        check25:
            mov bl,xPos
            cmp bl,star25X
            jne check26
            mov bl,yPos
            cmp bl,star25Y
            jne check26
            inc score
            mov star25X,0
            mov star25Y,0

        check26:
            mov bl,xPos
            cmp bl,star26X
            jne check27
            mov bl,yPos
            cmp bl,star26Y
            jne check27
            inc score
            mov star26X,0
            mov star26Y,0

        check27:
            mov bl,xPos
            cmp bl,star27X
            jne check28
            mov bl,yPos
            cmp bl,star27Y
            jne check28
            inc score
            mov star27X,0
            mov star27Y,0

        check28:
            mov bl,xPos
            cmp bl,star28X
            jne check29
            mov bl,yPos
            cmp bl,star28Y
            jne check29
            inc score
            mov star28X,0
            mov star28Y,0

        check29:
            mov bl,xPos
            cmp bl,star29X
            jne check30
            mov bl,yPos
            cmp bl,star29Y
            jne check30
            inc score
            mov star29X,0
            mov star29Y,0

        check30:
            mov bl,xPos
            cmp bl,star30X
            jne check31
            mov bl,yPos
            cmp bl,star30Y
            jne check31
            inc score
            mov star30X,0
            mov star30Y,0

        check31:
            mov bl,xPos
            cmp bl,star31X
            jne check32
            mov bl,yPos
            cmp bl,star31Y
            jne check32
            inc score
            mov star31X,0
            mov star31Y,0

        check32:
            mov bl,xPos
            cmp bl,star32X
            jne check33
            mov bl,yPos
            cmp bl,star32Y
            jne check33
            inc score
            mov star32X,0
            mov star32Y,0

        check33:
            mov bl,xPos
            cmp bl,star33X
            jne check34
            mov bl,yPos
            cmp bl,star33Y
            jne check34
            inc score
            mov star33X,0
            mov star33Y,0

        check34:
            mov bl,xPos
            cmp bl,star34X
            jne check35
            mov bl,yPos
            cmp bl,star34Y
            jne check35
            inc score
            mov star34X,0
            mov star34Y,0

        check35:
            mov bl,xPos
            cmp bl,star35X
            jne check36
            mov bl,yPos
            cmp bl,star35Y
            jne check36
            inc score
            mov star35X,0
            mov star35Y,0

        check36:
            mov bl,xPos
            cmp bl,star36X
            jne check37
            mov bl,yPos
            cmp bl,star36Y
            jne check37
            inc score
            mov star36X,0
            mov star36Y,0

        check37:
            mov bl,xPos
            cmp bl,star37X
            jne check38
            mov bl,yPos
            cmp bl,star37Y
            jne check38
            inc score
            mov star37X,0
            mov star37Y,0

        check38:
            mov bl,xPos
            cmp bl,star38X
            jne check39
            mov bl,yPos
            cmp bl,star38Y
            jne check39
            inc score
            mov star38X,0
            mov star38Y,0

        check39:
            mov bl,xPos
            cmp bl,star39X
            jne check40
            mov bl,yPos
            cmp bl,star39Y
            jne check40
            inc score
            mov star39X,0
            mov star39Y,0

        check40:
            mov bl,xPos
            cmp bl,star40X
            jne check41
            mov bl,yPos
            cmp bl,star40Y
            jne check41
            inc score
            mov star40X,0
            mov star40Y,0

        check41:
            mov bl,xPos
            cmp bl,star41X
            jne check42
            mov bl,yPos
            cmp bl,star41Y
            jne check42
            inc score
            mov star41X,0
            mov star41Y,0

        check42:
            mov bl,xPos
            cmp bl,star42X
            jne check43
            mov bl,yPos
            cmp bl,star42Y
            jne check43
            inc score
            mov star42X,0
            mov star42Y,0

        check43:
            mov bl,xPos
            cmp bl,star43X
            jne check44
            mov bl,yPos
            cmp bl,star43Y
            jne check44
            inc score
            mov star43X,0
            mov star43Y,0

        check44:
            mov bl,xPos
            cmp bl,star44X
            jne check45
            mov bl,yPos
            cmp bl,star44Y
            jne check45
            inc score
            mov star44X,0
            mov star44Y,0

        check45:
            mov bl,xPos
            cmp bl,star45X
            jne check46
            mov bl,yPos
            cmp bl,star45Y
            jne check46
            inc score
            mov star45X,0
            mov star45Y,0

        check46:
            mov bl,xPos
            cmp bl,star46X
            jne check47
            mov bl,yPos
            cmp bl,star46Y
            jne check47
            inc score
            mov star46X,0
            mov star46Y,0

        check47:
            mov bl,xPos
            cmp bl,star47X
            jne check48
            mov bl,yPos
            cmp bl,star47Y
            jne check48
            inc score
            mov star47X,0
            mov star47Y,0

        check48:
            mov bl,xPos
            cmp bl,star48X
            jne check49
            mov bl,yPos
            cmp bl,star48Y
            jne check49
            inc score
            mov star48X,0
            mov star48Y,0

        check49:
            mov bl,xPos
            cmp bl,star49X
            jne check50
            mov bl,yPos
            cmp bl,star49Y
            jne check50
            inc score
            mov star49X,0
            mov star49Y,0

        check50:
            mov bl,xPos
            cmp bl,star50X
            jne check51
            mov bl,yPos
            cmp bl,star50Y
            jne check51
            inc score
            mov star50X,0
            mov star50Y,0

        check51:
            mov bl,xPos
            cmp bl,star51X
            jne check52
            mov bl,yPos
            cmp bl,star51Y
            jne check52
            inc score
            mov star51X,0
            mov star51Y,0
        
        check52:
            mov bl,xPos
            cmp bl,star52X
            jne check53
            mov bl,yPos
            cmp bl,star52Y
            jne check53
            inc score
            mov star52X,0
            mov star52Y,0

        check53:
            mov bl,xPos
            cmp bl,star53X
            jne check54
            mov bl,yPos
            cmp bl,star53Y
            jne check54
            inc score
            mov star53X,0
            mov star53Y,0

        check54:
            mov bl,xPos
            cmp bl,star54X
            jne notCollecting
            mov bl,yPos
            cmp bl,star54Y
            jne notCollecting
            inc score
            mov star54X,0
            mov star54Y,0

        notCollecting:
            mov eax,white (black * 16)
            call SetTextColor

        ; draw score:
        mov dl,0
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov eax,0
        mov al,score
        cmp score,54
        jge level2
        call WriteInt

        mov dl,57
        mov dh,0
        call Gotoxy
        mov edx,OFFSET stdLives
        call WriteString
        mov eax,0
        mov al,lives
        call WriteInt
        cmp lives,0
        je exitGame

        mov dl,110
        mov dh,0
        call Gotoxy
        mov edx,OFFSET stdLevel
        call WriteString
        mov eax,0
        mov al,levelcount
        call WriteInt

        ; gravity logic:
        gravity:
        cmp yPos,0
        jg onGround
        ; make player fall:
        call UpdatePlayer
        inc yPos
        call DrawPlayer
        mov eax,80
        call Delay
        jmp gravity
        onGround:
        
        call ReadChar
        mov inputChar,al

       cmp inputChar,"p"
       je Gamepaused

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame

        cmp inputChar,"w"
        je moveUp

        cmp inputChar,"s"
        je moveDown

        cmp inputChar,"a"
        je moveLeft

        cmp inputChar,"d"
        je moveRight

    Gamepaused:
       jmp  pauseGame

     moveUp:

        cmp yPos,2
        je gameLoop

        mov bl,xPos
        mov bh,yPos
        dec bh
        mov line1bool,0

        call line1
        cmp line1bool,1
        je directionchange

        call line2
        cmp line1bool,1
        je directionchange

        call line3
        cmp line1bool,1
        je directionchange

        call line4
        cmp line1bool,1
        je directionchange

        call line5
        cmp line1bool,1
        je directionchange

        call line6
        cmp line1bool,1
        je directionchange

        call line7
        cmp line1bool,1
        je directionchange

        call line8
        cmp line1bool,1
        je directionchange

        call line9
        cmp line1bool,1
        je directionchange

        call line10
        cmp line1bool,1
        je directionchange

        call line11
        cmp line1bool,1
        je directionchange

        call line12
        cmp line1bool,1
        je directionchange

        call line13
        cmp line1bool,1
        je directionchange

        call UpdatePlayer
        dec yPos
        call DrawPlayer
        jmp gameLoop

    moveDown:

        cmp yPos,28
        je gameLoop

        mov bl,xPos
        mov bh,yPos
        inc bh
        mov line1bool,0

        call line1
        cmp line1bool,1
        je  directionchange

        call line2
        cmp line1bool,1
        je directionchange

        call line3
        cmp line1bool,1
        je directionchange

        call line4
        cmp line1bool,1
        je directionchange

        call line5
        cmp line1bool,1
        je directionchange

        call line6
        cmp line1bool,1
        je directionchange

        call line7
        cmp line1bool,1
        je directionchange

        call line8
        cmp line1bool,1
        je directionchange

        call line9
        cmp line1bool,1
        je directionchange

        call line10
        cmp line1bool,1
        je directionchange

        call line11
        cmp line1bool,1
        je directionchange

        call line12
        cmp line1bool,1
        je directionchange

        call line13
        cmp line1bool,1
        je directionchange

        call UpdatePlayer
        inc yPos
        call DrawPlayer
        jmp gameLoop

     moveLeft:

        cmp xPos,1
        je gameLoop

        mov bl,xPos
        mov bh,yPos
        dec bl
        mov line1bool,0

        call line1
        cmp line1bool,1
        je  directionchange

        call line2
        cmp line1bool,1
        je directionchange

        call line3
        cmp line1bool,1
        je directionchange

        call line4
        cmp line1bool,1
        je directionchange

        call line5
        cmp line1bool,1
        je directionchange

        call line6
        cmp line1bool,1
        je directionchange

        call line7
        cmp line1bool,1
        je directionchange

        call line8
        cmp line1bool,1
        je directionchange

        call line9
        cmp line1bool,1
        je directionchange

        call line10
        cmp line1bool,1
        je directionchange

        call line11
        cmp line1bool,1
        je directionchange

        call line12
        cmp line1bool,1
        je directionchange

        call line13
        cmp line1bool,1
        je directionchange

        call UpdatePlayer
        dec xPos
        call DrawPlayer
        jmp gameLoop

    moveRight:

        cmp xPos,118
        je gameLoop

        mov bl,xPos
        mov bh,yPos
        inc bl
        mov line1bool,0

        call line1
        cmp line1bool,1
        je  directionchange

        call line2
        cmp line1bool,1
        je directionchange

        call line3
        cmp line1bool,1
        je directionchange

        call line4
        cmp line1bool,1
        je directionchange

        call line5
        cmp line1bool,1
        je directionchange

        call line6
        cmp line1bool,1
        je directionchange

        call line7
        cmp line1bool,1
        je directionchange

        call line8
        cmp line1bool,1
        je directionchange

        call line9
        cmp line1bool,1
        je directionchange

        call line10
        cmp line1bool,1
        je directionchange

        call line11
        cmp line1bool,1
        je directionchange

        call line12
        cmp line1bool,1
        je directionchange

        call line13
        cmp line1bool,1
        je directionchange

        call UpdatePlayer
        inc xPos
        call DrawPlayer
        jmp gameLoop

directionchange:
   jmp gameLoop
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LEVEL2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
level2:

    mov eax,black (black*16)
    call SetTextColor
    call clrscr
    
    INVOKE PlaySound, OFFSET GhostSound, NULL, 0h
     mov eax,900
     call delay

        ; draw ground at (0,29):
    mov eax,yellow (yellow * 16)
    call SetTextColor
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString

    mov levelcount,2

    mov dl,0
    mov dh,1
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString

    mov ecx,27
    mov dh,2
    mov temp,dh
    e1:
    mov dh,temp
    mov dl,0
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    ;inc dh
    loop e1

    mov ecx,27
    mov dh,2
    mov temp,dh
    e2:
    mov dh,temp
    mov dl,119
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop e2

    ;Vertical Walls
;Right side biggest line. Collison done.
    mov ecx,22
    mov dh,4
    mov temp,dh
    e3:
    mov dh,temp
    mov dl,110
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop e3

    mov ecx,22
    mov dh,4
    mov temp,dh
    e4:
    mov dh,temp
    mov dl,10
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop e4

    mov ecx,18
    mov dh,4
    mov temp,dh
    e6:
    mov dh,temp
    mov dl,18
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop e6

    mov ecx,18
    mov dh,4
    mov temp,dh
    e7:
    mov dh,temp
    mov dl,102
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop e7

    mov ecx,14
    mov dh,4
    mov temp,dh
    e9:
    mov dh,temp
    mov dl,94
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop e9

    mov ecx,14
    mov dh,4
    mov temp,dh
    e10:
    mov dh,temp
    mov dl,26
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop e10

    mov ecx,10
    mov dh,4
    mov temp,dh
    e12:
    mov dh,temp
    mov dl,34
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop e12

    mov ecx,10
    mov dh,4
    mov temp,dh
    e13:
    mov dh,temp
    mov dl,86
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop e13

    ;Horizontal walls.
    mov ecx,91
    mov dl,15
    mov temp,dl
    e5:
    mov dl,temp
    mov dh,26
    call Gotoxy
    mov edx,OFFSET ground4
    call WriteString
    inc temp
    loop e5

    mov ecx,75
    mov dl,23
    mov temp,dl
    e8:
    mov dl,temp
    mov dh,22
    call Gotoxy
    mov edx,OFFSET ground4
    call WriteString
    inc temp
    loop e8

    mov ecx,59
    mov dl,31
    mov temp,dl
    e11:
    mov dl,temp
    mov dh,18
    call Gotoxy
    mov edx,OFFSET ground4
    call WriteString
    inc temp
    loop e11

    mov ecx,43
    mov dl,39
    mov temp,dl
    e14:
    mov dl,temp
    mov dh,14
    call Gotoxy
    mov edx,OFFSET ground4
    call WriteString
    inc temp
    loop e14

    mov ecx,43
    mov dl,39
    mov temp,dl
    e15:
    mov dl,temp
    mov dh,4
    call Gotoxy
    mov edx,OFFSET ground4
    call WriteString
    inc temp
    loop e15

    mov xPos,60
    mov yPos,8
    call DrawPlayer2
    call DrawStar101
    call DrawStar102
    call DrawStar103
    call DrawStar104
    call DrawStar105
    call DrawStar106
    call DrawStar107
    call DrawStar108
    call DrawStar109
    call DrawStar110
    call DrawStar111
    call DrawStar112
    call DrawStar113
    call DrawStar114
    call DrawStar115
    call DrawStar116
    call DrawStar117
    call DrawStar118
    call DrawStar119
    call DrawStar120
    call DrawStar121
    call DrawStar122
    call DrawStar123
    call DrawStar124
    call DrawStar125
    call DrawStar126
    call DrawStar127
    call DrawStar128
    call DrawStar129
    call DrawStar130
    call DrawStar131
    call DrawStar132
    call DrawStar133
    call DrawStar134
    call DrawStar135
    call DrawStar136
    call DrawStar137
    call DrawStar138
    call DrawStar139
    call DrawStar140
    call DrawStar141
    call DrawStar142
    call DrawStar143
    call DrawStar144
    call DrawStar145

    gameLoop2:

            mov bl,xPos
            mov bh,yPos

            call Ghost1Lev2
            call G1L2Collision
            call DrawG1L2

            call Ghost2Lev2
            call G2L2Collision
            call DrawG2L2

            call Ghost3Lev2
            call G3L2Collision
            call DrawG3L2

            call Ghost4Lev2
            call G4L2Collision
            call DrawG4L2

            call Ghost5Lev2
            call G5L2Collision
            call DrawG5L2

            call Ghost6Lev2
            call G6L2Collision
            call DrawG6L2
            
            mov bl,xPos
            cmp bl,star101X
            jne check102
            mov bl,yPos
            cmp bl,star101Y
            jne check102
            inc score
            mov star101X,0
            mov star101Y,0
        
        check102:
            mov bl,xPos
            cmp bl,star102X
            jne check103
            mov bl,yPos
            cmp bl,star102Y
            jne check103
            inc score
            mov star102X,0
            mov star102Y,0

        check103:
            mov bl,xPos
            cmp bl,star103X
            jne check104
            mov bl,yPos
            cmp bl,star103Y
            jne check104
            inc score
            mov star103X,0
            mov star103Y,0

        check104:
            mov bl,xPos
            cmp bl,star104X
            jne check105
            mov bl,yPos
            cmp bl,star104Y
            jne check105
            add score,5
            mov star104X,0
            mov star104Y,0

        check105:
            mov bl,xPos
            cmp bl,star105X
            jne check106
            mov bl,yPos
            cmp bl,star105Y
            jne check106
            inc score
            mov star105X,0
            mov star105Y,0

        check106:
            mov bl,xPos
            cmp bl,star106X
            jne check107
            mov bl,yPos
            cmp bl,star106Y
            jne check107
            inc score
            mov star106X,0
            mov star106Y,0

        check107:
            mov bl,xPos
            cmp bl,star107X
            jne check108
            mov bl,yPos
            cmp bl,star107Y
            jne check108
            inc score
            mov star107X,0
            mov star107Y,0

        check108:
            mov bl,xPos
            cmp bl,star108X
            jne check109
            mov bl,yPos
            cmp bl,star108Y
            jne check109
            inc score
            mov star108X,0
            mov star108Y,0

        check109:
            mov bl,xPos
            cmp bl,star109X
            jne check110
            mov bl,yPos
            cmp bl,star109Y
            jne check110
            inc score
            mov star109X,0
            mov star109Y,0

        check110:
            mov bl,xPos
            cmp bl,star110X
            jne check111
            mov bl,yPos
            cmp bl,star110Y
            jne check111
            inc score
            mov star110X,0
            mov star110Y,0

        check111:
            mov bl,xPos
            cmp bl,star111X
            jne check112
            mov bl,yPos
            cmp bl,star111Y
            jne check112
            inc score
            mov star111X,0
            mov star111Y,0

        check112:
            mov bl,xPos
            cmp bl,star112X
            jne check113
            mov bl,yPos
            cmp bl,star112Y
            jne check113
            inc score
            mov star112X,0
            mov star112Y,0

        check113:
            mov bl,xPos
            cmp bl,star113X
            jne check114
            mov bl,yPos
            cmp bl,star113Y
            jne check114
            inc score
            mov star113X,0
            mov star113Y,0

        check114:
            mov bl,xPos
            cmp bl,star114X
            jne check115
            mov bl,yPos
            cmp bl,star114Y
            jne check115
            inc score
            mov star114X,0
            mov star114Y,0

        check115:
            mov bl,xPos
            cmp bl,star115X
            jne check116
            mov bl,yPos
            cmp bl,star115Y
            jne check116
            inc score
            mov star115X,0
            mov star115Y,0

        check116:
            mov bl,xPos
            cmp bl,star116X
            jne check117
            mov bl,yPos
            cmp bl,star116Y
            jne check117
            inc score
            mov star116X,0
            mov star116Y,0

        check117:
            mov bl,xPos
            cmp bl,star117X
            jne check118
            mov bl,yPos
            cmp bl,star117Y
            jne check118
            inc score
            mov star117X,0
            mov star117Y,0

        check118:
            mov bl,xPos
            cmp bl,star118X
            jne check119
            mov bl,yPos
            cmp bl,star118Y
            jne check119
            inc score
            mov star118X,0
            mov star118Y,0

        check119:
            mov bl,xPos
            cmp bl,star119X
            jne check120
            mov bl,yPos
            cmp bl,star119Y
            jne check120
            inc score
            mov star119X,0
            mov star119Y,0

        check120:
            mov bl,xPos
            cmp bl,star120X
            jne check121
            mov bl,yPos
            cmp bl,star120Y
            jne check121
            inc score
            mov star120X,0
            mov star120Y,0

        check121:
            mov bl,xPos
            cmp bl,star121X
            jne check122
            mov bl,yPos
            cmp bl,star121Y
            jne check122
            inc score
            mov star121X,0
            mov star121Y,0

        check122:
            mov bl,xPos
            cmp bl,star122X
            jne check123
            mov bl,yPos
            cmp bl,star122Y
            jne check123
            inc score
            mov star122X,0
            mov star122Y,0

        check123:
            mov bl,xPos
            cmp bl,star123X
            jne check124
            mov bl,yPos
            cmp bl,star123Y
            jne check124
            inc score
            mov star123X,0
            mov star123Y,0

        check124:
            mov bl,xPos
            cmp bl,star124X
            jne check125
            mov bl,yPos
            cmp bl,star124Y
            jne check125
            inc score
            mov star124X,0
            mov star124Y,0

        check125:
            mov bl,xPos
            cmp bl,star125X
            jne check126
            mov bl,yPos
            cmp bl,star125Y
            jne check126
            inc score
            mov star125X,0
            mov star125Y,0

        check126:
            mov bl,xPos
            cmp bl,star126X
            jne check127
            mov bl,yPos
            cmp bl,star126Y
            jne check127
            inc score
            mov star126X,0
            mov star126Y,0

        check127:
            mov bl,xPos
            cmp bl,star127X
            jne check128
            mov bl,yPos
            cmp bl,star127Y
            jne check128
            inc score
            mov star127X,0
            mov star127Y,0

        check128:
            mov bl,xPos
            cmp bl,star128X
            jne check129
            mov bl,yPos
            cmp bl,star128Y
            jne check129
            inc score
            mov star128X,0
            mov star128Y,0

        check129:
            mov bl,xPos
            cmp bl,star129X
            jne check130
            mov bl,yPos
            cmp bl,star129Y
            jne check130
            inc score
            mov star129X,0
            mov star129Y,0

        check130:
            mov bl,xPos
            cmp bl,star130X
            jne check131
            mov bl,yPos
            cmp bl,star130Y
            jne check131
            inc score
            mov star130X,0
            mov star130Y,0

        check131:
            mov bl,xPos
            cmp bl,star131X
            jne check132
            mov bl,yPos
            cmp bl,star131Y
            jne check132
            inc score
            mov star131X,0
            mov star131Y,0

        check132:
            mov bl,xPos
            cmp bl,star132X
            jne check133
            mov bl,yPos
            cmp bl,star132Y
            jne check133
            inc score
            mov star132X,0
            mov star132Y,0

        check133:
            mov bl,xPos
            cmp bl,star133X
            jne check134
            mov bl,yPos
            cmp bl,star133Y
            jne check134
            inc score
            mov star133X,0
            mov star133Y,0

        check134:
            mov bl,xPos
            cmp bl,star134X
            jne check135
            mov bl,yPos
            cmp bl,star134Y
            jne check135
            inc score
            mov star134X,0
            mov star134Y,0

        check135:
            mov bl,xPos
            cmp bl,star135X
            jne check136
            mov bl,yPos
            cmp bl,star135Y
            jne check136
            inc score
            mov star135X,0
            mov star135Y,0

        check136:
            mov bl,xPos
            cmp bl,star136X
            jne check137
            mov bl,yPos
            cmp bl,star136Y
            jne check137
            add score,5
            mov star136X,0
            mov star136Y,0

        check137:
            mov bl,xPos
            cmp bl,star137X
            jne check138
            mov bl,yPos
            cmp bl,star137Y
            jne check138
            inc score
            mov star137X,0
            mov star137Y,0

        check138:
            mov bl,xPos
            cmp bl,star138X
            jne check139
            mov bl,yPos
            cmp bl,star138Y
            jne check139
            inc score
            mov star138X,0
            mov star138Y,0

        check139:
            mov bl,xPos
            cmp bl,star139X
            jne check140
            mov bl,yPos
            cmp bl,star139Y
            jne check140
            inc score
            mov star139X,0
            mov star139Y,0

        check140:
            mov bl,xPos
            cmp bl,star140X
            jne check141
            mov bl,yPos
            cmp bl,star140Y
            jne check141
            inc score
            mov star140X,0
            mov star140Y,0

        check141:
            mov bl,xPos
            cmp bl,star141X
            jne check142
            mov bl,yPos
            cmp bl,star141Y
            jne check142
            inc score
            mov star141X,0
            mov star141Y,0

        check142:
            mov bl,xPos
            cmp bl,star142X
            jne check143
            mov bl,yPos
            cmp bl,star142Y
            jne check143
            inc score
            mov star142X,0
            mov star142Y,0

        check143:
            mov bl,xPos
            cmp bl,star143X
            jne check144
            mov bl,yPos
            cmp bl,star143Y
            jne check144
            inc score
            mov star143X,0
            mov star143Y,0

        check144:
            mov bl,xPos
            cmp bl,star144X
            jne check145
            mov bl,yPos
            cmp bl,star144Y
            jne check145
            inc score
            mov star144X,0
            mov star144Y,0

        check145:
            mov bl,xPos
            cmp bl,star145X
            jne notCollecting2
            mov bl,yPos
            cmp bl,star145Y
            jne notCollecting2
            inc score
            mov star145X,0
            mov star145Y,0

        notCollecting2:

        mov eax,white (black * 16)
        call SetTextColor

        mov dl,57
        mov dh,0
        call Gotoxy
        mov edx,OFFSET stdLives
        call WriteString
        mov eax,0
        mov al,lives
        call WriteInt
        cmp lives,0
        je exitGame

        mov dl,110
        mov dh,0
        call Gotoxy
        mov edx,OFFSET stdLevel
        call WriteString
        mov eax,0
        mov al,levelcount
        call WriteInt

        ; draw score:
        mov dl,0
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov eax,0
        mov al,score
        cmp score,107
        jge level3
        call WriteInt

        ; gravity logic:
        gravity2:
        cmp yPos,0
        jg onGround2
        ; make player fall:
        call UpdatePlayer
        inc yPos
        call DrawPlayer
        mov eax,80
        call Delay
        jmp gravity2
        onGround2:

        ; get user key input:
        call ReadChar
        mov inputChar,al

        cmp inputChar,"r"
        je Gamepaused2

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame

        cmp inputChar,"w"
        je moveUp2

        cmp inputChar,"s"
        je moveDown2

        cmp inputChar,"a"
        je moveLeft2

        cmp inputChar,"d"
        je moveRight2

    Gamepaused2:
        jmp pauseGame

     moveUp2:

        cmp yPos,2
        je gameLoop2

        mov bl,xPos
        mov bh,yPos
        dec bh
        mov line1bool,0

        call line21
        cmp line1bool,1
        je directionchange2

        call line22
        cmp line1bool,1
        je  directionchange2

        call line23
        cmp line1bool,1
        je  directionchange2

        call line24
        cmp line1bool,1
        je  directionchange2

        call line25
        cmp line1bool,1
        je  directionchange2

        call line26
        cmp line1bool,1
        je  directionchange2
        
        call line27
        cmp line1bool,1
        je  directionchange2

        call line28
        cmp line1bool,1
        je  directionchange2

        call line29
        cmp line1bool,1
        je  directionchange2

        call line30
        cmp line1bool,1
        je  directionchange2

        call line31
        cmp line1bool,1
        je  directionchange2

        call line32
        cmp line1bool,1
        je  directionchange2

        call line33
        cmp line1bool,1
        je  directionchange2

        call UpdatePlayer
        dec yPos
        call DrawPlayer
        jmp gameLoop2

    moveDown2:

        cmp yPos,28
        je gameLoop2

        mov bl,xPos
        mov bh,yPos
        inc bh
        mov line1bool,0

        call line21
        cmp line1bool,1
        je  directionchange2

        call line22
        cmp line1bool,1
        je  directionchange2

        call line23
        cmp line1bool,1
        je  directionchange2

        call line24
        cmp line1bool,1
        je  directionchange2

        call line25
        cmp line1bool,1
        je  directionchange2

        call line26
        cmp line1bool,1
        je  directionchange2
        
        call line27
        cmp line1bool,1
        je  directionchange2

        call line28
        cmp line1bool,1
        je  directionchange2

        call line29
        cmp line1bool,1
        je  directionchange2

        call line30
        cmp line1bool,1
        je  directionchange2

        call line31
        cmp line1bool,1
        je  directionchange2

        call line32
        cmp line1bool,1
        je  directionchange2

        call line33
        cmp line1bool,1
        je  directionchange2

        call UpdatePlayer
        inc yPos
        call DrawPlayer
        jmp gameLoop2

     moveLeft2:

        cmp xPos,1
        je gameLoop2

        mov bl,xPos
        mov bh,yPos
        dec bl
        mov line1bool,0

        call line21
        cmp line1bool,1
        je  directionchange2

        call line22
        cmp line1bool,1
        je  directionchange2

        call line23
        cmp line1bool,1
        je  directionchange2

        call line24
        cmp line1bool,1
        je  directionchange2

        call line25
        cmp line1bool,1
        je  directionchange2

        call line26
        cmp line1bool,1
        je  directionchange2

        call line27
        cmp line1bool,1
        je  directionchange2

        call line28
        cmp line1bool,1
        je  directionchange2

        call line29
        cmp line1bool,1
        je  directionchange2

        call line30
        cmp line1bool,1
        je  directionchange2

        call line31
        cmp line1bool,1
        je  directionchange2

        call line32
        cmp line1bool,1
        je  directionchange2

        call line33
        cmp line1bool,1
        je  directionchange2

        call UpdatePlayer
        dec xPos
        call DrawPlayer
        jmp gameLoop2

    moveRight2:

        cmp xPos,118
        je gameLoop2

        mov bl,xPos
        mov bh,yPos
        inc bl
        mov line1bool,0

        call line21
        cmp line1bool,1
        je  directionchange2

        call line22
        cmp line1bool,1
        je  directionchange2

        call line23
        cmp line1bool,1
        je  directionchange2

        call line24
        cmp line1bool,1
        je  directionchange2

        call line25
        cmp line1bool,1
        je  directionchange2

        call line26
        cmp line1bool,1
        je  directionchange2

        call line27
        cmp line1bool,1
        je  directionchange2

        call line28
        cmp line1bool,1
        je  directionchange2

        call line29
        cmp line1bool,1
        je  directionchange2

        call line30
        cmp line1bool,1
        je  directionchange2

        call line31
        cmp line1bool,1
        je  directionchange2

        call line32
        cmp line1bool,1
        je  directionchange2

        call line33
        cmp line1bool,1
        je  directionchange2

        call UpdatePlayer
        inc xPos
        call DrawPlayer
        jmp gameLoop2
directionchange2:
        jmp gameLoop2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;LEVEL3;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
level3:

    mov eax,black (black*16)
    call SetTextColor
    call clrscr

    ; draw ground at (0,29):
    mov eax,red (red * 16)
    call SetTextColor
    mov dl,0
    mov dh,29
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString

    INVOKE PlaySound, OFFSET GhostSound, NULL, 0h
     mov eax,900
     call delay

    mov levelcount,3
    mov lives,1
    mov dl,0
    mov dh,1
    call Gotoxy
    mov edx,OFFSET ground
    call WriteString

    mov ecx,25
    mov dh,3
    mov temp,dh
    g1:
    mov dh,temp
    mov dl,0
    call Gotoxy
    mov edx,OFFSET ground1
    call WriteString
    inc temp
    ;inc dh
    loop g1

    mov ecx,25
    mov dh,3
    mov temp,dh
    g2:
    mov dh,temp
    mov dl,119
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop g2

    ;Vertical Walls
    mov ecx,24
    mov dh,3
    mov temp,dh
    g3:
    mov dh,temp
    mov dl,110
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop g3

    mov ecx,24
    mov dh,3
    mov temp,dh
    g4:
    mov dh,temp
    mov dl,10
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop g4

    mov ecx,18
    mov dh,6
    mov temp,dh
    g7:
    mov dh,temp
    mov dl,101
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop g7

    mov ecx,18
    mov dh,6
    mov temp,dh
    g8:
    mov dh,temp
    mov dl,19
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop g8

    mov ecx,12
    mov dh,9
    mov temp,dh
    g11:
    mov dh,temp
    mov dl,91
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop g11

    mov ecx,12
    mov dh,9
    mov temp,dh
    g12:
    mov dh,temp
    mov dl,29
    call Gotoxy
    mov edx,OFFSET ground2
    call WriteString
    inc temp
    loop g12

    ;Horizontal walls
    mov ecx,99
    mov dl,11
    mov temp,dl
    g5:
    mov dl,temp
    mov dh,26
    call Gotoxy
    mov edx,OFFSET ground4
    call WriteString
    inc temp
    loop g5

    mov ecx,96
    mov dl,11
    mov temp,dl
    g6:
    mov dl,temp
    mov dh,3
    call Gotoxy
    mov edx,OFFSET ground4
    call WriteString
    inc temp
    loop g6

    mov ecx,81
    mov dl,20
    mov temp,dl
    g9:
    mov dl,temp
    mov dh,6
    call Gotoxy
    mov edx,OFFSET ground4
    call WriteString
    inc temp
    loop g9

    mov ecx,77
    mov dl,20
    mov temp,dl
    g10:
    mov dl,temp
    mov dh,23
    call Gotoxy
    mov edx,OFFSET ground4
    call WriteString
    inc temp
    loop g10

    mov ecx,62
    mov dl,30
    mov temp,dl
    g13:
    mov dl,temp
    mov dh,20
    call Gotoxy
    mov edx,OFFSET ground4
    call WriteString
    inc temp
    loop g13

    mov ecx,57
    mov dl,30
    mov temp,dl
    g14:
    mov dl,temp
    mov dh,9
    call Gotoxy
    mov edx,OFFSET ground4
    call WriteString
    inc temp
    loop g14

    mov ecx,56
    mov dl,35
    mov temp,dl
    g15:
    mov dl,temp
    mov dh,14
    call Gotoxy
    mov edx,OFFSET ground4
    call WriteString
    inc temp
    loop g15

    mov xPos,5
    mov yPos,3
    call DrawPlayer
    call DrawStar201
    call DrawStar202
    call DrawStar203
    call DrawStar204
    call DrawStar205
    call DrawStar206
    call DrawStar207
    call DrawStar208
    call DrawStar209
    call DrawStar210
    call DrawStar211
    call DrawStar212
    call DrawStar213
    call DrawStar214
    call DrawStar215
    call DrawStar216
    call DrawStar217
    call DrawStar218
    call DrawStar219
    call DrawStar220
    call DrawStar221
    call DrawStar222
    call DrawStar223
    call DrawStar224
    call DrawStar225
    call DrawStar226
    call DrawStar227
    call DrawStar228
    call DrawStar229
    call DrawStar230
    call DrawStar231
    call DrawStar232
    call DrawStar233
    call DrawStar234
    call DrawStar235
    call DrawStar236
    call DrawStar237
    call DrawStar238
    call DrawStar239
    call DrawStar240
    call DrawStar241
    call DrawStar242
    call DrawStar243
    call DrawStar244
    call DrawStar245
    call DrawStar246
    call DrawStar247
    call DrawStar248
    call DrawStar249


    gameLoop3:
        
        cmp key,150
        jne keylabel2

        mov bl,xPos
        mov bh,yPos

        call Ghost1Lev3
        call DrawG1L3

        call Ghost2Lev3
        call DrawG2L3

        call Ghost3Lev3
        call DrawG3L3

        call Ghost4Lev3
        call DrawG4L3

        call Ghost5Lev3
        call DrawG5L3

        call Ghost6Lev3
        call DrawG6L3

        call Ghost7Lev3
        call DrawG7L3

        call Ghost8Lev3
        call DrawG8L3
    keylabel2:
        call G1L3Collision
        call G2L3Collision
        call G3L3Collision
        call G4L3Collision
        call G5L3Collision
        call G6L3Collision
        call G7L3Collision
        call G8L3Collision

       mov bl,xPos
       cmp bl,star201X
       jne check202
       mov bl,yPos
       cmp bl,star201Y
       jne check202
       inc score
       mov star201X,0
       mov star201Y,0

    check202:
        mov bl,xPos
       cmp bl,star202X
       jne check203
       mov bl,yPos
       cmp bl,star202Y
       jne check203
       inc score
       mov star202X,0
       mov star202Y,0

    check203:
        mov bl,xPos
       cmp bl,star203X
       jne check204
       mov bl,yPos
       cmp bl,star203Y
       jne check204
       inc score
       mov star203X,0
       mov star203Y,0

    check204:
        mov bl,xPos
       cmp bl,star204X
       jne check205
       mov bl,yPos
       cmp bl,star204Y
       jne check205
       inc score
       mov star204X,0
       mov star204Y,0

    check205:
        mov bl,xPos
       cmp bl,star205X
       jne check206
       mov bl,yPos
       cmp bl,star205Y
       jne check206
       inc score
       mov star205X,0
       mov star205Y,0

    check206:
        mov bl,xPos
       cmp bl,star206X
       jne check207
       mov bl,yPos
       cmp bl,star206Y
       jne check207
       inc score
       mov star206X,0
       mov star206Y,0

    check207:
        mov bl,xPos
       cmp bl,star207X
       jne check208
       mov bl,yPos
       cmp bl,star207Y
       jne check208
       inc score
       mov star207X,0
       mov star207Y,0

    check208:
        mov bl,xPos
       cmp bl,star208X
       jne check209
       mov bl,yPos
       cmp bl,star208Y
       jne check209
       inc score
       mov star208X,0
       mov star208Y,0

    check209:
        mov bl,xPos
       cmp bl,star209X
       jne check210
       mov bl,yPos
       cmp bl,star209Y
       jne check210
       inc score
       mov star209X,0
       mov star209Y,0

    check210:
        mov bl,xPos
       cmp bl,star210X
       jne check211
       mov bl,yPos
       cmp bl,star210Y
       jne check211
       inc score
       mov star210X,0
       mov star210Y,0

    check211:
        mov bl,xPos
       cmp bl,star211X
       jne check212
       mov bl,yPos
       cmp bl,star211Y
       jne check212
       add score,5
       mov star211X,0
       mov star211Y,0

    check212:
        mov bl,xPos
       cmp bl,star212X
       jne check213
       mov bl,yPos
       cmp bl,star212Y
       jne check213
       inc score
       mov star212X,0
       mov star212Y,0

    check213:
        mov bl,xPos
       cmp bl,star213X
       jne check214
       mov bl,yPos
       cmp bl,star213Y
       jne check214
       inc score
       mov star213X,0
       mov star213Y,0

    check214:
        mov bl,xPos
       cmp bl,star214X
       jne check215
       mov bl,yPos
       cmp bl,star214Y
       jne check215
       inc score
       mov star214X,0
       mov star214Y,0

    check215:
        mov bl,xPos
       cmp bl,star215X
       jne check216
       mov bl,yPos
       cmp bl,star215Y
       jne check216
       inc score
       mov star215X,0
       mov star215Y,0

    check216:
        mov bl,xPos
       cmp bl,star216X
       jne check217
       mov bl,yPos
       cmp bl,star216Y
       jne check217
       inc score
       mov star216X,0
       mov star216Y,0

    check217:
        mov bl,xPos
       cmp bl,star217X
       jne check218
       mov bl,yPos
       cmp bl,star217Y
       jne check218
       inc score
       mov star217X,0
       mov star217Y,0

    check218:
        mov bl,xPos
       cmp bl,star218X
       jne check219
       mov bl,yPos
       cmp bl,star218Y
       jne check219
       inc score
       mov star218X,0
       mov star218Y,0

    check219:
        mov bl,xPos
       cmp bl,star219X
       jne check220
       mov bl,yPos
       cmp bl,star219Y
       jne check220
       inc score
       mov star219X,0
       mov star219Y,0

    check220:
        mov bl,xPos
       cmp bl,star220X
       jne check221
       mov bl,yPos
       cmp bl,star220Y
       jne check221
       inc score
       mov star220X,0
       mov star220Y,0

    check221:
        mov bl,xPos
       cmp bl,star221X
       jne check222
       mov bl,yPos
       cmp bl,star221Y
       jne check222
       inc score
       mov star221X,0
       mov star221Y,0

    check222:
        mov bl,xPos
       cmp bl,star222X
       jne check223
       mov bl,yPos
       cmp bl,star222Y
       jne check223
       inc score
       mov star222X,0
       mov star222Y,0

    check223:
        mov bl,xPos
       cmp bl,star223X
       jne check224
       mov bl,yPos
       cmp bl,star223Y
       jne check224
       inc score
       mov star223X,0
       mov star223Y,0

    check224:
        mov bl,xPos
       cmp bl,star224X
       jne check225
       mov bl,yPos
       cmp bl,star224Y
       jne check225
       inc score
       mov star224X,0
       mov star224Y,0

    check225:
        mov bl,xPos
       cmp bl,star225X
       jne check226
       mov bl,yPos
       cmp bl,star225Y
       jne check226
       inc score
       mov star225X,0
       mov star225Y,0

    check226:
        mov bl,xPos
       cmp bl,star226X
       jne check227
       mov bl,yPos
       cmp bl,star226Y
       jne check227
       inc score
       mov star226X,0
       mov star226Y,0

    check227:
        mov bl,xPos
       cmp bl,star227X
       jne check228
       mov bl,yPos
       cmp bl,star227Y
       jne check228
       inc score
       mov star227X,0
       mov star227Y,0

    check228:
        mov bl,xPos
       cmp bl,star228X
       jne check229
       mov bl,yPos
       cmp bl,star228Y
       jne check229
       inc score
       mov star228X,0
       mov star228Y,0

    check229:
        mov bl,xPos
       cmp bl,star229X
       jne check230
       mov bl,yPos
       cmp bl,star229Y
       jne check230
       inc score
       mov star229X,0
       mov star229Y,0

    check230:
        mov bl,xPos
       cmp bl,star230X
       jne check231
       mov bl,yPos
       cmp bl,star230Y
       jne check231
       inc score
       mov star230X,0
       mov star230Y,0

    check231:
        mov bl,xPos
       cmp bl,star231X
       jne check232
       mov bl,yPos
       cmp bl,star231Y
       jne check232
       inc score
       mov star231X,0
       mov star231Y,0

    check232:
        mov bl,xPos
       cmp bl,star232X
       jne check233
       mov bl,yPos
       cmp bl,star232Y
       jne check233
       inc score
       mov star232X,0
       mov star232Y,0

    check233:
        mov bl,xPos
       cmp bl,star233X
       jne check234
       mov bl,yPos
       cmp bl,star233Y
       jne check234
       inc score
       mov star233X,0
       mov star233Y,0

    check234:
        mov bl,xPos
       cmp bl,star234X
       jne check235
       mov bl,yPos
       cmp bl,star234Y
       jne check235
       inc score
       mov star234X,0
       mov star234Y,0

    check235:
        mov bl,xPos
       cmp bl,star235X
       jne check236
       mov bl,yPos
       cmp bl,star235Y
       jne check236
       inc score
       mov star235X,0
       mov star235Y,0

    check236:
        mov bl,xPos
       cmp bl,star236X
       jne check237
       mov bl,yPos
       cmp bl,star236Y
       jne check237
       inc score
       mov star236X,0
       mov star236Y,0

    check237:
        mov bl,xPos
       cmp bl,star237X
       jne check238
       mov bl,yPos
       cmp bl,star237Y
       jne check238
       inc score
       mov star237X,0
       mov star237Y,0

    check238:
        mov bl,xPos
       cmp bl,star238X
       jne check239
       mov bl,yPos
       cmp bl,star238Y
       jne check239
       inc score
       mov star238X,0
       mov star238Y,0

    check239:
        mov bl,xPos
       cmp bl,star239X
       jne check240
       mov bl,yPos
       cmp bl,star239Y
       jne check240
       inc score
       mov star239X,0
       mov star239Y,0

    check240:
        mov bl,xPos
       cmp bl,star240X
       jne check241
       mov bl,yPos
       cmp bl,star240Y
       jne check241
       inc score
       mov star240X,0
       mov star240Y,0

    check241:
        mov bl,xPos
       cmp bl,star241X
       jne check242
       mov bl,yPos
       cmp bl,star241Y
       jne check242
       inc score
       mov star241X,0
       mov star241Y,0

    check242:
       mov bl,xPos
       cmp bl,star242X
       jne check243
       mov bl,yPos
       cmp bl,star242Y
       jne check243
       inc score
       mov star242X,0
       mov star242Y,0

    check243:
        mov bl,xPos
       cmp bl,star243X
       jne check244
       mov bl,yPos
       cmp bl,star243Y
       jne check244
       inc score
       mov star243X,0
       mov star243Y,0

    check244:
        mov bl,xPos
       cmp bl,star244X
       jne check245
       mov bl,yPos
       cmp bl,star244Y
       jne check245
       inc score
       mov star244X,0
       mov star244Y,0

    check245:
        mov bl,xPos
       cmp bl,star245X
       jne check246
       mov bl,yPos
       cmp bl,star245Y
       jne check246
       inc score
       mov star245X,0
       mov star245Y,0

    check246:
        mov bl,xPos
       cmp bl,star246X
       jne check247
       mov bl,yPos
       cmp bl,star246Y
       jne check247
       inc score
       mov star246X,0
       mov star246Y,0

    check247:
        mov bl,xPos
       cmp bl,star247X
       jne check248
       mov bl,yPos
       cmp bl,star247Y
       jne check248
       add score,5
       mov star247X,0
       mov star247Y,0

    check248:
        mov bl,xPos
       cmp bl,star248X
       jne check249
       mov bl,yPos
       cmp bl,star248Y
       jne check249
       inc score
       mov star248X,0
       mov star248Y,0

    check249:
        mov bl,xPos
       cmp bl,star249X
       jne notCollecting3
       mov bl,yPos
       cmp bl,star249Y
       jne notCollecting3
       inc score
       mov star249X,0
       mov star249Y,0

        notCollecting3:

        mov eax,white (black * 16)
        call SetTextColor

        mov dl,57
        mov dh,0
        call Gotoxy
        mov edx,OFFSET stdLives
        call WriteString
        mov eax,0
        mov al,lives
        call WriteInt
        cmp lives,0
        je exitGame

        mov dl,110
        mov dh,0
        call Gotoxy
        mov edx,OFFSET stdLevel
        call WriteString
        mov eax,0
        mov al,levelcount
        call WriteInt

        ; draw score:
        mov dl,0
        mov dh,0
        call Gotoxy
        mov edx,OFFSET strScore
        call WriteString
        mov eax,0
        mov al,score
        cmp score,164
        je exitGame
        call WriteInt

        call TeleportHorizontal1
        call TeleportHorizontal2
        call TeleportHorizontal3
        call TeleportHorizontal4

        ; gravity logic:
        gravity3:
        cmp yPos,0
        jg onGround3
        ; make player fall:
        call UpdatePlayer
        inc yPos
        call DrawPlayer
        mov eax,80
        call Delay
        jmp gravity3
        onGround3:

        ; get user key input:
        inc key
        cmp key,200
        jne directionchange3
        mov key,0
        ; get user key input:
        call ReadKey
        jz takeInput
        mov inputChar,al
takeInput:

        cmp inputChar,"r"
        je Gamepaused3

        ; exit game if user types 'x':
        cmp inputChar,"x"
        je exitGame

        cmp inputChar,"w"
        je moveUp3

        cmp inputChar,"s"
        je moveDown3

        cmp inputChar,"a"
        je moveLeft3

        cmp inputChar,"d"
        je moveRight3

     Gamepaused3:
        jmp pauseGame

     moveUp3:

        cmp yPos,2
        je gameLoop3

        mov bl,xPos
        mov bh,yPos
        dec bh
        mov line1bool,0

        call line60
        cmp line1bool,1
        je directionchange3

        call line61
        cmp line1bool,1
        je  directionchange3

        call line62
        cmp line1bool,1
        je  directionchange3

        call line63
        cmp line1bool,1
        je  directionchange3

        call line64
        cmp line1bool,1
        je  directionchange3

        call line65
        cmp line1bool,1
        je  directionchange3

        call line66
        cmp line1bool,1
        je  directionchange3

        call line67
        cmp line1bool,1
        je  directionchange3

        call line68
        cmp line1bool,1
        je  directionchange3

        call line69
        cmp line1bool,1
        je  directionchange3

        call line70
        cmp line1bool,1
        je  directionchange3

        call line71
        cmp line1bool,1
        je  directionchange3

        call line72
        cmp line1bool,1
        je  directionchange3

        call UpdatePlayer
        dec yPos
        call DrawPlayer
        jmp gameLoop3

    moveDown3:

        cmp yPos,28
        je gameLoop3

        mov bl,xPos
        mov bh,yPos
        inc bh
        mov line1bool,0

        call line60
        cmp line1bool,1
        je  directionchange2

        call line61
        cmp line1bool,1
        je  directionchange3

        call line62
        cmp line1bool,1
        je  directionchange3

        call line63
        cmp line1bool,1
        je  directionchange3

        call line64
        cmp line1bool,1
        je  directionchange3

        call line65
        cmp line1bool,1
        je  directionchange3

        call line66
        cmp line1bool,1
        je  directionchange3

        call line67
        cmp line1bool,1
        je  directionchange3

        call line68
        cmp line1bool,1
        je  directionchange3

        call line69
        cmp line1bool,1
        je  directionchange3

        call line70
        cmp line1bool,1
        je  directionchange3

        call line71
        cmp line1bool,1
        je  directionchange3

        call line72
        cmp line1bool,1
        je  directionchange3

        call UpdatePlayer
        inc yPos
        call DrawPlayer
        jmp gameLoop3

     moveLeft3:

        cmp xPos,1
        je gameLoop3

        mov bl,xPos
        mov bh,yPos
        dec bl
        mov line1bool,0

        call line60
        cmp line1bool,1
        je  directionchange3
        
        call line61
        cmp line1bool,1
        je  directionchange3

        call line62
        cmp line1bool,1
        je  directionchange3

        call line63
        cmp line1bool,1
        je  directionchange3

        call line64
        cmp line1bool,1
        je  directionchange3

        call line65
        cmp line1bool,1
        je  directionchange3

        call line66
        cmp line1bool,1
        je  directionchange3

        call line67
        cmp line1bool,1
        je  directionchange3

        call line68
        cmp line1bool,1
        je  directionchange3

        call line69
        cmp line1bool,1
        je  directionchange3

        call line70
        cmp line1bool,1
        je  directionchange3

        call line71
        cmp line1bool,1
        je  directionchange3

        call line72
        cmp line1bool,1
        je  directionchange3

        call UpdatePlayer
        dec xPos
        call DrawPlayer
        jmp gameLoop3

    moveRight3:

        cmp xPos,118
        je gameLoop2

        mov bl,xPos
        mov bh,yPos
        inc bl
        mov line1bool,0

        call line60
        cmp line1bool,1
        je  directionchange3

        call line61
        cmp line1bool,1
        je  directionchange3
        
        call line62
        cmp line1bool,1
        je  directionchange3

        call line63
        cmp line1bool,1
        je  directionchange3

        call line64
        cmp line1bool,1
        je  directionchange3

        call line65
        cmp line1bool,1
        je  directionchange3

        call line66
        cmp line1bool,1
        je  directionchange3

        call line67
        cmp line1bool,1
        je  directionchange3

        call line68
        cmp line1bool,1
        je  directionchange3

        call line69
        cmp line1bool,1
        je  directionchange3

        call line70
        cmp line1bool,1
        je  directionchange3

        call line71
        cmp line1bool,1
        je  directionchange3

        call line72
        cmp line1bool,1
        je  directionchange3

        call UpdatePlayer
        inc xPos
        call DrawPlayer
        jmp gameLoop3

directionchange3:
        jmp gameLoop3

exitGame:
    INVOKE PlaySound, OFFSET GhostSound, NULL, 0h
     mov eax,200
     call delay
    mov eax,yellow (brown*16)
    call SetTextColor
    call clrscr

    mov dl,56
    mov dh,3
    call Gotoxy
    mov edx,OFFSET endGame
    call WriteString

    mov edx,OFFSET filename
    call OpenInputFile

    mov fileHandle,eax
    cmp eax,INVALID_HANDLE_VALUE 
    jne OK
    mov edx,OFFSET cantOpen
    call writestring
    jmp s1
OK:
    mov edx,OFFSET buffer
    mov ecx,BUFFER_SIZE
    call ReadFromFile
    jnc OK1
    mov edx,OFFSET notOpen
    call writestring
    jmp close_file
OK1:
   mov buffer[eax],0
   mov dl,55
   mov dh,15  
   call Gotoxy
   mov edx,offset output
   call writestring
   mov edx, OFFSET buffer
   call WriteString
   call Crlf
close_file:
   mov eax,fileHandle
   call CloseFile
s1:
    mov dl,52
    mov dh,16
    call Gotoxy
    mov edx,OFFSET scoreShow
    call WriteString
    mov eax,0
    mov al,score
    call writeInt
ended:
    exit
main ENDP
END main