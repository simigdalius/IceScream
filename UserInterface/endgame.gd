extends Node2D

var parent_node
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	parent_node = get_parent().get_node("popUP")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if parent_node.get_child_count() == 0:
		get_tree().change_scene_to_file("res://UserInterface/rageending.tscn")
