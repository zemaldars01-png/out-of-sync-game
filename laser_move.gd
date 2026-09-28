extends Area2D

@export var move_horizontally: bool = true
@export var move_distance: float = 120.0
@export var move_speed: float = 2.0

var start_position: Vector2
var player
var player_start_position: Vector2
var time_passed: float = 0.0


func _ready():
	start_position = position

	player = get_tree().current_scene.get_node("Player")
	player_start_position = player.global_position

	body_entered.connect(_on_body_entered)


func _process(delta):
	time_passed += delta * move_speed

	var offset = sin(time_passed) * move_distance

	if move_horizontally:
		position.x = start_position.x + offset
	else:
		position.y = start_position.y + offset


func _on_body_entered(body):
	if body == player:
		body.global_position = player_start_position

		if body is CharacterBody2D:
			body.velocity = Vector2.ZERO
