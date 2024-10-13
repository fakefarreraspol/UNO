extends Node

signal last_card_changed(changedCard : Card)
var CardSelected
var mouseOnPlacement = false

var playerTurn = true
var lastCardPlayed : Card

func SetLastCard(card : Card) -> void:
	lastCardPlayed = card
	print("Card on Board changed!" + card.GetCardDescription())
	emit_signal("last_card_changed", card)

func _CheckCardsCompatibility(card : Card) -> bool:
	if(lastCardPlayed != null):
		print("card "+str(card.GetCardDescription()) + "    lastCARD: " + str(lastCardPlayed.GetCardDescription()))
	if(lastCardPlayed == null): return true
	elif(card.card_type == Card.cardType.WILD) or (card.card_type == Card.cardType.WILD_DRAW_FOUR): 
		print("WILD CARD")
		return true
	elif(card.card_color == lastCardPlayed.card_color): 
		print("SAME COLOR")
		return true
	elif(card.cardNumber == lastCardPlayed.cardNumber): 
		print("SAME NUMBER")
		if (card.cardNumber > -1):
			return true
	if(card.card_type != Card.cardType.NUMBER): 
		print("TYPE IS NUMBER")
		if(card.card_type == lastCardPlayed.card_type): 
			print("SAME TYPE")
			return true
	
	return false
