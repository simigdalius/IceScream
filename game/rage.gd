extends Control

@export var back_bar: TextureProgressBar
@export var front_bar: TextureProgressBar

@export var is_rage: bool = false
@export var low_rage_pulse: bool = true
@export var angry_shake: bool = true

var current_pct := 0.0 # Ξεκινάμε στο 0
var front_tween: Tween
var back_tween: Tween
var pulse_tween: Tween = null

func _ready() -> void:
	front_bar.value = 0
	back_bar.value = 0
	current_pct = 0.0
	front_bar.max_value = 100
	back_bar.max_value = 100

func _input(event):
	# Πατώντας Space, προσομοιώνουμε ένα missclick (+10 Rage)
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_SPACE:
			add_rage(10.0)

func update_bar(current: float, max_value: float):
	var pct = clamp(current / max_value, 0.0, 1.0)
	front_bar.max_value = max_value
	back_bar.max_value = max_value
	
	var is_rage_increase = pct > current_pct # Το Rage ΑΝΕΒΑΙΝΕΙ (Missclick ή Timeout)
	var is_calm_down = pct < current_pct     # Το Rage ΠΕΦΤΕΙ (π.χ. σωστό κλικ)
	
	if is_rage_increase:
		if front_tween and front_tween.is_running(): front_tween.kill()
		if back_tween and back_tween.is_running(): back_tween.kill()
		
		# Όταν θυμώνει, η μπάρα γεμίζει γρήγορα
		front_tween = create_tween().set_parallel()
		front_tween.tween_property(front_bar, "value", current, 0.25)
		front_tween.tween_property(back_bar, "value", current, 0.25)
		
		_on_rage() # Καλεί το shake και το κόκκινο χρώμα!
		
	elif is_calm_down:
		if front_tween and front_tween.is_running(): front_tween.kill()
		if back_tween and back_tween.is_running(): back_tween.kill()
		
		# Όταν ηρεμεί, η μπροστά μπάρα πέφτει αμέσως και η πίσω ακολουθεί (trail effect)
		front_bar.value = current
		back_tween = create_tween()
		back_tween.tween_property(back_bar, "value", current, 0.45)
		
		_on_heal() # Καλεί το πράσινο χρώμα
		
	current_pct = pct
	_check_pulse(pct)

func _shake():
	var original_pos = position
	var tw = create_tween()
	tw.tween_property(self, "position", original_pos + Vector2(4, 0), 0.05)
	tw.tween_property(self, "position", original_pos - Vector2(4, 0), 0.05)
	tw.tween_property(self, "position", original_pos, 0.05)

func _flash(flash_color: Color):
	modulate = flash_color
	var t = create_tween()
	t.tween_property(self, "modulate", Color(1, 1, 1), 0.2)
	
func _on_rage():
	_flash(Color(1, 0.3, 0.3)) # Κόκκινο
	if angry_shake:
		_shake()

func _on_heal():
	_flash(Color(0.3, 1, 0.3)) # Πράσινο

func _check_pulse(pct: float) -> void:
	# Άλλαξα τη λογική: Το pulse ξεκινάει όταν το Rage είναι ΚΡΙΣΙΜΑ ΨΗΛΑ (πάνω από 75%)
	if pct >= 0.75 and low_rage_pulse:
		if pulse_tween == null or not pulse_tween.is_running():
			if pulse_tween:
				pulse_tween.kill()
			
			pulse_tween = create_tween()
			pulse_tween.set_loops()
			pulse_tween.tween_property(self, "scale", Vector2(1.04, 1.04), 0.2)
			pulse_tween.tween_property(self, "scale", Vector2(1.00, 1.00), 0.2)
	else:
		scale = Vector2.ONE
		if pulse_tween and pulse_tween.is_running():
			pulse_tween.kill()
			pulse_tween = null

func add_rage(amount: float):
	var new_value = back_bar.value + amount
	update_bar(new_value, back_bar.max_value)

# Πρόσθεσα και αυτή τη συνάρτηση σε περίπτωση που θες να αφαιρείς rage με σωστά clicks!
func remove_rage(amount: float):
	var new_value = back_bar.value - amount
	update_bar(new_value, back_bar.max_value)
