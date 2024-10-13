extends Node

@onready var deck = $"../DECK"
@onready var end_menu: Control = $"../Camera2D/EndMenu"
@onready var choose_color: Control = $"../Camera2D/ChooseColor"
@onready var draw_card: Control = $"../Camera2D/DrawCard"
@onready var uno_button: Control = $"../Camera2D/UnoButton"


@onready var player: Node = $"../Player"
@onready var player_hand = $"../Player/PlayerHand"
@onready var ai_player: Node = $"../AIPlayer"
@onready var ai_hand = $"../AIPlayer/AIHand"

var PlayerTurn = true #false if is AI turn
var unoButtonPressed = false

func _ready() -> void:
	StartGame()
	choose_color.color_changed.connect(Callable(ChangeLastColorCard).bind())
	GameGlobals.last_card_changed.connect(Callable(ProcessCards).bind())
	draw_card.card_drawn.connect(Callable(PlayerDrawsCard))
	ai_player.ai_draw_card.connect(Callable(AIDrawsCard))
	uno_button.button_pressed.connect(Callable(OnUNOButtonPressed))

func StartGame() -> void:
	deck.InitializeDeck() #create deck
	ai_hand.ClearAllCards() #Replay
	player_hand.ClearAllCards() #Replay
	
	print(str(len(deck.cards)))
	for i in range(2): 
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

func ProcessCards(card : Card):
	if(PlayerTurn):
		player_hand.RemoveCard(card)
		if len(player_hand.handCards) == 1 :
			unoButtonPressed = false
			uno_button.HideUNOButton()
			await get_tree().create_timer(2).timeout
			if(!unoButtonPressed): 
				for i in range(4):
					player_hand.AddCard(deck.Draw())
			uno_button.HideUNOButton()
			TriggerSpecialCards(card)
		else: TriggerSpecialCards(card)

	else: TriggerSpecialCards(card)


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

	else:
		if(GameGlobals.lastCardPlayed.card_type == Card.cardType.WILD_DRAW_FOUR):
			for i in range(4):
				player_hand.AddCard(deck.Draw())
		if(GameGlobals.lastCardPlayed.card_type == Card.cardType.DRAW_TWO):
			for i in range(2):
				player_hand.AddCard(deck.Draw())
	#Check skip card
	if(GameGlobals.lastCardPlayed.card_type != Card.cardType.SKIP):
		# Finalizar turno
		EndTurn(true)
	else: EndTurn(false)

func PlayerDrawsCard() -> void:
	player_hand.AddCard(deck.Draw())
	EndTurn(true)
	
func AIDrawsCard() -> void:
	ai_hand.AddCard(deck.Draw())
	EndTurn(true)

func EndTurn(change) -> void:
	if(change):
		PlayerTurn = not PlayerTurn
		GameGlobals.playerTurn = not GameGlobals.playerTurn
	ai_player.TurnChanged()

func OnUNOButtonPressed() -> void:
	unoButtonPressed = true
