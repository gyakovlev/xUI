local F, C, L = unpack(select(2, ...))

C.uiscale = .64
C.border = {.6, .6, .6, 1}
C.bg = {0, 0, 0, .6}

C.buffs = {}
C.buffs.size = 40
C.buffs.numinrow = 16 -- 2..64

C.media = {}
C.media.solid = [[Interface\AddOns\xUI\media\solid]]
C.media.pxfont = [[Interface\AddOns\xUI\media\pixelfont.ttf]]
