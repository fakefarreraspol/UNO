extends Control

@onready var audio: AudioStreamPlayer = $CanvasLayer/Container/AudioStreamPlayer
signal button_pressed()

func _ready() -> void:
	HideUNOButton()


func HideUNOButton() -> void:
	if($CanvasLayer.visible): $CanvasLayer.hide()
	else: $CanvasLayer.show()

func _on_container_mouse_entered() -> void:
	$CanvasLayer.get_child(0).get_child(1).play("Select")


func _on_container_mouse_exited() -> void:
	$CanvasLayer.get_child(0).get_child(1).play("Deselect")


func _on_container_gui_input(event: InputEvent) -> void:
	if(event is InputEventMouseButton) and (event.button_index == 1) and (event.is_pressed()):
		print("UNO!")
		audio.play()
		emit_signal("button_pressed")
		HideUNOButton()
