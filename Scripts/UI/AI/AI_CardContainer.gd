extends HBoxContainer

const CARD = preload("res://UI/Cards/AI/AICard.tscn")
var startPosition
var maxCardsAllowed = 15

var cardSelected 
func _ready() -> void:
	self.size.x = maxCardsAllowed * 74
	UpdatePivot()
	var projResH = ProjectSettings.get_setting("display/window/size/viewport_height")
	var projResW = ProjectSettings.get_setting("display/window/size/viewport_width")
	position.y = 0
	startPosition = self.position

func AddCard(card : Card):
	if card == null:
		print("ERROR: 'card' is null in AddCard")
		return
	var cardInstance = CARD.instantiate()
	add_child(cardInstance)

func UpdatePivot() -> void:
	self.pivot_offset.x = maxCardsAllowed * 37

func SelectCard() -> void:
	if cardSelected != null:
		cardSelected.UnselectCard()
	var randomCard = randi_range(0, self.get_child_count() - 1)
	var SelectedCard = get_child(randomCard)
	SelectedCard.SelectCard()
	cardSelected = SelectedCard

func PlaceCard(card : Card) -> void:
	var cardSpriteIndex = GetCardIndex(card)
	if(cardSpriteIndex<0) : return
	var projResH = ProjectSettings.get_setting("display/window/size/viewport_height")
	var projResW = ProjectSettings.get_setting("display/window/size/viewport_width")
	get_node("../CardPlacement").PlaceCard(Vector2(projResW/2, projResH/2), cardSpriteIndex, card)
	cardSelected.DeleteCard()


# 10 (0-9) +2 Reverse Skip
func GetCardIndex(card: Card) -> int:
	var calculatedIndex : int
	if card == null:
		print("ERROR: 'card' is null in InitCard")
		return -10
	if card.card_type == Card.cardType.NUMBER:
		if card.card_color == Card.cardColor.RED:
			if(card.cardNumber == 0): calculatedIndex = 10 - 1
			else: calculatedIndex = card.cardNumber - 1
		elif card.card_color == Card.cardColor.GREEN:
			if(card.cardNumber == 0): calculatedIndex = 23 - 1
			else: calculatedIndex = card.cardNumber + 13 - 1
		elif card.card_color == Card.cardColor.BLUE:
			if(card.cardNumber == 0): calculatedIndex = 36 - 1
			else: calculatedIndex = card.cardNumber + 26 - 1
		elif card.card_color == Card.cardColor.YELLOW:
			if(card.cardNumber == 0): calculatedIndex = 49 -1
			else: calculatedIndex = card.cardNumber + 39 - 1
	elif card.card_type == Card.cardType.SKIP:
		if card.card_color == Card.cardColor.RED:
			calculatedIndex = 13 -1
		elif card.card_color == Card.cardColor.GREEN:
			calculatedIndex = 26 -1
		elif card.card_color == Card.cardColor.BLUE:
			calculatedIndex = 39 -1
		elif card.card_color == Card.cardColor.YELLOW:
			calculatedIndex = 52 -1
	elif card.card_type == Card.cardType.DRAW_TWO:
		if card.card_color == Card.cardColor.RED:
			calculatedIndex = 11 - 1
		elif card.card_color == card.cardColor.GREEN:
			calculatedIndex = 24 -1
		elif card.card_color == Card.cardColor.BLUE:
			calculatedIndex = 37 -1
		elif card.card_color == Card.cardColor.YELLOW:
			calculatedIndex = 50 -1 
	elif card.card_type == Card.cardType.WILD:
		calculatedIndex = 53 -1
	elif card.card_type == Card.cardType.WILD_DRAW_FOUR:
		calculatedIndex = 58 -1
	
	return calculatedIndex



func RemoveAllUICards() -> void:
	for child in get_children():
		child.queue_free()
	get_node("../CardPlacement").DestroyCard()
