
-- LuaModManager is set up as a table for us

-- Load any other compatibility layers we're using:
BLTBase.dofile("localization.lua")

-- Set up constants
BLTBase.dofile("constants.lua")
local C = LuaModManager.Constants

-- In case anyone uses these - we don't.
LuaModManager._base_path = C.mods_directory .. C.lua_base_directory
LuaModManager._save_path = C.mods_directory .. C.saves_directory

-- Loaded in base.lua:
-- _mods_by_name

local function clone( o )
	local res = {}
	for k, v in pairs( o ) do
		res[k] = v
	end
	setmetatable( res, getmetatable(o) )
	return res
end

function LuaModManager:GetMod( mod_path )
	if self.Mods then
		for k, v in pairs( self.Mods ) do
			if v.path == mod_path then
				return v
			end
		end
	end
end

function LuaModManager:WasModEnabledAtLoadTime( id )
	return _mods_by_name[id].modern:WasEnabledAtStart()
end

function LuaModManager:IsModEnabled( mod_name )
	return _mods_by_name[id].modern:IsEnabled()
end

function LuaModManager:HasModFromIdentifier(identifier)
	for k, v in pairs(_mods) do
		local updates = v.definition[C.mod_update_key]
		if updates then
			for i, update in pairs(updates) do
				if update[C.mod_update_identifier_key] == identifier then
					return true
				end
			end
		end
	end
	return false
end

function LuaModManager:SaveTableToJson( tbl, file_path )

	local count = 0
	for k, v in pairs( tbl ) do
		count = count + 1
	end

	if tbl and count > 0 then

		local file = io.open(file_path, "w+")
		if file then
			file:write( json.encode( tbl ) )
			file:close()
		else
			log("[Error] Could not save to file '" .. file_path .. "', data may be lost!")
		end

	else
		log("[Warning] Attempting to save empty data table '" .. file_path .. "', skipping...")
	end

end

function LuaModManager:LoadJsonFileToTable( file_path )

	local file = io.open( file_path, "r" )
	if file then

		local file_contents = file:read("*all")
		local mod_manager_data = json.decode(file_contents)
		file:close()
		return mod_manager_data

	else
		log("[Warning] Could not load file '" .. file_path .. "', no data loaded...")
	end
	return nil

end
