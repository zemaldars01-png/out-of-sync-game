extends Area2D

var start_position: Vector2
var move_speed := 120.0
var move_range := 140.0
var direction := 1.0


func _ready():
	start_position = position


func _process(delta):
	var player = get_parent().get_node_or_null("Player")

	# Key lene ke baad lasers thore slow ho jayenge
	if player != null and player.get_meta("has_key", false):
		move_speed = 70.0
	else:
		move_speed = 120.0

	# Laser2 left-right move karega
	if name == "Laser2":
		position.x += move_speed * direction * delta

		if position.x > start_position.x + move_range:
			direction = -1.0
		elif position.x < start_position.x - move_range:
			direction = 1.0

	# Laser3 up-down move karega
	elif name == "Laser3":
		position.y += move_speed * direction * delta

		if position.y > start_position.y + move_range:
			direction = -1.0
		elif position.y < start_position.y - move_range:
			direction = 1.0


func _on_body_entered(body):
	if body.name == "Player":
		var tree = Engine.get_main_loop() as SceneTree
		tree.reload_current_scene()
