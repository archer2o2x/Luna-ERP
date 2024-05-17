extends Node

@onready var DataManagerObj = $".." as DataManager
var dataPath = ""

func _ready():
	dataPath = DataManagerObj.loadDict()["dataPath"]
	var machines = loadMachines();
	for machine in machines:
		pass

func loadMachines():
	var dir = DirAccess.open(dataPath)
	var machines = []
	if not dir:
		return false
	if not dir.dir_exists("machines"): 
		return machines
	dir.change_dir("machines")
	var files = dir.get_files()
	for file in files:
		var fileData = DataManagerObj.loadDict(dataPath + "/machines/" + file)
		if fileData.get("type") == "machine":
			machines.append(fileData)
	return machines

func saveMachines(machines):
	var dir = DirAccess.open(dataPath)
	if not dir.dir_exists("machines"):
		dir.make_dir("machines")
	for machine in machines:
		DataManagerObj.saveDict(machine, dataPath + "/machines/" + machine["name"] + ".json")
	
