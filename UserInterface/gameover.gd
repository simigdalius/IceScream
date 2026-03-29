extends Control
@onready var music = $music
@onready var click =$swstoclick
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_quit_pressed() -> void:
	click.play()
	Scenetransition.change_scene("res://UserInterface/mainMenu.tscn")


func _on_ragequit_pressed() -> void:
	click.play()
	Scenetransition.change_scene("res://UserInterface/endgame.tscn")
