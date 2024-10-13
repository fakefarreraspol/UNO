extends Node

signal last_card_changed(changedCard : Card)
var CardSelected
var mouseOnPlacement = false

var playerTurn = true
var lastCardPlayed : Card

func SetLastCard(card : Card) -> void:
	lastCardPlayed = card
	print("Card on Board changed!")
	emit_signal("last_card_changed", card)

func _CheckCardsCompatibility(card : Card) -> bool:
	if(lastCardPlayed != null):
		print("card "+str(card.GetCardDescription()) + "    lastCARD: " + str(lastCardPlayed.GetCardDescription()))
	if(lastCardPlayed == null): return true
	elif(card.card_type == Card.cardType.WILD) or (card.card_type == Card.cardType.WILD_DRAW_FOUR): return true
	elif(card.card_color == lastCardPlayed.card_color): return true
	elif(card.cardNumber == lastCardPlayed.cardNumber): 
		if (card.cardNumber > -1):
			return true
	if(card.card_type != Card.cardType.NUMBER): 
		print("Same type")
		if(card.card_type == lastCardPlayed.card_type): return true
	
	return false
