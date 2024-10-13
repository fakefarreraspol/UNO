extends Node

var handCards = []

signal card_added(newCard : Card)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func AddCard(card: Card) -> void:
	handCards.append(card)
	if card == null:
		print("ERROR: 'card' is null in Hand")
		return
	emit_signal("card_added", card)


func RemoveCard(card: Card) -> void:
	print(card.GetCardDescription())
	handCards.erase(card)
	print(" Cards Left: " + str(len(handCards))) 

func ClearAllCards() -> void:
	handCards.clear()

func GetHand() -> Array:
	return handCards

func GetCard() -> Card:
	var card = handCards.pop_at(0)
	return card
