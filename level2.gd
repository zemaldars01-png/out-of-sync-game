extends Control

var keys_collected: int = 0
var total_keys: int = 5
var time_left: int = 25

var level_finished: bool = false
var door_ready: bool = false
var changing_scene: bool = false

var keys: Array = []


func _ready() -> void:
	# =========================
	# HUD
	# =========================
	$HUDPanel/LevelLabel.text = "LEVEL 1"
	$HUDPanel/KeyCounter.text = "KEYS: 0/5"
	$HUDPanel/TimerLabel.text = "TIME: 25"

	# =========================
	# PLAYER
	# =========================
	var player = $Player
	var sprite = $Player/Sprite2D

	player.show()
	sprite.show()

	player.position = Vector2(575, 470)
	sprite.position = Vector2.ZERO

	sprite.z_as_relative = false
	sprite.z_index = 100
	sprite.modulate = Color(1.15, 1.15, 1.15)

	# Character image + size
	if CharacterData.selected_character == "boy":
		sprite.texture = load("res://boy.png")
		sprite.scale = Vector2(0.18, 0.18)
	else:
		sprite.texture = load("res://girl.png")
		sprite.scale = Vector2(0.13, 0.13)

	# =========================
	# DOOR START STATE
	# =========================
	$ExitLabel.text = "LOCKED"
	$ExitLabel.show()

	if has_node("DoorButton"):
		$DoorButton.hide()

	# =========================
	# KEYS
	# =========================
	keys = [
		$Key1,
		$Key2,
		$Key3,
		$Key4,
		$Key5
	]

	# Visible key positions ko correct parent positions bana do
	for key in keys:
		var key_sprite = key.get_node("Sprite2D")
		var visible_position = key_sprite.global_position

		key.global_position = visible_position
		key_sprite.position = Vector2.ZERO

	# =========================
	# TIMER
	# =========================
	$Timer.wait_time = 1.0
	$Timer.one_shot = false

	if not $Timer.timeout.is_connected(_on_timer_timeout):
		$Timer.timeout.connect(_on_timer_timeout)

	$Timer.start()


func _process(_delta: float) -> void:
	if changing_scene:
		return

	# =========================
	# KEY PICKUP
	# =========================
	if not level_finished:
		for key in keys:
			if not key.visible:
				continue

			var distance = $Player.global_position.distance_to(
				key.global_position
			)

			if distance < 75:
				collect_key(key)

	# =========================
	# AUTO DOOR ENTRY
	# =========================
	if door_ready and keys_collected >= total_keys:
		var door_distance = $Player.global_position.distance_to(
			$DoorButton.global_position
		)

		if door_distance < 110:
			changing_scene = true
			get_tree().change_scene_to_file("res://Room3.tscn")


# =========================
# KEY PICKUP
# =========================
func collect_key(key) -> void:
	if level_finished:
		return

	if not key.visible:
		return

	key.hide()
	keys_collected += 1

	print("COLLECTED: ", key.name)

	$HUDPanel/KeyCounter.text = \
		"KEYS: " + str(keys_collected) + "/5"

	# Small glitch flash
	modulate = Color(1.0, 0.55, 1.0)

	await get_tree().create_timer(0.10).timeout

	modulate = Color.WHITE

	if keys_collected >= total_keys:
		unlock_exit()


# =========================
# EXIT UNLOCK
# =========================
func unlock_exit() -> void:
	level_finished = true
	$Timer.stop()

	$HUDPanel/LevelLabel.text = "UNLOCKED!"
	$ExitLabel.text = "UNLOCKED"
	$ExitLabel.show()

	if has_node("DoorButton"):
		$DoorButton.show()

	# UNLOCKED text thori der clearly show ho
	await get_tree().create_timer(0.8).timeout

	door_ready = true


# =========================
# DOOR CLICK BACKUP
# =========================
func _on_door_button_pressed() -> void:
	if keys_collected >= total_keys and door_ready and not changing_scene:
		changing_scene = true
		get_tree().change_scene_to_file("res://Room3.tscn")


# =========================
# TIMER
# =========================
func _on_timer_timeout() -> void:
	if level_finished:
		return

	time_left -= 1

	$HUDPanel/TimerLabel.text = \
		"TIME: " + str(time_left)

	if time_left <= 0:
		$Timer.stop()

		$HUDPanel/LevelLabel.text = "SYSTEM RESET..."

		await get_tree().create_timer(0.8).timeout

		get_tree().reload_current_scene()


# =========================
# RESTART
# =========================
func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
