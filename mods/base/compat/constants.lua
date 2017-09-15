local C = {}
LuaModManager.Constants = C

C.mods_directory = "mods/"
C.lua_base_directory = "base/"
C.logs_directory = "logs/"
C.downloads_directory = "downloads/"
C.saves_directory = "saves/"
C.json_modules = {
	"req/json-1.0.lua",
	"req/json-0.9.lua",
	"req/json.lua"
}
C.mod_manager_file = "mod_manager.txt"
C.mod_keybinds_file = "mod_keybinds.txt"
C.mod_updates_file = "mod_updates.txt"
C.mod_required_file = "mod_required.txt"

C.excluded_mods_directories = {
	["logs"] = true,
	["saves"] = true,
	["downloads"] = true,
}

C.always_active_mods = {
	["mods/base/"] = true,
	["mods/logs/"] = true,
	["mods/saves/"] = true,
}

C.required_script_global = "RequiredScript"
C.mod_path_global = "ModPath"
C.logs_path_global = "LogsPath"
C.save_path_global = "SavePath"

C.mod_definition_file = "mod.txt"
C.mod_name_key = "name"
C.mod_desc_key = "description"
C.mod_version_key = "version"
C.mod_author_key = "author"
C.mod_contact_key = "contact"
C.mod_hooks_key = "hooks"
C.mod_prehooks_key = "pre_hooks"
C.mod_persists_key = "persist_scripts"
C.mod_hook_id_key = "hook_id"
C.mod_script_path_key = "script_path"
C.mod_persists_global_key = "global"
C.mod_persists_path_key = "path"
C.mod_hook_wildcard_key = "*"

C.mod_keybinds_key = "keybinds"
C.mod_keybind_id_key = "keybind_id"
C.mod_keybind_name_key = "name"
C.mod_keybind_desc_key = "description"
C.mod_keybind_script_key = "script_path"
C.mod_keybind_path_key = "path"
C.mod_keybind_scope_menu_key = "run_in_menu"
C.mod_keybind_scope_game_key = "run_in_game"
C.mod_keybind_callback_key = "callback"
C.mod_keybind_localize_key = "localized"

C.mod_update_key = "updates"
C.mod_update_revision_key = "revision"
C.mod_update_identifier_key = "identifier"
C.mod_update_install_key = "install_dir"
C.mod_update_install_folder_key = "install_folder"
C.mod_update_name_key = "display_name"

C.mod_libs_key = "libraries"
C.mod_libs_identifier_key = "identifier"
C.mod_libs_display_name_key = "display_name"
C.mod_libs_optional_key = "optional"

C.hook_dll_id = "payday2bltdll"
C.hook_dll_name = "IPHLPAPI.dll"
C.hook_dll_temp_name = "IPHLPAPI_temp.dll"
