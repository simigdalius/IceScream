extends CanvasLayer

@onready var colorrect: ColorRect = $ColorRect
var scenetoLoad: String
var tween: Tween

func _ready() -> void:
	# Αρχική κατάσταση: Τελείως αόρατο και το ποντίκι το αγνοεί
	colorrect.modulate.a = 0.0
	colorrect.visible = false
	colorrect.mouse_filter = Control.MOUSE_FILTER_IGNORE

func change_scene(scene_path: String) -> void:
	if tween and tween.is_running():
		tween.kill()
	
	scenetoLoad = scene_path
	
	# 1. Εμφάνιση και ΜΠΛΟΚΑΡΙΣΜΑ ποντικιού (για να μην πατάει ο παίκτης διπλά κουμπιά)
	colorrect.visible = true
	colorrect.mouse_filter = Control.MOUSE_FILTER_STOP
	
	# Σιγουρέψου ότι το CanvasLayer -> Process -> Mode είναι "Always" στο Inspector
	get_tree().paused = true 
	
	tween = create_tween().set_trans(Tween.TRANS_SINE).set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	
	# 2. Fade In
	tween.tween_property(colorrect, "modulate:a", 1.0, 0.3)
	
	# 3. Αλλαγή Σκηνής
	tween.tween_callback(_load_new_scene)
	
	# 4. Fade Out
	tween.tween_property(colorrect, "modulate:a", 0.0, 0.3)
	
	# 5. ΤΕΛΙΚΟ ΞΕΚΛΕΙΔΩΜΑ (Εδώ είναι η λύση για το ποντίκι)
	tween.tween_callback(func(): 
		colorrect.visible = false
		colorrect.mouse_filter = Control.MOUSE_FILTER_IGNORE
		get_tree().paused = false # Ξεπαγώνουμε σίγουρα εδώ αν κάτι πήγε στραβά
	)

func _load_new_scene() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(scenetoLoad)
