extends Control

var cursor_scene = preload("res://UserInterface/cursor.tscn")
var current_cursor = null

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	hide()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		toggle_pause()

func toggle_pause():
	get_tree().paused = !get_tree().paused
	
	if get_tree().paused:
		current_cursor = cursor_scene.instantiate()
		add_child(current_cursor) 
		
		show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		unpause()

func unpause():
	# 2. Πλήρης διαγραφή του ποντικιού
	if current_cursor:
		current_cursor.queue_free()
		current_cursor = null
	
	hide()
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_button_2_pressed():
	unpause()

func _on_button_3_pressed():
	if current_cursor:
		current_cursor.queue_free()
	get_tree().paused = false
	Scenetransition.change_scene("res://UserInterface/mainMenu.tscn")
