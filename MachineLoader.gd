extends Node

@onready var DataManagerObj = $".." as DataManager
@onready var NameList = $"../../TabContainer/Machines/HSplitContainer/ScrollContainer/GridContainer" as BoxContainer
var NameLabel = preload("res://machine_label.tscn")
var dataPath = ""
var data

func _ready():
	data = DataManagerObj.loadDict();
	if data.is_empty():
		if not DirAccess.dir_exists_absolute("user://machines"):
			DirAccess.make_dir_absolute("user://machines")
		data["dataPath"] = "user://machines"
	refreshMachines(data["dataPath"])

func refreshMachines(_dataPath):
	dataPath = _dataPath
	for node in NameList.get_children():
		NameList.remove_child(node)
	var machines = loadMachines();
	for machine in machines:
		var button = NameLabel.instantiate()
		button.get_child(0).text = machine["display"];
		button.get_child(0).connect("button_down", func (): onMachineSelect(machine))
		NameList.add_child(button);

func onMachineSelect(machine):
	$"../MachinePopulator".currentlySelected(machine)

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
	
