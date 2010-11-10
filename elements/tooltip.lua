GameTooltip:HookScript("OnShow",function(self)if InCombatLockdown()then self:Hide()else self:SetTemplate()end end)
GameTooltipStatusBar:SetScript("OnShow",function(self)self:Die()end)
hooksecurefunc("GameTooltip_SetDefaultAnchor",function(self,parent)self:SetOwner(parent,"ANCHOR_CURSOR")self.default=1 end)
