extends Node

var handCards = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func AddCard(card: Card) -> void:
	handCards.append(card)

func RemoveCard(card: Card) -> void:
	handCards.erase(card)
	

func GetHand() -> Array:
	return handCards
