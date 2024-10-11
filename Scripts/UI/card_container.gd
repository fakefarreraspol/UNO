extends HBoxContainer

const CARD = preload("res://UI/Cards/Card.tscn")
var startPosition

func _ready() -> void:
	var projResH = ProjectSettings.get_setting("display/window/size/viewport_height")
	self.global_position.y = projResH - 80
	startPosition = self.global_position

func _on_mouse_entered() -> void:
	self.pivot_offset = Vector2(self.size.x/2, self.size.y/2)
	var targetPos = startPosition + Vector2(0,-100)
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween.tween_property(self, "position", targetPos, 0.2)
	tween2.tween_property(self, "scale", Vector2(1.3,1.3), 0.2)

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
