extends FileDialog

@onready var DataManagerObj = $".." as DataManager
@onready var FilePathDisplay = $"../../TabContainer/Machines/Label2" as Button

func _ready():
	var data = DataManagerObj.loadDict() as Dictionary;
	if data.is_empty():
		if not DirAccess.dir_exists_absolute("user://machines"):
			DirAccess.make_dir_absolute("user://machines")
		data["dataPath"] = "user://machines"
	FilePathDisplay.text = data["dataPath"]

func onOpenDialog():
	visible = true

func onGetResult(path):
	var data = DataManagerObj.loadDict()
	data["dataPath"] = path
	DataManagerObj.saveDict(data)
	FilePathDisplay.text = path
