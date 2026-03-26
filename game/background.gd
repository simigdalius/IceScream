extends Area2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
			print("lathos")
			get_tree().call_group("rage","add_rage",10.0)
			
