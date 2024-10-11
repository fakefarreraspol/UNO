extends Node


var CardSelected
var mouseOnPlacement = false

var playerTurn = true
var lastCardPlayed : Card

func _CheckCardsCompatibility(card : Card) -> bool:
	if(lastCardPlayed != null):
		print("card "+str(card.GetCardDescription()) + " " + str(lastCardPlayed.GetCardDescription()))
	if(lastCardPlayed == null): return true
	elif(card.card_type == Card.cardType.WILD) or (card.card_type == Card.cardType.WILD_DRAW_FOUR): return true
	elif(card.card_color == lastCardPlayed.card_color): return true
	elif(card.cardNumber == lastCardPlayed.cardNumber): return true
	

	return false
