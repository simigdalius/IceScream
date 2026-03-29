extends Node2D
@onready var timer = $Timer
var total_time = 60

func _ready() -> void:
	update_label_text() 
	$Timer.start() 
	$Panel2.hide()
	$Panel2/Label.hide()
func _on_timer_timeout() -> void:
	if total_time > 0:
		total_time -= 1
		update_label_text()
		
		# Αλλαγή χρώματος στα τελευταία 10 δευτερόλεπτα
		if total_time <= 10:
			$time.modulate = Color(1, 0.3, 0.3) # Ανοιχτό κόκκινο
			
		if total_time == 0:
			time_up()

func update_label_text():
	$time.text = str(total_time)

func time_up():
	$Timer.stop()
	$time.text = "0"
	$time.modulate = Color(1, 0, 0) 
	screen_shake() 
	if has_node("ready"):
		$ready.show()
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://UserInterface/winner.tscn")
	
func screen_shake():
	var shake_tween = create_tween()
	var label = $time
	var original_pos = label.position
	for i in range(5):
		shake_tween.tween_property(label, "position", original_pos + Vector2(randf_range(-5, 5), randf_range(-3, 3)), 0.05)
		shake_tween.tween_property(label, "position", original_pos, 0.05)
