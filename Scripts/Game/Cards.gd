
class_name Card
enum cardType { NUMBER, SKIP, DRAW_TWO, WILD, WILD_DRAW_FOUR }
enum cardColor { RED, BLUE, GREEN, YELLOW, NONE }

# Properties
var cardNumber: int = -1
var card_type: cardType = cardType.NUMBER
var card_color: cardColor = cardColor.NONE

func _init(color: cardColor, number: int, type: cardType) -> void:
	card_color = color
	cardNumber = number
	card_type = type

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func GetCardDescription() -> String:
	return str(card_color) + " " + str(cardNumber) + " " + str(card_type) 
