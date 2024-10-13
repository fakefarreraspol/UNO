extends Control

signal card_drawn()

@onready var anim: AnimationPlayer = $CanvasLayer/Container/Anim

func _on_container_mouse_entered() -> void:
	anim.play("Select")


func _on_container_mouse_exited() -> void:
	anim.play("Deselect")


func _on_container_gui_input(event: InputEvent) -> void:
	if !GameGlobals.playerTurn: return
	if(event is InputEventMouseButton) and (event.button_index == 1) and (event.is_pressed()):
		emit_signal("card_drawn")
		anim.play("TakeCard")
