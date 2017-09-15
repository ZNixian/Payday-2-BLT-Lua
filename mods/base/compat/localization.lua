
-- Piggy-back off BLTLocalization's backwards compatibility
-- Just add a couple of missing functions, in case anyone used them.

function LuaModManager:IndexOfLocalisationCode( code )
	for index, loc_code in ipairs( LuaModManager._languages ) do
		if loc_code == code then
			return index
		end
	end
	return 1
end

function LuaModManager:IndexToLocalisationCode( index )
	return LuaModManager._languages[index] or "en"
end
