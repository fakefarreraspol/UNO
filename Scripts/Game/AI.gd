extends Node
@onready var ai_hand = $AIHand

var AI_CardUI
signal ai_draw_card()

var cardToPlay = Card

func TurnChanged() -> void:
	if(!GameGlobals.playerTurn):
		if !DecideNextMovement(): return
		if(len(ai_hand.handCards) > 1):
			for i in randf_range(1, 3):
				AI_CardUI.SelectCard()
				await get_tree().create_timer(randf_range(0.2, 3)).timeout
		else:
			AI_CardUI.SelectCard()
			await get_tree().create_timer(0.5).timeout
		if cardToPlay == null: 
			print("Ai card is null")
			return
		AI_CardUI.PlaceCard(cardToPlay)
		ai_hand.RemoveCard(cardToPlay)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AI_CardUI = get_tree().get_root().get_node("UNO/Board/CanvasLayer/AICardContainer")
	ai_hand.card_added.connect(Callable(OnCardAdded).bind())


func OnCardAdded(card: Card) -> void:
	print("AI draws a Card")
	if card == null:
		print("ERROR: 'card' is null in OnCardAdded")
		return
	AI_CardUI.AddCard(card)

func DecideNextMovement() -> bool:
	cardToPlay = null
	for card in ai_hand.handCards:
		if(GameGlobals._CheckCardsCompatibility(card)):
			cardToPlay = card
			return true
	if cardToPlay == null: 
		emit_signal("ai_draw_card")
	
	
	return false
