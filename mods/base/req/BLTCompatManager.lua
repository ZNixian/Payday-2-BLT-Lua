
BLTCompatManager = BLTCompatManager or blt_class( BLTModule )
BLTCompatManager.__type = "BLTCompatManager"

function BLTCompatManager:init()
	local LuaModManager = {}
	self.lmm = LuaModManager

	-- Set up the old save and log path globals, in case any misbehaving modern
	-- mods use this. (*cough WolfHUD *cough)
	-- TODO: Add log-of-shame when these are accessed.
	local C = BLT.Mods.Constants
	rawset(_G, C.logs_path_global, C.mods_directory .. C.logs_directory)
	rawset(_G, C.save_path_global, C.mods_directory .. C.saves_directory)

	if not vm then
		-- Some backwards compatibility for v1 mods
		_G.LuaModManager = LuaModManager
		LuaModManager.Constants = C
		LuaModManager.Mods = {} -- No mods are available via old api

		log("No VM table - cannot loadfile - compatibility disabled.")
		return
	end

	self._compatible = true

	-- Set up a sandbox to run it in
	self._env = {}

	self._env._G = self._env -- Everything uses _G, so keep it inside
	self._env._GG = _G -- Allow mods to access the outside world if they *really* want to (and for the virtual hook)
	self._env.dofile = function(...)
		self:Load(...)
	end
	self._env.LuaModManager = LuaModManager

	setmetatable(self._env, {
		__index = _G
	})

	-- Load in the old version of the script
	self:Load("mods/base/compat/base.lua")
end

function BLTCompatManager:ModsLoaded()
	if not self:IsEnabled() then return end

	-- Perform startup
	self._env.BLTBase:Initialize()
end

function BLTCompatManager:IsEnabled()
	return self._compatible or false
end

function BLTCompatManager:LuaModManager()
	return self.lmm
end

function BLTCompatManager:Load(path, ...)
	if not self:IsEnabled() then error("[COMPAT] Cannot load " .. path .. " while disabled!") end

	local func = assert(vm.loadfile(path))
	setfenv(func, self._env)

	return func(...)
end

