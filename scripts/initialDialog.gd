extends Window

func _ready():
	connect("about_to_popup", _on_about_to_popup)
	connect("close_requested", close_requested)

func _on_about_to_popup():
	var viewport_size = get_viewport().get_visible_rect().size
	self.size = viewport_size
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.set_ease(Tween.EASE_IN)
	self.move_to_center()
	await tween.finished

func close_requested():
	hide()  
