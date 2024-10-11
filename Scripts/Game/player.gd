extends Node
@onready var player_hand = $PlayerHand

var turn = false
var CardUI

func _ready() -> void:
	CardUI = get_tree().get_root().get_node("UNO/Board/CanvasLayer/CardContainer")
	player_hand.card_added.connect(Callable(OnCardAdded).bind())

func DrawCard() -> void:
	pass
	
func PlayCard() -> void:
	if !turn: return
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_down"):
		player_hand.AddCard(get_tree().get_root().get_node("UNO/DECK").Draw())

func OnCardAdded(card: Card) -> void:
	print("Player draws a Card")
	if card == null:
		print("ERROR: 'card' is null in OnCardAdded")
		return
	CardUI.AddCard(card)
