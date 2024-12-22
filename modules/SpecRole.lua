local _, private = ...
DBMExtraGlobal = {}

--[[local specFlags ={
	["Tank"] = true,
	["Dps"] = true,
	["Healer"] = true,
	["Melee"] = true,--ANY melee, including tanks or healers that are 100% exempt from healer/ranged mechanics
	["MeleeDps"] = true,
	["Physical"] = true,
	["Ranged"] = true,--ANY ranged, healer and dps included
	["RangedDps"] = true,--Only ranged dps
	["ManaUser"] = true,--Affected by things like mana drains, or mana detonation, etc
	["SpellCaster"] = true,--Has channeled casts, can be interrupted/spell locked by roars, etc, include healers. Use CasterDps if dealing with reflect
	["CasterDps"] = true,--Ranged dps that uses spells, relevant for spell reflect type abilities that only reflect spells but not ranged physical such as hunters
	["RaidCooldown"] = true,
	["RemovePoison"] = true,--from ally
	["RemoveDisease"] = true,--from ally
	["RemoveCurse"] = true,--from ally
	["RemoveMagic"] = true,--from ally
	["RemoveEnrage"] = true,--Can remove enemy enrage. returned in 8.x+!
	["MagicDispeller"] = true,--from ENEMY, not debuffs on players. use "Healer" or "RemoveMagic" for ally magic dispels. ALL healers can do that on retail, and warlock Imps
	["ImmunityDispeller"] = true,--Priest mass dispel or Warrior Shattering Throw (shadowlands)
	["HasInterrupt"] = true,--Has an interrupt that is 24 seconds or less CD that is BASELINE (not a talent)
	["HasImmunity"] = true,--Has an immunity that can prevent or remove a spell effect (not just one that reduces damage like turtle or dispursion)
	["TargetedCooldown"] = true,--Custom: Single Target external defensive cooldown
	["WeaponDependent"] = true--Custom: Specs that depend on weapon use
}]]

local specRoleTable

function DBMExtraGlobal:rebuildSpecTable()
	specRoleTable = {
		[62] = {	--Arcane Mage
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
			["MagicDispeller"] = true,
			["HasInterrupt"] = true,
			["HasImmunity"] = true,
			["RemoveCurse"] = true,
		},
		[1449] = {	--Initial Mage (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
		},
		[65] = {	--Holy Paladin
			["Healer"] = true,
			["Melee"] = true, -- Holy Paladins are Melee too, for Seal of Wisdom procs
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RaidCooldown"] = true,--Devotion Aura
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["RemoveMagic"] = true,
			["HasImmunity"] = true,
			["TargetedCooldown"] = true,--Hand of Sacrifice (and improved Lay on Hands)
		},
		[66] = {	--Protection Paladin
			["Tank"] = true,
			["Melee"] = true,
			["ManaUser"] = true,
			["Physical"] = true,
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["HasImmunity"] = true,
			["TargetedCooldown"] = true,--Hand of Sacrifice (and improved Lay on Hands)
			["WeaponDependent"] = true,
		},
		[70] = {	--Retribution Paladin
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["ManaUser"] = true,
			["Physical"] = true,
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["HasImmunity"] = true,
			["TargetedCooldown"] = true,--Hand of Sacrifice (and improved Lay on Hands)
			["WeaponDependent"] = true,
		},
		[1451] = {	--Initial Paladin (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Healer"] = true,
			["Tank"] = true,
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["ManaUser"] = true,
			["Physical"] = true,
			["SpellCaster"] = true,
		},
		[71] = {	--Arms Warrior
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["RaidCooldown"] = true,--Rallying Cry
			["Physical"] = true,
			["HasInterrupt"] = true,
			["ImmunityDispeller"] = IsSpellKnown(64382),
			["TargetedCooldown"] = true,--Intervene
			["WeaponDependent"] = true,
		},
		[73] = {	--Protection Warrior
			["Tank"] = true,
			["Melee"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
			["RaidCooldown"] = true,--Rallying Cry
			["ImmunityDispeller"] = IsSpellKnown(64382),
			["TargetedCooldown"] = true,--Intervene
		},
		[1446] = {	--Initial Warrior (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Tank"] = true,
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
		},
		[102] = {	--Balance Druid
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
			["RemoveCurse"] = true,
			["RemovePoison"] = true,
		},
		[103] = {	--Feral Druid
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["RemoveCurse"] = true,
			["RemovePoison"] = true,
		},
		[104] = {	--Guardian Druid
			["Tank"] = true,
			["Melee"] = true,
			["Physical"] = true,
			["RemoveCurse"] = true,
			["RemovePoison"] = true,
		},
		[105] = {	-- Restoration Druid
			["Healer"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RaidCooldown"] = true,--Tranquility
			["RemoveCurse"] = true,
			["RemovePoison"] = true,
			["RemoveMagic"] = true,
		},
		[1447] = {	-- Initial Druid (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Tank"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["Healer"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
		},
		[250] = {	--Blood DK
			["Tank"] = true,
			["Melee"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
			["WeaponDependent"] = true,
		},
		[251] = {	--Frost DK
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
			["WeaponDependent"] = true,
		},
		[1455] = {	--Initial DK (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Tank"] = true,
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
		},
		[253] = {	--Beastmaster Hunter
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["Physical"] = true,
			["MagicDispeller"] = true,
			["RemoveEnrage"] = true,
		},
		[254] = {	--Markmanship Hunter Hunter
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["Physical"] = true,
			["MagicDispeller"] = true,
			["RemoveEnrage"] = true,
		},
		[255] = {	--Survival Hunter (Legion+)
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["MagicDispeller"] = true,
			["RemoveEnrage"] = true,
		},
		[1448] = {	--Initial Hunter (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["Physical"] = true,
		},
		[256] = {	--Discipline Priest
			["Healer"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,--Iffy. Technically yes, but this can't be used to determine eligible target for dps only debuffs
			["RaidCooldown"] = true,--Power Word: Barrier(Discipline) / Divine Hymn (Holy)
			["RemoveDisease"] = true,
			["RemoveMagic"] = true,
			["MagicDispeller"] = true,
			["ImmunityDispeller"] = true,
			["TargetedCooldown"] = true,--Pain Suppression (Discipline) / Guardian Spirit (Holy)
		},
		[258] = {	--Shadow Priest
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
			["MagicDispeller"] = true,
			["ImmunityDispeller"] = true,
			["RemoveDisease"] = true,
		},
		[1452] = {	--Initial Priest (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Dps"] = true,
			["Healer"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
		},
		[259] = {	--Assassination Rogue
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
			["HasInterrupt"] = true,
			["HasImmunity"] = true,
			["WeaponDependent"] = true,
		},
		[1453] = {	--Initial Rogue (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Physical"] = true,
		},
		[262] = {	--Elemental Shaman
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["MagicDispeller"] = true,
			["HasInterrupt"] = true,
		},
		[263] = {	--Enhancement Shaman
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["Physical"] = true,
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["MagicDispeller"] = true,
			["HasInterrupt"] = true,
			["WeaponDependent"] = true,
		},
		[264] = {	--Restoration Shaman
			["Healer"] = true,
			["Ranged"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["RemoveCurse"] = true,--Cleanse Spirit (talent)
			["RemovePoison"] = true,
			["RemoveDisease"] = true,
			["MagicDispeller"] = true,
			["HasInterrupt"] = true,
		},
		[1444] = {	--Initial Shaman (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Healer"] = true,
			["Dps"] = true,
			["Melee"] = true,
			["MeleeDps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["Physical"] = true,
		},
		[265] = {	--Affliction Warlock
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
	--		["RemoveMagic"] = true,--Singe Magic (Imp)
			["CasterDps"] = true,
		},
		--[266] = {	--Demonology Warlock
		--	["Dps"] = true,
		--	["Ranged"] = true,
		--	["RangedDps"] = true,
		--	["ManaUser"] = true,
		--	["SpellCaster"] = true,
	--	--	["RemoveMagic"] = true,--Singe Magic (Imp)
		--	["CasterDps"] = true,
		--},
		--[267] = {	--Destruction Warlock
		--	["Dps"] = true,
		--	["Ranged"] = true,
		--	["RangedDps"] = true,
		--	["ManaUser"] = true,
		--	["SpellCaster"] = true,
	--	--	["RemoveMagic"] = true,--Singe Magic (Imp)
		--	["CasterDps"] = true,
		--},
		[1454] = {	--Initial Warlock (used in exiles reach tutorial mode). Treated as hybrid. Utility disabled because that'd require checking tutorial progress
			["Dps"] = true,
			["Ranged"] = true,
			["RangedDps"] = true,
			["ManaUser"] = true,
			["SpellCaster"] = true,
			["CasterDps"] = true,
		},
	}
	specRoleTable[63] = specRoleTable[62]--Frost Mage same as arcane
	specRoleTable[64] = specRoleTable[62]--Fire Mage same as arcane
	specRoleTable[72] = specRoleTable[71]--Fury Warrior same as Arms
	specRoleTable[252] = specRoleTable[251]--Unholy DK same as frost
	specRoleTable[257] = specRoleTable[256]--Holy Priest same as disc
	specRoleTable[260] = specRoleTable[259]--Combat Rogue same as Assassination
	specRoleTable[261] = specRoleTable[259]--Subtlety Rogue same as Assassination
	specRoleTable[266] = specRoleTable[265]--Demonology Warlock same as Affliction
	specRoleTable[267] = specRoleTable[265]--Destruction Warlock same as Affliction

	private.specRoleTable = specRoleTable
end
DBMExtraGlobal:rebuildSpecTable()--Initial build
