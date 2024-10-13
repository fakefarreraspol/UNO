extends Node

@onready var deck = $"../DECK"
@onready var end_menu: Control = $"../Camera2D/EndMenu"
@onready var choose_color: Control = $"../Camera2D/ChooseColor"
@onready var draw_card: Control = $"../Camera2D/DrawCard"


@onready var player: Node = $"../Player"
@onready var player_hand = $"../Player/PlayerHand"
@onready var ai_player: Node = $"../AIPlayer"
@onready var ai_hand = $"../AIPlayer/AIHand"

var PlayerTurn = true #false if is AI turn

func _ready() -> void:
	StartGame()
	choose_color.color_changed.connect(Callable(ChangeLastColorCard).bind())
	GameGlobals.last_card_changed.connect(Callable(TriggerSpecialCards).bind())
	draw_card.card_drawn.connect(Callable(PlayerDrawsCard))

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
	
	
func ChangeLastColorCard( color : Card.cardColor) -> void:
	print("Color Changed")
	GameGlobals.lastCardPlayed.card_color = color
	
func TriggerSpecialCards(card : Card):
	if(PlayerTurn):
		if(GameGlobals.lastCardPlayed.card_type == Card.cardType.WILD) or (GameGlobals.lastCardPlayed.card_type == Card.cardType.WILD_DRAW_FOUR):
			choose_color.HideChooseColor()
		if(GameGlobals.lastCardPlayed.card_type == Card.cardType.WILD_DRAW_FOUR):
			for i in range(4):
				ai_hand.AddCard(deck.Draw())
		if(GameGlobals.lastCardPlayed.card_type == Card.cardType.DRAW_TWO):
			for i in range(2):
				ai_hand.AddCard(deck.Draw())
				
				
		player_hand.RemoveCard(card)
	else:
		if(GameGlobals.lastCardPlayed.card_type == Card.cardType.WILD_DRAW_FOUR):
			for i in range(4):
				player_hand.AddCard(deck.Draw())
		if(GameGlobals.lastCardPlayed.card_type == Card.cardType.DRAW_TWO):
			for i in range(2):
				player_hand.AddCard(deck.Draw())
				
				
	# Finalizar turno
	EndTurn()

func PlayerDrawsCard() -> void:
	player_hand.AddCard(deck.Draw())
	EndTurn()

func EndTurn() -> void:
	PlayerTurn = not PlayerTurn
	GameGlobals.playerTurn = not GameGlobals.playerTurn
