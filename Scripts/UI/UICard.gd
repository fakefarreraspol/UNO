extends TextureButton

const UNO_CARDS = preload("res://Sprites/UNOCards.png")
var num_columns = 13
var num_rows = 5
var data: Card


func update_sprite(index: int) -> void:
	var cardSize = GetCardSize()	
	
	var x = (index % num_columns) * cardSize.x 
	var y = int(index / num_columns) * cardSize.y
	
	var atlas_tex = AtlasTexture.new()
	atlas_tex.atlas = UNO_CARDS
	atlas_tex.region = Rect2(Vector2(x,y), cardSize)
	
	texture_normal = atlas_tex
	texture_pressed = atlas_tex
	texture_hover = atlas_tex
	texture_disabled = atlas_tex



func GetCardSize() -> Vector2:
	var sheetSize = UNO_CARDS.get_size()
	var cardWidth = sheetSize.x / num_columns
	var cardHeight = sheetSize.y / num_rows
	
	print(Vector2(cardWidth, cardHeight))
	return Vector2(cardWidth, cardHeight)



# 10 (0-9) +2 Reverse Skip
func InitCard(card: Card) -> void:
	var calculatedIndex : int
	if card.card_type == card.cardType.NUMBER:
		if card.card_color == card.cardColor.RED:
			calculatedIndex = card.cardNumber
		elif card.card_color == card.cardColor.GREEN:
			calculatedIndex = card.cardNumber + 13
		elif card.card_color == card.cardColor.BLUE:
			calculatedIndex = card.cardNumber + 26 
		elif card.card_color == card.cardColor.YELLOW:
			calculatedIndex = card.cardNumber + 39 
	elif card.card_type == card.cardType.SKIP:
		if card.card_color == card.cardColor.RED:
			calculatedIndex = 13
		elif card.card_color == card.cardColor.GREEN:
			calculatedIndex = 26
		elif card.card_color == card.cardColor.BLUE:
			calculatedIndex = 39
		elif card.card_color == card.cardColor.YELLOW:
			calculatedIndex = 52
	elif card.card_type == card.cardType.DRAW_TWO:
		if card.card_color == card.cardColor.RED:
			calculatedIndex = 11
		elif card.card_color == card.cardColor.GREEN:
			calculatedIndex = 24
		elif card.card_color == card.cardColor.BLUE:
			calculatedIndex = 37
		elif card.card_color == card.cardColor.YELLOW:
			calculatedIndex = 49
	elif card.card_type == card.cardType.WILD:
		calculatedIndex = 53
	elif card.card_type == card.cardType.WILD_DRAW_FOUR:
		calculatedIndex = 58
		
	update_sprite(calculatedIndex)
