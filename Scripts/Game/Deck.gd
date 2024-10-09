extends Node

var cards = []

func InitializeDeck() -> void:
	EmptyDeck()
	GenerateDeck()
	ShuffleDeck()
	#for card in cards:
		#print(card.GetCardDescription())

# Añadir 2 copias de cada carta en la baraja y añadir las cartas especiales
func GenerateDeck() -> void:
	for color in Card.cardColor.values():
		
		if color  == Card.cardColor.NONE: 
			continue
		else: print(color)
		for j in range(2):
			for i in range(0,10):
				cards.append(Card.new(color, i, Card.cardType.NUMBER))
				cards.append(Card.new(color, -1, Card.cardType.SKIP))
				cards.append(Card.new(color, -1, Card.cardType.DRAW_TWO))

	for i in range(4):
		cards.append(Card.new(Card.cardColor.NONE, -1, Card.cardType.WILD))
		cards.append(Card.new(Card.cardColor.NONE, -1, Card.cardType.WILD_DRAW_FOUR))

#barajar 
func ShuffleDeck() -> void:
	cards.shuffle()
	

#Sacar una carta del mazo
func Draw() -> Card:
	if cards.size() > 0:
		return cards.pop_back()
	return null

func EmptyDeck() -> void:
	cards.clear()
