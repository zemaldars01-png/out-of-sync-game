extends CharacterBody2D

var speed = 250.0
var pickup_distance = 120.0
var exit_distance = 40.0


func _ready() -> void:
	var sprite = $Sprite2D

	if CharacterData.selected_character == "girl":
		sprite.texture = load("res://girl.png")
		sprite.scale = Vector2(0.13, 0.13)
	else:
		sprite.texture = load("res://boy.png")
		sprite.scale = Vector2(0.18, 0.18)


func _physics_process(_delta):
	var direction = Input.get_vector(
		"ui_left",
		"ui_right",
		"ui_up",
		"ui_down"
	)

	velocity = direction * speed
	move_and_slide()

	check_for_key()
	check_for_exit()


func check_for_key():
	var level = get_parent()
	var key = level.get_node_or_null("Key")

	if key == null:
		return

	if global_position.distance_to(key.global_position) < pickup_distance:
		set_meta("has_key", true)
		key.queue_free()

		var door_status = level.get_node_or_null("DoorStatus")

		if door_status != null:
			door_status.text = "DOOR UNLOCKED"


func check_for_exit():
	if not get_meta("has_key", false):
		return

	var level = get_parent()
	var exit_point = level.get_node_or_null("ExitPoint")

	if exit_point == null:
		return

	if global_position.distance_to(exit_point.global_position) < exit_distance:
		var door_status = level.get_node_or_null("DoorStatus")

		if door_status != null:
			door_status.text = "YOU ESCAPED!"

		velocity = Vector2.ZERO
		set_physics_process(false)

		await get_tree().create_timer(1.0).timeout

		get_tree().change_scene_to_file("res://room_complete.tscn")
