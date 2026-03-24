extends Sprite2D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		if is_pixel_opaque(get_local_mouse_position()):
			get_viewport().set_input_as_handled()
			print("sprite clicked")
			queue_free()
