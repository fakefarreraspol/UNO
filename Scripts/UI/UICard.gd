extends Container

@onready var card = preload("res://UI/Cards/CardHolder.tscn")
const UNO_CARDS = preload("res://Sprites/UNOCards.png")
var num_columns = 13
var num_rows = 5
var data: Card

var cardHighlighted = false

func update_sprite(index: int) -> void:
	var cardSize = GetCardSize()	
	var spriteChild : Sprite2D = $CardFront
	
	var x = (index % num_columns) * cardSize.x 
	var y = int(index / num_columns) * cardSize.y
	
	var atlas_tex = AtlasTexture.new()
	atlas_tex.atlas = UNO_CARDS
	atlas_tex.region = Rect2(Vector2(x,y), cardSize)
	
	spriteChild.vframes = 5
	spriteChild.hframes = 13
	
	spriteChild.frame = index
	

func GetCardSize() -> Vector2:
	var sheetSize = UNO_CARDS.get_size()
	var cardWidth = sheetSize.x / num_columns
	var cardHeight = sheetSize.y / num_rows

	return Vector2(cardWidth, cardHeight)



# 10 (0-9) +2 Reverse Skip
func InitCard(card: Card) -> void:
	var calculatedIndex : int
	if card == null:
		print("ERROR: 'card' is null in InitCard")
		return
	if card.card_type == Card.cardType.NUMBER:
		if card.card_color == Card.cardColor.RED:
			if(card.cardNumber == 0): calculatedIndex = 10
			else: calculatedIndex = card.cardNumber - 1
		elif card.card_color == Card.cardColor.GREEN:
			if(card.cardNumber == 0): calculatedIndex = 23
			else: calculatedIndex = card.cardNumber + 13 - 1
		elif card.card_color == Card.cardColor.BLUE:
			if(card.cardNumber == 0): calculatedIndex = 36
			else: calculatedIndex = card.cardNumber + 26 - 1
		elif card.card_color == Card.cardColor.YELLOW:
			if(card.cardNumber == 0): calculatedIndex = 39
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
	
	data = card
	update_sprite(calculatedIndex)


func _on_mouse_entered() -> void:
	$Anim.play("Select")
	cardHighlighted = true


func _on_mouse_exited() -> void:
	$Anim.play("Deselect")
	cardHighlighted = false


func _on_gui_input(event: InputEvent) -> void:
	if(GameGlobals.playerTurn == false): return
	if(event is InputEventMouseButton) and (event.button_index == 1):
		if event.button_mask == 1:
			#press down
			if cardHighlighted:
				var cardTemp = card.instantiate()
				cardTemp.update_sprite($CardFront.frame)
				get_tree().get_root().get_node("UNO/Board/CardHolder").add_child(cardTemp)
				GameGlobals.CardSelected = true
				self.get_child(0).hide()
		elif event.button_mask == 0:
			#press up
			if (!GameGlobals.mouseOnPlacement)or (!GameGlobals._CheckCardsCompatibility(data)):
				#place card not on board
				cardHighlighted = false
				self.get_child(0).show()
			else:
				#place card on board
				self.queue_free()
				get_node("../../CardPlacement").PlaceCard(get_global_mouse_position(), $CardFront.frame, data)
				
			for i in get_tree().get_root().get_node("UNO/Board/CardHolder").get_child_count():
				#only if cards are the same
				get_tree().get_root().get_node("UNO/Board/CardHolder").get_child(i).queue_free()
		GameGlobals.CardSelected =false
