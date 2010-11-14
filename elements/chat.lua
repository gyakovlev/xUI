local F, C, L = unpack(select(2, ...))

FriendsMicroButton:Die()
ChatFrameMenuButton:Die()

for i=1,NUM_CHAT_WINDOWS do
	local frame = _G[format("ChatFrame%s", i)]
	local id = frame:GetID()
	local chat = frame:GetName()
	local tab = _G[chat.."Tab"]
	local ebox = _G[chat.."EditBox"]
	
	_G[chat]:SetClampRectInsets(0,0,0,0)
	_G[chat]:SetFading(false)


	tab:SetAlpha(1)
	tab.SetAlpha = UIFrameFadeRemoveFrame
	
	ebox:SetAltArrowKeyMode(false)
	
	_G[chat.."TabText"]:Hide()
	tab:HookScript("OnEnter", function() _G[chat.."TabText"]:Show() end)
	tab:HookScript("OnLeave", function() _G[chat.."TabText"]:Hide() end)				
	_G[format("ChatFrame%sTabLeft", id)]:Die()
	_G[format("ChatFrame%sTabMiddle", id)]:Die()
	_G[format("ChatFrame%sTabRight", id)]:Die()
	_G[format("ChatFrame%sTabSelectedLeft", id)]:Die()
	_G[format("ChatFrame%sTabSelectedMiddle", id)]:Die()
	_G[format("ChatFrame%sTabSelectedRight", id)]:Die()
	_G[format("ChatFrame%sTabHighlightLeft", id)]:Die()
	_G[format("ChatFrame%sTabHighlightMiddle", id)]:Die()
	_G[format("ChatFrame%sTabHighlightRight", id)]:Die()
	_G[format("ChatFrame%sTabSelectedLeft", id)]:Die()
	_G[format("ChatFrame%sTabSelectedMiddle", id)]:Die()
	_G[format("ChatFrame%sTabSelectedRight", id)]:Die()

	_G[format("ChatFrame%sButtonFrameUpButton", id)]:Die()
	_G[format("ChatFrame%sButtonFrameDownButton", id)]:Die()
	_G[format("ChatFrame%sButtonFrameBottomButton", id)]:Die()
	_G[format("ChatFrame%sButtonFrameMinimizeButton", id)]:Die()
	_G[format("ChatFrame%sButtonFrame", id)]:Die()

	_G[format("ChatFrame%sEditBoxFocusLeft", id)]:Die()
	_G[format("ChatFrame%sEditBoxFocusMid", id)]:Die()
	_G[format("ChatFrame%sEditBoxFocusRight", id)]:Die()
	
end

--	Enhance/rewrite a Blizzard feature, chatframe mousewheel.
local ScrollLines = 3 -- set the jump when a scroll is done !
function FloatingChatFrame_OnMouseScroll(self, delta)
	if delta < 0 then
		if IsShiftKeyDown() then
			self:ScrollToBottom()
		else
			for i = 1, ScrollLines do
				self:ScrollDown()
			end
		end
	elseif delta > 0 then
		if IsShiftKeyDown() then
			self:ScrollToTop()
		else
			for i = 1, ScrollLines do
				self:ScrollUp()
			end
		end
	end
end

