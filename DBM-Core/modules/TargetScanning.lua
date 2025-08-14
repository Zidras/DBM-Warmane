local _, private = ...

local twipe = table.wipe
local IsInGroup = private.IsInGroup
local UnitExists, UnitPlayerOrPetInRaid, UnitGUID =
	UnitExists, UnitPlayerOrPetInRaid, UnitGUID
local C_NamePlate = C_NamePlate -- https://github.com/FrostAtom/awesome_wotlk

local module = private:NewModule("TargetScanning")

--Traditional loop scanning method tables
local bossTargetuIds = {"boss1", "boss2", "boss3", "boss4", "boss5", "focus", "target", "mouseover"}
local fullUids = {
	"boss1", "boss2", "boss3", "boss4", "boss5",
	"mouseover", "target", "focus", "focustarget", "targettarget", "mouseovertarget",
	"party1target", "party2target", "party3target", "party4target"
}

-- Ajout des unités raid (1 à 40)
for i = 1, 40 do
	fullUids[#fullUids + 1] = "raid"..i.."target"
end

-- Ajout des nameplates si disponible
if C_NamePlate then
	for i = 1, 40 do
		fullUids[#fullUids + 1] = "nameplate"..i
	end
end

-- Traditional loop scanning method tables
local targetScanCount = {}
local filteredTargetCache = {}
local bossuIdCache = {}
--UNIT_TARGET scanning method table
local unitScanCount = 0
local unitMonitor = {}

local repeatedScanEnabled = {}

function module:OnModuleEnd()
	twipe(targetScanCount)
	twipe(filteredTargetCache)
	twipe(bossuIdCache)
	twipe(repeatedScanEnabled)
	unitScanCount = 0
	twipe(unitMonitor)
end

do
	local CL = DBM_COMMON_L

	local function getBossTarget(guid, scanOnlyBoss)
		local cacheuid = bossuIdCache[guid]
		-- Vérification optimisée du cache
		if cacheuid and UnitExists(cacheuid) and UnitGUID(cacheuid) == guid then
			local targetUnit = cacheuid.."target"
			if UnitExists(targetUnit) then
				local name = DBM:GetUnitFullName(targetUnit)
				return name, targetUnit, cacheuid
			end
		end

		-- Recherche dans les unités disponibles
		local usedTable = scanOnlyBoss and bossTargetuIds or fullUids
		for i = 1, #usedTable do
			local uId = usedTable[i]
			if UnitGUID(uId) == guid then
				bossuIdCache[guid] = uId
				local targetUnit = uId.."target"
				if UnitExists(targetUnit) then
					return DBM:GetUnitFullName(targetUnit), targetUnit, uId
				end
				break
			end
		end
	end

	function module:GetBossTarget(mod, cidOrGuid, scanOnlyBoss)
		local name, uid, bossuid
		DBM:Debug("GetBossTarget firing for :"..tostring(mod).." "..tostring(cidOrGuid).." "..tostring(scanOnlyBoss), 3)

		if type(cidOrGuid) == "number" then
			cidOrGuid = cidOrGuid or mod.creatureId
			local cacheuid = bossuIdCache[cidOrGuid] or "boss1"
			local cacheGuid = UnitGUID(cacheuid)

			if mod:GetUnitCreatureId(cacheuid) == cidOrGuid then
				bossuIdCache[cidOrGuid] = cacheuid
				if cacheGuid then
					bossuIdCache[cacheGuid] = cacheuid
				end
				name, uid, bossuid = getBossTarget(cacheGuid, scanOnlyBoss)
			else
				local usedTable = scanOnlyBoss and bossTargetuIds or fullUids
				for i = 1, #usedTable do
					local uId = usedTable[i]
					if mod:GetUnitCreatureId(uId) == cidOrGuid then
						bossuIdCache[cidOrGuid] = uId
						local unitGuid = UnitGUID(uId)
						if unitGuid then
							bossuIdCache[unitGuid] = uId
						end
						name, uid, bossuid = getBossTarget(unitGuid, scanOnlyBoss)
						break
					end
				end
			end
		else
			name, uid, bossuid = getBossTarget(cidOrGuid, scanOnlyBoss)
		end

		if uid then
			local cid = mod:GetUnitCreatureId(uid)
			if cid == 24207 or cid == 80258 or cid == 87519 then--Filter useless units, like "Army of the Dead", that would otherwise throw off the target scan
				return
			end
		end
		return name, uid, bossuid
	end

	function module:GetBossUnitByCreatureId(mod, cid)
		for i = 1, #bossTargetuIds do
			local uId = bossTargetuIds[i]
			if mod:GetUnitCreatureId(uId) == cid then
				return uId
			end
		end
		return "target"
	end

	function module:BossTargetScannerAbort(mod, cidOrGuid, returnFunc)
		targetScanCount[cidOrGuid] = nil--Reset count for later use.
		mod:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)
		DBM:Debug("Boss target scan for "..cidOrGuid.." should be aborting.", 2)
		filteredTargetCache[cidOrGuid] = nil
	end

	function module:BossTargetScanner(mod, cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, isFinalScan, targetFilter, tankFilter, onlyPlayers, filterFallback)
		cidOrGuid = cidOrGuid or mod.creatureId
		if not cidOrGuid then return end

		-- Initialisation du compteur
		if not targetScanCount[cidOrGuid] then
			targetScanCount[cidOrGuid] = 0
			DBM:Debug("Boss target scan started for "..cidOrGuid, 2)
		end
		targetScanCount[cidOrGuid] = targetScanCount[cidOrGuid] + 1
		--Set default values
		scanInterval = scanInterval or 0.05
		local inGroup = IsInGroup()
		scanTimes = scanTimes or (inGroup and 16 or 1)

		local targetname, targetuid, bossuid = self:GetBossTarget(mod, cidOrGuid, scanOnlyBoss)
		DBM:Debug("Boss target scan "..targetScanCount[cidOrGuid].." of "..scanTimes..", found target "..(targetname or "nil").." using "..(bossuid or "nil"), 3)--Doesn't hurt to keep this, as level 3

		-- Gestion du cache filtré
		if targetname and targetname ~= CL.UNKNOWN and filterFallback and targetFilter and targetFilter == targetname then
			filteredTargetCache[cidOrGuid] = {
				target = targetname,
				targetuid = targetuid
			}
		end

		-- Scan final avec cache filtré
		if filteredTargetCache[cidOrGuid] and isFinalScan then
			local cache = filteredTargetCache[cidOrGuid]
			targetScanCount[cidOrGuid] = nil
			mod:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)
			local scanningTime = (targetScanCount[cidOrGuid] or 1) * scanInterval
			mod[returnFunc](mod, cache.target, cache.targetuid, bossuid, scanningTime)
			DBM:Debug("BossTargetScanner has ended for "..cidOrGuid, 2)
			filteredTargetCache[cidOrGuid] = nil

		-- Scan normal
		elseif targetuid and targetname and targetname ~= CL.UNKNOWN and (isFinalScan or not targetFilter or (targetFilter and targetFilter ~= targetname)) then
			local isTanking = mod:IsTanking(targetuid, bossuid, nil, true)

			if (isEnemyScan and UnitIsFriend("player", targetuid)) or
			   (onlyPlayers and not UnitIsUnit("player", targetuid)) or
			   (isTanking and not isFinalScan) then

				if targetScanCount[cidOrGuid] < scanTimes then
					mod:ScheduleMethod(scanInterval, "BossTargetScanner", cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, nil, targetFilter, tankFilter, onlyPlayers, filterFallback)
				else
					self:BossTargetScanner(mod, cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, true, targetFilter, tankFilter, onlyPlayers, filterFallback)
				end
			else
				targetScanCount[cidOrGuid] = nil
				mod:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)
				if (tankFilter and isTanking) or (isFinalScan and isEnemyScan) or (onlyPlayers and not UnitIsUnit("player", targetuid)) then return end
				local scanningTime = (targetScanCount[cidOrGuid] or 1) * scanInterval
				mod[returnFunc](mod, targetname, targetuid, bossuid, scanningTime)
				DBM:Debug("BossTargetScanner has ended for "..cidOrGuid, 2)
				filteredTargetCache[cidOrGuid] = nil
			end
		else
			if targetScanCount[cidOrGuid] < scanTimes then
				mod:ScheduleMethod(scanInterval, "BossTargetScanner", cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, nil, targetFilter, tankFilter, onlyPlayers, filterFallback)
			elseif not isFinalScan then
				self:BossTargetScanner(mod, cidOrGuid, returnFunc, scanInterval, scanTimes, scanOnlyBoss, isEnemyScan, true, targetFilter, tankFilter, onlyPlayers, filterFallback)
			else
				targetScanCount[cidOrGuid] = nil
				mod:UnscheduleMethod("BossTargetScanner", cidOrGuid, returnFunc)
				filteredTargetCache[cidOrGuid] = nil
			end
		end
	end
end

do
	-- UNIT_TARGET Target scanning method
	local eventsRegistered = false

	-- Validation optimisée des cibles
	local function validateGroupTarget(unit)
		return not IsInGroup() or UnitPlayerOrPetInRaid(unit) or UnitPlayerOrPetInParty(unit)
	end

	function module:UNIT_TARGET_UNFILTERED(uId)
		-- Filtrage précoce
		if not unitMonitor[uId] then return end

		DBM:Debug("UNIT_TARGET_UNFILTERED fired for :"..uId, 3)
		local targetUnit = uId.."target"

		if UnitExists(targetUnit) and validateGroupTarget(targetUnit) then
			DBM:Debug("unitMonitor for this unit exists, target exists in group", 2)
			local modId, returnFunc = unitMonitor[uId].modid, unitMonitor[uId].returnFunc
			DBM:Debug("unitMonitor: "..modId..", "..uId..", "..returnFunc, 2)

			if not unitMonitor[uId].allowTank then
				local tanking, status = UnitDetailedThreatSituation(uId, targetUnit)
				if tanking or (status == 3) then
					DBM:Debug("unitMonitor ending for unit without 'allowTank', ignoring target", 2)
					return
				end
			end

			local mod = DBM:GetModByName(modId)
			DBM:Debug("unitMonitor success for this unit, a valid target for returnFunc", 2)
			mod[returnFunc](mod, DBM:GetUnitFullName(targetUnit), targetUnit, uId)
			unitMonitor[uId] = nil
			unitScanCount = unitScanCount - 1
		end

		if unitScanCount == 0 and eventsRegistered then
			eventsRegistered = false
			self:UnregisterShortTermEvents()
			DBM:Debug("All target scans complete, unregistering events", 2)
		end
	end

	function module:BossUnitTargetScannerAbort(mod, uId)
		if not uId then
			DBM:Debug("BossUnitTargetScannerAbort called without unit, clearing all unitMonitor units", 2)
			twipe(unitMonitor)
			unitScanCount = 0
			return
		end

		if unitMonitor[uId] then
			local targetUnit = uId.."target"
			-- Correction W211 : modId non utilisé, on utilise returnFunc directement
			local returnFunc = unitMonitor[uId].returnFunc
			if (unitMonitor[uId].allowTank or not IsInGroup()) and UnitExists(targetUnit) and validateGroupTarget(targetUnit) then
				DBM:Debug("unitMonitor unit exists, allowTank target exists", 2)
				mod[returnFunc](mod, DBM:GetUnitFullName(targetUnit), targetUnit, uId)
			end

			unitMonitor[uId] = nil
			unitScanCount = unitScanCount - 1
			DBM:Debug("Boss unit target scan should be aborting for "..uId, 2)
		end
	end

	function module:BossUnitTargetScanner(mod, uId, returnFunc, scanTime, allowTank)
		unitMonitor[uId] = {
			modid = mod.id,
			returnFunc = returnFunc,
			allowTank = allowTank
		}
		unitScanCount = unitScanCount + 1

		mod:ScheduleMethod(scanTime or 1.5, "BossUnitTargetScannerAbort", uId)

		if not eventsRegistered then
			eventsRegistered = true
			self:RegisterShortTermEvents("UNIT_TARGET_UNFILTERED")
			DBM:Debug("Registering UNIT_TARGET event for BossUnitTargetScanner", 2)
		end
	end
end

do
	-- Suppression de la déclaration locale pour résoudre W421
	-- Utilisation de la variable repeatedScanEnabled du scope parent

	-- Scanner répété optimisé
	local function repeatedScanner(params)
		if repeatedScanEnabled[params.returnFunc] then
			local targetname, targetuid, bossuid = module:GetBossTarget(params.mod, params.cidOrGuid, params.scanOnlyBoss)
			if targetname and (params.includeTank or not params.mod:IsTanking(targetuid, bossuid, nil, true)) then
				params.mod[params.returnFunc](params.mod, targetname, targetuid, bossuid)
			end
			params.mod:Schedule(params.scanInterval, repeatedScanner, params)
		end
	end

	function module:StartRepeatedScan(mod, cidOrGuid, returnFunc, scanInterval, scanOnlyBoss, includeTank)
		repeatedScanEnabled[returnFunc] = true
		repeatedScanner({
			mod = mod,
			cidOrGuid = cidOrGuid,
			returnFunc = returnFunc,
			scanInterval = scanInterval,
			scanOnlyBoss = scanOnlyBoss,
			includeTank = includeTank
		})
	end

	function module:StopRepeatedScan(returnFunc)
		repeatedScanEnabled[returnFunc] = nil
	end
end