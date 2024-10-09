extends Node
@onready var player_hand = $PlayerHand

var turn = false

func DrawCard() -> void:
	pass
	
func PlayCard() -> void:
	if !turn: return
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_down"):
		print(player_hand.handCards[0].GetCardDescription())
