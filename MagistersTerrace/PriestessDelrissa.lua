﻿------------------------------
--      Are you local?      --
------------------------------

local boss = BB["Priestess Delrissa"]
local L = AceLibrary("AceLocale-2.2"):new("BigWigs"..boss)

local db = nil
local fmt = string.format

----------------------------
--      Localization      --
----------------------------

L:RegisterTranslations("enUS", function() return {
	cmd = "Delrissa",

	pri_flashheal = "Priestess Delrissa - Flash Heal",
	pri_flashheal_desc = "Warn for casting heals",
	pri_flashheal_message = "Priestess Healing!",
	pri_shield = "Priestess Delrissa - Power Word: Shield",
	pri_shield_desc = "Warn for application of Power Word: Shield",
	pri_shield_message = "Power Word: Shield on %s!",

	Apoko = "Apoko", --need the add name translated, maybe we'll add it to BabbleBoss
	apoko_lhw = "Apoko - Lesser Healing Wave",
	apoko_lhw_desc = "Warn for casting heals",
	apoko_lhw_message = "Apoko Healing!",
	apoko_wf = "Apoki - Windfury Totem",
	apoko_wf_desc = "",
	apoko_wf_message = "",

	Ellyrs = "Ellrys Duskhallow", --need the add name translated, maybe we'll add it to BabbleBoss
	ellrys_soc = "Ellrys - Seed of Corruption",
	ellrys_soc_desc = "",
	ellrys_soc_message = "",

	Yazzai = "Yazzai", --need the add name translated, maybe we'll add it to BabbleBoss
	yazzai_bliz = "Yazzai - Blizzard",
	yazzai_bliz_desc = "",
	yazzai_bliz_message = "",
	yazzai_poly = "Yazzai - Polymorph",
	yazzai_poly_desc = "",
	yazzai_poly_message = "",
} end )

--[[
	Magister's Terrace modules are PTR beta, as so localization is not
	supported in any way. This gives the authors the freedom to change the
	modules in way that	can potentially break localization.  Feel free to
	localize, just be aware that you may need to change it frequently.
]]--

----------------------------------
--      Module Declaration      --
----------------------------------

local mod = BigWigs:NewModule(boss)
mod.partyContent = true
mod.zonename = BZ["Magisters' Terrace"]
mod.enabletrigger = boss 
mod.toggleoptions = {"bosskill"}
mod.revision = tonumber(("$Revision$"):sub(12, -3))

------------------------------
--      Initialization      --
------------------------------

function mod:OnEnable()
	self:AddCombatListener("UNIT_DIED", "GenericBossDeath")
	self:AddCombatListener("SPELL_AURA_APPLIED", "PriShield", "44291")
	self:AddCombatListener("SPELL_CAST_START", "PriHeal", "17843")
	self:AddCombatListener("SPELL_CAST_START", "ApokoHeal", "44256")
	self:AddCombatListener("SPELL_CAST_SUCCESS", "ApokoWF", "27621")
	self:AddCombatListener("SPELL_AURA_APPLIED", "EllrysSoC", "44141")
	--self:AddCombatListener("SPELL_AURA_APPLIED", "YazzaiPoly", "#####")
	--self:AddCombatListener("SPELL_CAST_START", "YazzaiBliz", "#####")

	self:RegisterEvent("PLAYER_REGEN_ENABLED", "CheckForWipe")	

	db = self.db.profile
end

------------------------------
--      Event Handlers      --
------------------------------

function mod:PriShield(player)
	if db.pri_shield and source == boss then
		self:Message(fmt(L["pri_shield_message"], player), "Attention", nil, nil, nil, 44291)
	end
end

-- 
function mod:PriHeal(source)
	if db.pri_heal and source == boss then
		self:Message(L["pri_heal_message"], "Attention", nil, nil, nil, 17843)
	end
end

function mod:ApokoHeal(source)
	if db.apoko_heal and source == L["Apoko"] then
		self:Message(L["apoko_heal_message"], "Attention", nil, nil, nil, 44256)
	end	
end

function mod:ApokoWF(source)
end

function mod:EllrysSoC(player, spellId)
end

--[[function mod:YazzaiPoly(player, spellId)
end

function mod:YazzaiBliz(source)
end]]--
