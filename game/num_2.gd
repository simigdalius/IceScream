extends Sprite2D
@onready var animated = $AnimatedSprite2D
@onready var click = $"../../swstoclick"

func _ready() -> void:
	$AnimatedSprite2D.hide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("num2"):
		click.play()
		if is_pixel_opaque(get_local_mouse_position()):
			get_viewport().set_input_as_handled()
			start_death_animation()

func start_death_animation():
	$AnimatedSprite2D.show()
	self.texture = null 
	animated.play("fade2")
	await animated.animation_finished
	queue_free()
	
