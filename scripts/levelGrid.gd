extends GridContainer

const levelList = preload("res://scripts/levels.gd").levels
const sections  = preload("res://scripts/levels.gd").section
const colnum    = 5

const buttonTheme : Theme = preload("res://font/button.theme")
const ubuntuFont  : Font  = preload("res://font/Ubuntu-R.tres")

func run_level(level):
	GlobalVar.levelGridScroll = ($"../.." as ScrollContainer).scroll_vertical
	GlobalVar.selectedLevel = level
	if GlobalVar.onMobile :
		var _scene = get_tree().change_scene_to_file("res://scenes/BoardMobile.tscn")
	else :
		var _scene = get_tree().change_scene_to_file("res://scenes/Board.tscn")

func generate_level_buttons():
	var styleTrans: StyleBoxFlat = StyleBoxFlat.new()
	styleTrans.bg_color = Color(0,0,0,0)
	self.columns = colnum
	#var pad = colnum
	var pad = 0
	for i in len(levelList):
		if sections.has(levelList[i].id):
			for _j in pad:
				var panel: Panel = Panel.new()
				panel.custom_minimum_size = Vector2(64,64)
				panel.mouse_filter = MOUSE_FILTER_IGNORE
				self.add_child(panel)
			var sectionPanel = Panel.new()
			var sectionLabel: Label = Label.new()
			sectionLabel.text = sections[levelList[i].id]
			sectionLabel.add_theme_font_override("font", ubuntuFont)
			sectionPanel.custom_minimum_size = Vector2(64,20)	
			sectionPanel.mouse_filter = MOUSE_FILTER_IGNORE
			self.add_child(sectionPanel)
			sectionPanel.add_child(sectionLabel)
			for _j in colnum-1:
				var panel = Panel.new()
				panel.custom_minimum_size = Vector2(64,12)
				panel.mouse_filter = MOUSE_FILTER_IGNORE
				self.add_child(panel)
				panel.add_theme_stylebox_override("panel",styleTrans)
			pad = colnum
		var level = levelList[i]
		var panel = Panel.new()
		var levelButton: Button = Button.new()
		var _c = levelButton.connect("pressed", Callable(self, "run_level").bind(level))
		levelButton.theme = buttonTheme
		levelButton.text = str(level.id+1)
		levelButton.custom_minimum_size = Vector2(64,64)
		panel.custom_minimum_size = Vector2(64,64)
		if !GlobalVar.unlockedLevel[level.id]:
			levelButton.disabled = true
		panel.add_child(levelButton)
		self.add_child(panel)
		pad = (pad-1 + colnum) % colnum

func regenerate_level_buttons():
	for child in self.get_children(): child.queue_free()
	generate_level_buttons()

func _ready():
	generate_level_buttons()
	await RenderingServer.frame_post_draw
	($"../.." as ScrollContainer).scroll_vertical = GlobalVar.levelGridScroll
