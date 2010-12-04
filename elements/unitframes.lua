local F, C, L = unpack(select(2, ...))
local oUF = select(2, ...).oUF

local oUF_colors = setmetatable({
	tapped = {0.55, 0.57, 0.61},
	disconnected = {0.84, 0.75, 0.65},
	power = setmetatable({
		["MANA"] = {0.31, 0.45, 0.63},
		["RAGE"] = {0.69, 0.31, 0.31},
		["FOCUS"] = {0.71, 0.43, 0.27},
		["ENERGY"] = {0.65, 0.63, 0.35},
		["RUNES"] = {0.55, 0.57, 0.61},
		["RUNIC_POWER"] = {0, 0.82, 1},
		["AMMOSLOT"] = {0.8, 0.6, 0},
		["FUEL"] = {0, 0.55, 0.5},
		["POWER_TYPE_STEAM"] = {0.55, 0.57, 0.61},
		["POWER_TYPE_PYRITE"] = {0.60, 0.09, 0.17},
	}, {__index = oUF.colors.power}),
	happiness = setmetatable({
		[1] = {.69,.31,.31},
		[2] = {.65,.63,.35},
		[3] = {.33,.59,.33},
	}, {__index = oUF.colors.happiness}),
	runes = setmetatable({
			[1] = {.69,.31,.31},
			[2] = {.33,.59,.33},
			[3] = {.31,.45,.63},
			[4] = {.84,.75,.65},
	}, {__index = oUF.colors.runes}),
	reaction = setmetatable({
		[1] = { 222/255, 95/255,  95/255 }, -- Hated
		[2] = { 222/255, 95/255,  95/255 }, -- Hostile
		[3] = { 222/255, 95/255,  95/255 }, -- Unfriendly
		[4] = { 218/255, 197/255, 92/255 }, -- Neutral
		[5] = { 75/255,  175/255, 76/255 }, -- Friendly
		[6] = { 75/255,  175/255, 76/255 }, -- Honored
		[7] = { 75/255,  175/255, 76/255 }, -- Revered
		[8] = { 75/255,  175/255, 76/255 }, -- Exalted	
	}, {__index = oUF.colors.reaction}),
	class = setmetatable({
		["DEATHKNIGHT"] = { 196/255,  30/255,  60/255 },
		["DRUID"]       = { 255/255, 125/255,  10/255 },
		["HUNTER"]      = { 171/255, 214/255, 116/255 },
		["MAGE"]        = { 104/255, 205/255, 255/255 },
		["PALADIN"]     = { 245/255, 140/255, 186/255 },
		["PRIEST"]      = { 212/255, 212/255, 212/255 },
		["ROGUE"]       = { 255/255, 243/255,  82/255 },
		["SHAMAN"]      = {  41/255,  79/255, 155/255 },
		["WARLOCK"]     = { 148/255, 130/255, 201/255 },
		["WARRIOR"]     = { 199/255, 156/255, 110/255 },
	}, {__index = oUF.colors.class}),
}, {__index = oUF.colors})

------------------------------------------------------------------------------
--	oUF_barebones
--	Bare minimum for getting an oUF layout up and running
------------------------------------------------------------------------------
--	credits:
--	Haste (oUF)
--		http://www.wowinterface.com/downloads/info9994-oUF.html
--	zork (oUF Tutorial)
--		http://www.wowinterface.com/forums/showthread.php?t=33566
------------------------------------------------------------------------------

--	configuration
local BAR_TEXTURE = "Interface\\TargetingFrame\\UI-StatusBar"
local BAR_WIDTH = 192
local HP_HEIGHT = 20
local PP_HEIGHT = 8
local BORDER = 4

local TEXT_FACE = "NumberFont_Shadow_Small"

------------------------------------------------------------------------------

-- generate the frames
local function CreateUnitFrame(self, unit)

	-- our colors
	self.colors = oUF_colors
	-- size the overall unit frame
	self:SetSize(BAR_WIDTH + 2 * BORDER, HP_HEIGHT + PP_HEIGHT + 3 * BORDER)

	local parent=CreateFrame("Frame", nil, self)
	parent:SetAllPoints()
	parent:SetFrameStrata"HIGH"

	-- create background
--	local unitBackground = self:CreateTexture(nil, "ARTWORK")
--	unitBackground:SetAllPoints(self)
--	unitBackground:SetTexture(0, 0, 0, 1)
	
	------------------------
	-- health bar
	------------------------
	local hpBar = CreateFrame("StatusBar", nil, self)
	hpBar:SetStatusBarTexture(BAR_TEXTURE)
	hpBar:SetSize(BAR_WIDTH, HP_HEIGHT)
	hpBar:SetPoint("TOP", parent, "TOP", 0, -BORDER)
	
	-- > see "oUF/elements/health.lua" for health bar coloring options
	hpBar.colorTapping = true
	hpBar.frequentUpdates = true
	hpBar.colorDisconnected = true
	hpBar.colorHappiness = true
	hpBar.colorClass = true
	hpBar.colorReaction = true
	hpBar.colorSmooth = true
--	hpBar.smoothGradient = {47/255, 107/255, 77/255}
--	hpBar.colorHealth = true
	hpBar.Smooth = true
	
	self.Health = hpBar

	local hpBarBG = hpBar:CreateTexture(nil, "BORDER")
	hpBarBG:SetAllPoints()
--	hpBarBG:SetAround()
	hpBarBG:SetTexture(1, 0, 0, .9)
	hpBarBG.multiplier = .5
	
	self.Health.bg = hpBarBG

	------------------------
	-- power bar
	------------------------
	local ppBar = CreateFrame("StatusBar", nil, self)
	ppBar:SetStatusBarTexture(BAR_TEXTURE)
	ppBar:SetSize(BAR_WIDTH, PP_HEIGHT)
	ppBar:SetPoint("TOP", hpBar, "BOTTOM", 0, -BORDER)
	
	-- > see "oUF/elements/power.lua" for power bar coloring options
	ppBar.frequentUpdates = true
	ppBar.colorPower = true
	
	self.Power = ppBar

	
	------------------------
	-- unit health text
	------------------------
	local hpText = hpBar:CreateFontString(nil, "Overlay")
	hpText:SetFontObject(TEXT_FACE)
	hpText:SetJustifyH("RIGHT")
	hpText:SetPoint("RIGHT", hpBar, "RIGHT", -4, 0)
	
	-- > "see oUF/elements/tags.lua" for provided tags
	self:Tag(hpText, "[status] [curhp]/[maxhp]")
	
	------------------------
	-- unit name text
	------------------------
--	local Name
	if unit~="player" then
	local Name = hpBar:CreateFontString(nil, "Overlay")
	Name:SetFontObject(TEXT_FACE)
	Name:SetJustifyH("LEFT")
	Name:SetPoint("LEFT", hpBar, "LEFT", 4, 0)
	
	-- > see "oUF/elements/tags.lua" for provided tags
	self:Tag(Name, "[smartlevel] [name]")
	-- allow the name to be cut off with "..." if it's too long
	Name:SetPoint("RIGHT", hpText, "LEFT", 0, 0)
	end
	

	

	
end

------------------------------------------------------------------------------

oUF:RegisterStyle("oUF_barebones", CreateUnitFrame)

oUF:SetActiveStyle("oUF_barebones")

-- spawn and then position the player frame
local player = oUF:Spawn("player", "oUF_player")
player:SetPoint("CENTER", UIParent, "CENTER", -192, -192)

-- spawn and then position the target frame
local target = oUF:Spawn("target", "oUF_target")
target:SetPoint("CENTER", UIParent, "CENTER", 192, -192)


