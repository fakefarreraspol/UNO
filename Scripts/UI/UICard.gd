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


func _on_mouse_entered() -> void:
	$Anim.play("Select")
	cardHighlighted = true


func _on_mouse_exited() -> void:
	$Anim.play("Deselect")
	cardHighlighted = false


func _on_gui_input(event: InputEvent) -> void:
	if(event is InputEventMouseButton) and (event.button_index == 1):
		if event.button_mask == 1:
			#press down
			if cardHighlighted:
				var cardTemp = card.instantiate()
				get_tree().get_root().get_node("UNO/Board/CardHolder").add_child(cardTemp)
				GameGlobals.CardSelected = true
				self.get_child(0).hide()
		elif event.button_mask == 0:
			#press up
			if !GameGlobals.mouseOnPlacement:
				#place card not on board
				cardHighlighted = false
				self.get_child(0).show()
			else:
				#place card on board
				self.queue_free()
				get_node("../../CardPlacement").PlaceCard(get_global_mouse_position())
				
			for i in get_tree().get_root().get_node("UNO/Board/CardHolder").get_child_count():
				#only if cards are the same
				get_tree().get_root().get_node("UNO/Board/CardHolder").get_child(i).queue_free()
		GameGlobals.CardSelected =false
