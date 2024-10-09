extends Control
@onready var canvas_layer: CanvasLayer = $CanvasLayer

var isVisible = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HideMenu()

func _on_quit_game_pressed() -> void:
	get_tree().quit()

func HideMenu() -> void:
	if canvas_layer.visible:
		canvas_layer.hide()
		print("End Menu Hidden")
	else: 
		canvas_layer.show()
		print("End Menu Shown")
