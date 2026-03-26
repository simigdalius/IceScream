extends Node2D

@onready var enemy = preload("res://game/target.tscn")
@onready var spawn_zone = $SpawnZone/CollisionShape2D

func _on_timer_timeout() -> void:
	var ene = enemy.instantiate()
	var shape_size = spawn_zone.shape.size
	var random_x = randf_range(-shape_size.x / 2, shape_size.x / 2)
	var random_y = randf_range(-shape_size.y / 2, shape_size.y / 2)
	ene.position = spawn_zone.global_position + Vector2(random_x, random_y)
	get_parent().get_node("popUP").add_child(ene)
	await get_tree().create_timer(3.0).timeout
	if is_instance_valid(ene):
		get_tree().call_group("rage","add_rage",10.0)
		ene.queue_free()
