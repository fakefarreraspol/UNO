extends Control

signal color_changed(color : Card.cardColor)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HideChooseColor()

func HideChooseColor() -> void:
	if($CanvasLayer.visible): $CanvasLayer.hide()
	else: $CanvasLayer.show()


func _on_yellow_button_pressed() -> void:
	emit_signal("color_changed", Card.cardColor.YELLOW)
	HideChooseColor()


func _on_red_button_pressed() -> void:
	emit_signal("color_changed", Card.cardColor.RED)
	HideChooseColor()


func _on_green_button_pressed() -> void:
	emit_signal("color_changed", Card.cardColor.GREEN)
	HideChooseColor()


func _on_blue_button_pressed() -> void:
	emit_signal("color_changed", Card.cardColor.BLUE)
	HideChooseColor()
