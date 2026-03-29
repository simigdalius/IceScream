extends Control
@onready var music = $music
@onready var click =$swstoclick
func unpause():
	$".".hide()
	get_tree().paused = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_2_pressed() -> void:
	unpause()


func _on_button_3_pressed() -> void:
	click.play()
	Scenetransition.change_scene("res://UserInterface/mainMenu.tscn")
