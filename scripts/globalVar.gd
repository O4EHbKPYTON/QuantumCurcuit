extends Node

const levelList = preload("res://scripts/levels.gd").levels
const optiFilePath = "user://optigame.save"
const saveFilePath = "user://savegame.save"

var selectedLevel = null
var levelGridScroll: int = 0

var onMobile : bool = true

# Options
var useNotSymbol: bool = true

# unlocked
var unlockedLevel: Dictionary = {
	0 : true,
	1 : false,
	2 : false,
	3 : false,
	4 : false,
	5 : false,
	6 : false,
	7 : false,
	8 : false,
	9 : false,
	10 : false,
	11 : false,
	12 : false,
	13 : false,
	14 : false,
	15 : false,
	16 : false,
	17 : false,
	18 : false,
	19 : false,
	20 : false,
	21 : false,
	22 : false,
	23 : false,
	24 : false,
	25 : false,
	26 : false,
	27 : false,
	28 : false,
	29 : false,
	30 : false,
	31 : false,
	32 : false,
	33 : false,
	34 : false,
	35 : false,
	36 : false,
	37 : false,
	38 : false,
	39 : false,
	40 : false,
	41 : false,
	42 : false,
	43 : false,
	101 : true,
	102 : true,
	103 : true,
	104 : true,
}

var unlockedLevelInit = null

func save_level():
	var file = FileAccess.open(saveFilePath, FileAccess.WRITE)
	if file:
		file.store_line(JSON.stringify(self.unlockedLevel))
	file.close()

func save_opti():
	var saved = FileAccess.open(optiFilePath, FileAccess.WRITE)
	if saved:
		saved.store_line(JSON.new().stringify(self.useNotSymbol))
	saved.close()

func load_level():
	if not FileAccess.file_exists(saveFilePath):
		return
	var file = FileAccess.open(saveFilePath, FileAccess.READ)
	if file:
		var parse_result = JSON.parse_string(file.get_line())
		if typeof(parse_result) == TYPE_DICTIONARY:
			for key in parse_result:
				self.unlockedLevel[int(key)] = parse_result[key]
		file.close()

func load_opti():
	if not FileAccess.file_exists(optiFilePath):
		return
	var file = FileAccess.open(optiFilePath, FileAccess.READ)
	if file:
		var parse_result = JSON.parse_string(file.get_line())
		if typeof(parse_result) == TYPE_BOOL:
			self.useNotSymbol = parse_result
		file.close()

func unlock_all_level():
	for key in self.unlockedLevel:
		self.unlockedLevel[key] = true

func reset_progress():
	self.unlockedLevel = self.unlockedLevelInit.duplicate(true)

func _ready():
	self.unlockedLevelInit = self.unlockedLevel.duplicate(true)
	self.load_opti()
	self.load_level()
