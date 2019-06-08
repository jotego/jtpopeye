#!/usr/bin/python
# Message in the pause menu
import os

ascii_conv = {
    '0':0, '1':1, '2':2,   '3':3,   '4':4,   '5':5,   '6':6,   '7':7,
    '8':8, '9':9, 'a':0xa, 'b':0xb, 'c':0xc, 'd':0xd, 'e':0xe, 'f':0xf,
    'g':0x10, 'h':0x11, 'i':0x12, 'j':0x13, 'k':0x14, 'l':0x15, 'm':0x16, 'n':0x17, 
    'o':0x18, 'p':0x19, 'q':0x1a, 'r':0x1b, 's':0x1c, 't':0x1d, 'u':0x1e, 'v':0x1f,
    
    'w':0x20, 'x':0x21, 'y':0x22, 'z':0x23, '/':0x24, ',':0x25, '.':0x26, '*':0x27,
              ' ':0x29, '=':0x2a, '#':0x2b, '?':0x2c, ':':0x2d, '!':0x2e, "'":0x2f,

    '"':0x31
}

char_ram = [ 0x29 for x in range(0x400) ]
pos=0

def save_hex(filename, data):
    with open(filename,"w") as f:
        for k in data:
            f.write( "%X" % k )
            f.write( "\n" )
        f.close()

def save_bin(filename, data):
    with open(filename,"wb") as f:
        f.write( bytearray(data) )
        f.close()

def print_char( msg ):
    global pos
    for a in msg:
        char_ram[pos] = ascii_conv[a.lower()]
        pos = pos+1


#           00000000001111111111222222222233
#           01234567890123456789012345678901
print_char("                                ")
print_char("                                ")
print_char("    Popeye clone for fpga       ")
print_char("    brought to you by jotego.   ")
print_char("  http://patreon.com/topapate   ")
print_char("                                ")
print_char("       thanks to my patrons     ")
print_char("                                ")
print_char("  directors: scralings          ")
print_char("             suvodip mitra      ")
print_char("             Frederic Mahe      ")
print_char("                                ")
print_char("  Andrew Moore                  ")
print_char("  Andyways                      ")
print_char("  Brian Sallee                  ")
print_char("  Dave Ross                     ")
print_char("  Dustin Hubbard                ")
print_char("  Frederic Mahe                 ")
print_char("  Jo Tomiyori                   ")
print_char("  Leslie Law                    ")
print_char("  Oliver Jaksch                 ")
print_char("  Oscar Laguna Garcia           ")
print_char("  Phillip McMahon               ")
print_char("  Roman Buser                   ")
print_char("  Smoke Monster -YouTube!-      ")
print_char("  Steven Wilson                 ")
print_char("  Ultra robot ninja             ")
print_char("  Victor Gomariz L. de G.       ")
print_char("  Yasri                         ")
print_char("                                ")
print_char("                                ")

save_hex( "msg.hex", char_ram )
save_bin( "../ver/game/msg.bin", char_ram )
