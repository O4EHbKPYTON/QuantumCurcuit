extends ColorRect
# Этот код делает затеменение экрана когда появляется popup window поэтому это ColorRect
# dimmer Это в английском штука которая затемняет
var tw: Tween = null

func _ready():
	tw = create_tween().bind_node(self)

func clear():
	tw = create_tween().bind_node(self)
	tw.tween_property(self, "modulate:a", 0.0, 0.3).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)

func dim():
	tw = create_tween().bind_node(self)
	tw.tween_property(self, "modulate:a", 1.0, 0.3).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN)

func check_visible(obj: Node):
	if obj.visible:
		dim()
	else:
		clear()
