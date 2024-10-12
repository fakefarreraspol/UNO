extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HideChooseColor()

func HideChooseColor() -> void:
	if($CanvasLayer.visible): $CanvasLayer.hide()
	else: $CanvasLayer.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_yellow_button_pressed() -> void:
	pass # Replace with function body.


func _on_red_button_pressed() -> void:
	pass # Replace with function body.


func _on_green_button_pressed() -> void:
	pass # Replace with function body.


func _on_blue_button_pressed() -> void:
	pass # Replace with function body.
