local _, private = ...

local ipairs = ipairs

local GetNumPartyMembers = GetNumPartyMembers
local GetNumRaidMembers = GetNumRaidMembers

local function tIndexOf(tbl, item)
	for i, v in ipairs(tbl) do
		if item == v then
			return i;
		end
	end
end
private.tIndexOf = tIndexOf

local function IsInGroup()
	return GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0
end
private.IsInGroup = IsInGroup

local function IsInRaid()
	return GetNumRaidMembers() > 0
end
private.IsInRaid = IsInRaid

local function GetNumSubgroupMembers()
	return GetNumPartyMembers()
end
private.GetNumSubgroupMembers = GetNumSubgroupMembers

local function GetNumGroupMembers()
	return IsInRaid() and GetNumRaidMembers() or GetNumPartyMembers()
end
private.GetNumGroupMembers = GetNumGroupMembers
