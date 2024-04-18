class_name DataManager
extends Node

func saveDict(dict, path = "user://settings.json"):
	var local_config = FileAccess.open(path, FileAccess.WRITE)
	local_config.store_line(JSON.stringify(dict))

func loadDict(path = "user://settings.json"):
	if not FileAccess.file_exists(path):
		return {}
	var local_config = FileAccess.open(path, FileAccess.READ)
	var result = JSON.parse_string(local_config.get_as_text())
	if result == null:
		return {}
	return result

