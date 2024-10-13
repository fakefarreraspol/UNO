extends AudioStreamPlayer

const BLUE_SFX = preload("res://Audio/blue_sfx.mp3")
const GREEN_SFX = preload("res://Audio/Green_sfx.mp3")
const RED_SFX = preload("res://Audio/red_sfx.mp3")
const YELLOW_SFX = preload("res://Audio/yellow_sfx.mp3")

func PlaySound(color : Card.cardColor):
	if color == Card.cardColor.RED:
		stream = RED_SFX
	elif color == Card.cardColor.BLUE:
		stream = BLUE_SFX
	elif color == Card.cardColor.GREEN:
		stream = GREEN_SFX
	elif color == Card.cardColor.YELLOW:
		stream = YELLOW_SFX
		
	play()
