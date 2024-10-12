extends HBoxContainer

const CARD = preload("res://UI/Cards/Card.tscn")
var startPosition
var maxCardsAllowed = 15

func _ready() -> void:
	self.size.x = maxCardsAllowed * 74
	UpdatePivot()
	var projResH = ProjectSettings.get_setting("display/window/size/viewport_height")
	var projResW = ProjectSettings.get_setting("display/window/size/viewport_width")
	position.y = projResH - 80
	startPosition = self.position


func _on_mouse_entered() -> void:
	var targetPos = startPosition + Vector2(0,-100)
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween.tween_property(self, "position", targetPos, 0.2)
	tween2.tween_property(self, "scale", Vector2(1.1,1.1), 0.2)

func AddCard(card : Card):
	if card == null:
		print("ERROR: 'card' is null in AddCard")
		return
	var cardInstance = CARD.instantiate()
	add_child(cardInstance)
	cardInstance.InitCard(card)
	


func _on_mouse_exited() -> void:
	if !GameGlobals.CardSelected:
		var tween = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		tween.tween_property(self, "position", startPosition, 0.2)
		tween2.tween_property(self, "scale", Vector2(1,1), 0.2)


func _on_child_exiting_tree(node: Node) -> void:
	print("XD")
	pass

func UpdatePivot() -> void:
	self.pivot_offset.x = maxCardsAllowed * 37
