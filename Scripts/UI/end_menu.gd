extends Control
@onready var canvas_layer: CanvasLayer = $CanvasLayer

var isVisible = false

func _ready() -> void:
	print(self.name)
	if(str(self.name) == "EndMenu"):
		HideMenu()
	else: print("diff")

func _on_quit_game_pressed() -> void:
	get_tree().quit()
	

func HideMenu() -> void:
	if canvas_layer.visible:
		canvas_layer.hide()
		print("Menu Hidden")
	else: 
		canvas_layer.show()
		print("Menu Shown")


func _on_play_again_pressed() -> void:
	get_tree().get_root().get_node("UNO/GameManager").StartGame()
	HideMenu()
