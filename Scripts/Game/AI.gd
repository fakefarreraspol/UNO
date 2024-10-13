extends Node
@onready var ai_hand = $AIHand

var AI_CardUI
var ai_timer: Timer

func TurnChanged() -> void:
	if(!GameGlobals.playerTurn):
		ai_timer = Timer.new()
		AI_CardUI.SelectCard()
		var wait_time = randf_range(1.0, 3.0)
		ai_timer.wait_time = wait_time
		# Start the timer
		ai_timer.start()
		# Await the timer to finish
		await ai_timer.timeout
		AI_CardUI.PlaceCard(ai_hand.handCards[0])

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AI_CardUI = get_tree().get_root().get_node("UNO/Board/CanvasLayer/AICardContainer")
	ai_hand.card_added.connect(Callable(OnCardAdded).bind())


func OnCardAdded(card: Card) -> void:
	print("Player draws a Card")
	if card == null:
		print("ERROR: 'card' is null in OnCardAdded")
		return
	AI_CardUI.AddCard(card)

func PlaceCard() -> void:
	pass
