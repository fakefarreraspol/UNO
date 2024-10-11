extends Control

const CARD_ON_BOARD = preload("res://UI/Cards/CardOnBoard.tscn")
func _on_mouse_entered() -> void:
	GameGlobals.mouseOnPlacement = true


func _on_mouse_exited() -> void:
	GameGlobals.mouseOnPlacement = false

func PlaceCard(position : Vector2):
	var cardTemp = CARD_ON_BOARD.instantiate()
	var finalPos = position-self.position
	cardTemp.global_position = finalPos
	print(cardTemp.global_position)
	add_child(cardTemp)
	
