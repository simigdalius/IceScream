extends TextureButton

@export var sound_muted_img: Texture2D = preload("res://assets/Soundoff.png")
@export var sound_on_img: Texture2D = preload("res://assets/Soundon.png")

func _ready():
	_update_ui()

func _pressed():
	var master_id = AudioServer.get_bus_index("Master")
	var is_muted = AudioServer.is_bus_mute(master_id)
	AudioServer.set_bus_mute(master_id, !is_muted)
	_update_ui()
	
func _update_ui():
	var master_id = AudioServer.get_bus_index("Master")
	if AudioServer.is_bus_mute(master_id):
		texture_normal = sound_muted_img
	else:
		texture_normal = sound_on_img
