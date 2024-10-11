extends Container

var cardHeld = ""

func _process(delta: float) -> void:
	self.global_position = get_global_mouse_position()
	

func update_sprite(index: int) -> void:

	var spriteChild : Sprite2D = $CardFront
	spriteChild.vframes = 5
	spriteChild.hframes = 13
	spriteChild.frame = index
