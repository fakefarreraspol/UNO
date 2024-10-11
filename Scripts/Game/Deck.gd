extends Node

var cards = []

func InitializeDeck() -> void:
	EmptyDeck() #Replay
	GenerateDeck()
	ShuffleDeck()

# Añadir 2 copias de cada carta en la baraja y añadir las cartas especiales
func GenerateDeck() -> void:
	for color in Card.cardColor.values():
		if color  == Card.cardColor.NONE: 
			continue
		
		cards.append(Card.new(color, 0, Card.cardType.NUMBER)) #only one 0 per color
		for j in range(2): #cartas numericas (2 x numero xc olor)
			for i in range(1,10):
				cards.append(Card.new(color, i, Card.cardType.NUMBER))
			# cartas especiales, 2 x color 
			# reverse no lo pongo ya que es 1vs1
			cards.append(Card.new(color, -10, Card.cardType.SKIP))
			cards.append(Card.new(color, -10, Card.cardType.DRAW_TWO))
	# Wild Cards
	for i in range(4):
		cards.append(Card.new(Card.cardColor.NONE, -10, Card.cardType.WILD))
		cards.append(Card.new(Card.cardColor.NONE, -10, Card.cardType.WILD_DRAW_FOUR))

#barajar 
func ShuffleDeck() -> void:
	cards.shuffle()
	

#Sacar una carta del mazo
func Draw() -> Card:
	if cards.size() > 0:
		return cards.pop_back()
	print("CardNull")
	return null

func EmptyDeck() -> void:
	cards.clear()
