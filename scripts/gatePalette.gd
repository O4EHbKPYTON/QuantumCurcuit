extends GridContainer

const GateType = preload("res://scripts/gateEnum.gd").Typ
var selectedGate = GateType.Empty

var imgScale = 0.4
var imgSize  = 128 * imgScale

func select_gate(gate, gateButton : TextureButton):
	self.selectedGate = gate
	$"../selectedGateTexture".position = gateButton.get_parent().position + self.position

func set_palette(availableGate : Array):
	var styleTrans : StyleBoxFlat = StyleBoxFlat.new()
	styleTrans.bg_color = Color(0,0,0,0)
	for typ in availableGate:
		var panel = Panel.new()
		var gateButton  = TextureButton.new()
		gateButton.connect("pressed", Callable(self, "select_gate").bind(typ, gateButton))
		gateButton.texture_hover = load("res://sprites/gateHover.png")
		match typ:
			GateType.Empty:
				gateButton.texture_normal = load("res://sprites/gateEmpty.png")
				gateButton.texture_hover = load("res://sprites/gateEmptyhover.png")
			GateType.H:
				gateButton.texture_normal = load("res://sprites/gateH.png")
				gateButton.texture_hover = load("res://sprites/gateHhover.png")
			GateType.X:
				if GlobalVar.useNotSymbol:
					gateButton.texture_normal = load("res://sprites/gateNOT.png")
					gateButton.texture_hover = load("res://sprites/gateNOThover.png")
				else:
					gateButton.texture_normal = load("res://sprites/gateX.png")
					gateButton.texture_hover = load("res://sprites/gateXhover.png")
			GateType.Y:
				gateButton.texture_normal = load("res://sprites/gateY.png")
				gateButton.texture_hover = load("res://sprites/gateYhover.png")
			GateType.Z:
				gateButton.texture_normal = load("res://sprites/gateZ.png")
				gateButton.texture_hover = load("res://sprites/gateZhover.png")
			GateType.Ctrl:
				gateButton.texture_normal = load("res://sprites/gateCtrl.png")
				gateButton.texture_hover = load("res://sprites/gateCtrlhover.png")
			GateType.S:
				gateButton.texture_normal = load("res://sprites/gateS.png")
				gateButton.texture_hover = load("res://sprites/gateShover.png")
		gateButton.scale = Vector2(imgScale,imgScale)
		panel.custom_minimum_size = Vector2(imgSize, imgSize)
		panel.add_theme_stylebox_override("panel",styleTrans)
		panel.add_child(gateButton)
		add_child(panel)

func rescale():
	$"../selectedGateTexture".position = self.position
	$"../selectedGateTexture".scale = Vector2(imgScale,imgScale)
	
func _ready():
	$"../selectedGateTexture".position = self.position
	$"../selectedGateTexture".scale = Vector2(imgScale,imgScale)
