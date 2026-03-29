extends Area2D

var z: int = 0  
var labels: Array = []

@onready var panel2 = $"../Panel2"
@onready var timer = $Timer
func _ready() -> void:
	if timer:
		timer.start()
	else:
		print("Error: Το Timer node δεν βρέθηκε!")
	panel2.hide()
	
	labels = [
		panel2.get_node("Label"),
		panel2.get_node("Label2"),
		panel2.get_node("Label3"),
		panel2.get_node("Label4"),
		panel2.get_node("Label5"),
		panel2.get_node("Label6"),
		panel2.get_node("Label7")
	]
	
	hide_all_labels()

func _input(event: InputEvent) -> void:
	# Λίστα με τα actions που αυξάνουν το rage
	var rage_actions = ["click", "num1", "num2", "num3"]
	
	for action in rage_actions:
		if event.is_action_pressed(action):
			get_tree().call_group("rage", "add_rage", 10.0)
			
			if action == "click":
				$"../Timer2".start()
				panel2.show()
				krazw(z)
				z = (z + 1) % labels.size() 
				print("Lathos! Current index: ", z)
				$"../Timer2".start()

func hide_all_labels():
	for l in labels:
		l.hide()

func krazw(index: int):
	hide_all_labels() 
	if index < labels.size():
		labels[index].show() 


func _on_timer_2_timeout() -> void:
	get_tree().call_group("rage", "remove_rage", 30.0)
