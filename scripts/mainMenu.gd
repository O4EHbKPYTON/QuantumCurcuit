extends Control

const GateType = preload("res://scripts/gateEnum.gd").Typ # получение доступа к enum под именем Typ
#GateType теперь содержит ссылку на это перечисление
const gateData = {
	GateType.H : {
		name    = "Адамар",
		sprite  = "res://sprites/gateH.png",
		zeroto  = "( |0⟩ + |1⟩ )/sqrt2",
		oneoto  = "( |0⟩ – |1⟩ )/sqrt2",
	},
	GateType.X : {
		name    = "Паули-X",
		sprite  = "res://sprites/gateX.png",
		zeroto  = "|1⟩",
		oneoto  = "|0⟩",
	},
	GateType.Y : {
		name    = "Паули-Y",
		sprite  = "res://sprites/gateY.png",
		zeroto  = "[/i]i[i]|1⟩",
		oneoto  = "–[/i]i[i]|0⟩",
	},
	GateType.Z : {
		name    = "Паули-Z",
		sprite  = "res://sprites/gateZ.png",
		zeroto  = "|0⟩",
		oneoto  = "-|1⟩",
	},
	GateType.S : {
		name    = "S-Гейт",
		sprite  = "res://sprites/gateS.png",
		zeroto  = "|0⟩",
		oneoto  = "[/i]i[i]|1⟩",
	},
}

static func gen_table(zeroto, oneto) -> String:
	var l1 = "[table=1][cell][i]|0⟩ → %s [/i][/cell]" % zeroto
	var l2 = "[cell][i]|1⟩ → %s [/i][/cell][/table]"  % oneto
	return l1+l2

func prepare_gate_popup():
	var label : RichTextLabel = %GatesLabel
	label.custom_minimum_size = Vector2(900, 600)
	
	var bbcode_text := "[table=3]"
	for st in ["Гейт","Символ","Пример"]:
		bbcode_text += "[cell][b]%s[/b][/cell]" % st
	for st in ["             ","           ","                               "]:
		bbcode_text += "[cell][code]%s[/code][/cell]" % st
	for i in gateData:
		var gate = gateData[i]
		for st in [
			gate.name,
			"[img=64x64]%s[/img]" % gate.sprite,
			"[i]|0⟩ → %s\n|1⟩ → %s[/i]" % [gate.zeroto, gate.oneoto],
		]:
			bbcode_text += "[cell]%s[/cell]" % st
	bbcode_text += "[/table]"
	label.bbcode_text = bbcode_text

		
func _on_xnot_button_pressed():
	var xbutton: Button = %Xbutton
	GlobalVar.useNotSymbol = xbutton.is_pressed()
	GlobalVar.save_opti()

func prepare_option_popup():
	var xbutton : Button = %Xbutton
	xbutton.button_pressed = GlobalVar.useNotSymbol
	var _c1 =  xbutton.connect("pressed", Callable(self, "_on_xnot_button_pressed"))
	#var levelGrid : GridContainer = $"../LevelContainer/VBoxContainer/LevelGrid"
	#var _c11 = $"../CanvasLayer/OptionDialog/UnlockButton".connect("pressed", Callable(GlobalVar, "unlock_all_level"))
	#var _c2 = $"../CanvasLayer/OptionDialog/UnlockButton".connect("pressed",levelGrid,"regenerate_level_buttons")
	#var _c3 = $"../CanvasLayer/OptionDialog/ResetButton".connect("pressed",GlobalVar,"reset_progress")
	#var _c4 = $"../CanvasLayer/OptionDialog/ResetButton".connect("pressed",levelGrid,"regenerate_level_buttons")
	
func show_gate_popup():
	%GatesDialog.popup()
	
func show_option_popup():
	%OptionDialog.popup()
	
func show_about_popup():
	%AboutDialog.popup()

const originalSize = Vector2(1024,600)

func center_on_screen():
	var viewportSize : Vector2 = get_viewport_rect().size
	var dx = viewportSize.x - originalSize.x
	if dx > 0:
		var boardNode : Node2D = get_tree().root.get_child(1)
		boardNode.translate(Vector2(dx/2,0))
		%OptionDialog.position += Vector2i(int(dx / 2), 0) 
		%AboutDialog.position += Vector2i(dx/2,0)
		(%LevelContainer as ScrollContainer).size += Vector2(dx/2,0)

func _ready():
	center_on_screen()
	prepare_gate_popup()
	prepare_option_popup()
	var _c1 = $GateButton.connect("pressed", Callable(self, "show_gate_popup"))
	var _c2 = $OptionButton.connect("pressed", Callable(self, "show_option_popup"))
	var _c4 = $AboutButton.connect("pressed", Callable(self, "show_about_popup"))
