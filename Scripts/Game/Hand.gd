extends Node

var handCards = []



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func AddCard(card: Card) -> void:
	handCards.append(card)
	
	#print("Car added!" + str(len(handCards)))


func RemoveCard(card: Card) -> void:
	handCards.erase(card)

func ClearAllCards() -> void:
	handCards.clear()

func GetHand() -> Array:
	return handCards
