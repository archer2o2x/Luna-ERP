extends FileDialog

@onready var DataManagerObj = $".." as DataManager
@onready var FilePathDisplay = $"../../TabContainer/Machines/Label2" as Button

func _ready():
	FilePathDisplay.text = DataManagerObj.loadDict()["dataPath"]

func onOpenDialog():
	visible = true

func onGetResult(path):
	var data = DataManagerObj.loadDict()
	data["dataPath"] = path
	DataManagerObj.saveDict(data)
	FilePathDisplay.text = path
