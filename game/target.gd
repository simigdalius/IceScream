extends Sprite2D
@onready var animated = $AnimatedSprite2D
@onready var click = $"../../swstoclick"


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		click.play()
		if is_pixel_opaque(get_local_mouse_position()):
			get_viewport().set_input_as_handled()
			start_death_animation()

func start_death_animation():
	self.texture = null 
	animated.play("onclickPopup")
	await animated.animation_finished
	queue_free()
