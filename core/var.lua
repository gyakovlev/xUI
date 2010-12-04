local F, C, L = unpack(select(2, ...))

C.class = select(2, UnitClass("player"))
C.r, C.g, C.b = RAID_CLASS_COLORS[C.class].r, RAID_CLASS_COLORS[C.class].g, RAID_CLASS_COLORS[C.class].b
C.a = 0.8
DEB=C
