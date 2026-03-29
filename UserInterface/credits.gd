extends Control
@onready var click =$swstoclick
@onready var music = $music
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	click.play()
	Scenetransition.change_scene("res://UserInterface/mainMenu.tscn")
