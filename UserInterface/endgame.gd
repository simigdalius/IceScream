extends Node2D

var parent_node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent_node = get_parent().get_node("popUP")
	$"../Sprite2D".hide()
	$"../Sprite2D2".hide()
	$"../Sprite2D3".hide()
	$"../Sprite2D4".hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Sprite2D3 == null:
		$"../Sprite2D".show()
	if $Sprite2D2 == null:
		$"../Sprite2D2".show()
	if $Sprite2D == null:
		$"../Sprite2D3".show()
	if $target == null:
		$"../Sprite2D4".show()
	if parent_node.get_child_count() == 0:
		Scenetransition.change_scene("res://UserInterface/rageending.tscn")
