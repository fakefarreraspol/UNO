extends Container

@onready var card = preload("res://UI/Cards/CardHolder.tscn")
const UNO_CARDS = preload("res://Sprites/UNOCards.png")

var cardHighlighted = false

func UnselectCard() -> void:
	$Anim.play("Deselect")
	cardHighlighted = true


func SelectCard() -> void:
	$Anim.play("Select")
	cardHighlighted = false

func DeleteCard() -> void:
	queue_free()
