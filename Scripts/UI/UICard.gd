extends TextureButton

const UNO_CARDS = preload("res://Sprites/UNOCards.png")
var num_columns = 13
var num_rows = 5
var data: Card

#func _init(card: Card) -> void:
	#data = card
	#update_sprite(0)

#func _ready() -> void:
	#update_sprite(4)

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
