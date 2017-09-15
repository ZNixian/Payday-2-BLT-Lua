
-- Compat functions
local dofile = function(path)
	dofile("mods/base/compat/" .. path)
end

local modern = _GG.BLT
local function port(to, from)
	from = from or to

	BLTBase[to] = function(...)
		return modern[from](...)
	end
end

-- Localise globals
local _G = _G
local io = io
local file = file
_G.BLTBase = {}

BLTBase.dofile = dofile

-- Load Mod Manager
dofile("lua_mod_manager.lua")
local C = LuaModManager.Constants

-- Set logs and saves paths
rawset(_G, C.logs_path_global, C.mods_directory .. C.logs_directory)
rawset(_G, C.save_path_global, C.mods_directory .. C.saves_directory)

-- BLT base functions
function BLTBase:Initialize()

	-- Run initialization
	LuaModManager.Mods, LuaModManager._mods_by_name = self:FindMods()

end

port("GetOS")

function BLTBase:FindMods()

	local list = modern.Mods:Mods()
	local mods_list = {}
	local by_name = {}

	for _, candidate in ipairs( list ) do
		-- TODO use compat only when it's set to run on BLT1, not a earlier version of BLT2
		if candidate:IsOutdated() then
			local data = {
				path = candidate.path,
				definition = candidate.json_data,
				priority = candidate.priority,
				id = candidate.id,
				modern = candidate,
			}
			table.insert( mods_list, data )

			if by_name[id] then error("Cannot load duplicate mod " .. id) end
			by_name[candidate.id] = data
		end
	end

	-- Prioritize
	table.sort( mods_list, function(a, b)
		return a.priority > b.priority
	end)

	return mods_list, by_name

end

-- Initialize called from the parent mod
