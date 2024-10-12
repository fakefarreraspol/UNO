extends Node

@onready var deck = $"../DECK"
@onready var end_menu: Control = $"../Camera2D/EndMenu"
@onready var choose_color: Control = $"../Camera2D/ChooseColor"


@onready var player: Node = $"../Player"
@onready var player_hand = $"../Player/PlayerHand"
@onready var ai_player: Node = $"../AIPlayer"
@onready var ai_hand = $"../AIPlayer/AIHand"

func _ready() -> void:
	StartGame()
	
func StartGame() -> void:
	deck.InitializeDeck() #create deck
	ai_hand.ClearAllCards() #Replay
	player_hand.ClearAllCards() #Replay
	
	print(str(len(deck.cards)))
	for i in range(7): 
		player_hand.AddCard(deck.Draw())
		ai_hand.AddCard(deck.Draw())
		
	print(str(len(deck.cards)))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_right"): end_menu.HideMenu()
	if Input.is_action_just_pressed("ui_left"): choose_color.HideChooseColor()
