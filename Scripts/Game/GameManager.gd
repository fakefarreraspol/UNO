extends Node

@onready var deck = $"../DECK"
@onready var end_menu: Control = $"../Camera2D/EndMenu"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func StartGame() -> void:
	deck.InitializeDeck()
	end_menu.visible = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
