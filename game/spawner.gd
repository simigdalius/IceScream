extends Node2D
@onready var enemy = preload("res://game/target.tscn")

@onready var spawn_zone = $SpawnZone/CollisionShape2D


@onready var num = preload("res://game/num1.tscn")

@onready var num2 = preload("res://game/num2.tscn")

@onready var num3 = preload("res://game/num3.tscn") 
func _on_timer_timeout() -> void:
	var ene = enemy.instantiate()
	var nu = num.instantiate()
	var nu2 = num2.instantiate()
	var nu3 = num3.instantiate()
	
	var spawn_list = [ene, nu, nu2, nu3]
	spawn_list.shuffle()
	
	var shape_size = spawn_zone.shape.size
	for item in spawn_list:
		var rx = randf_range(-shape_size.x / 2, shape_size.x / 2)
		var ry = randf_range(-shape_size.y / 2, shape_size.y / 2)
		item.position = spawn_zone.global_position + Vector2(rx, ry)
	
	var popup_node = get_parent().get_node("popUP")
	for item in spawn_list:
		popup_node.add_child(item)
		await get_tree().create_timer(randf_range(0.5, 0.8)).timeout
	await get_tree().create_timer(randf_range(3, 3.5)).timeout
	var objects_to_check = [ene, nu, nu2, nu3]
	for obj in objects_to_check:
		if is_instance_valid(obj):
			if is_inside_tree() and get_tree().get_node_count_in_group("rage") > 0:
				get_tree().call_group("rage", "add_rage", 20.0)
				obj.queue_free()
