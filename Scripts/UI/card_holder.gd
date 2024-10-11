extends Container

var cardHeld = ""

func _process(delta: float) -> void:
	self.global_position = get_global_mouse_position()
