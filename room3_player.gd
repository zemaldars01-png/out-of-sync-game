extends Node2D

var switches_activated := 0
var exit_unlocked := false


func _ready() -> void:
	var sprite = $Player/Sprite2D

	if CharacterData.selected_character == "girl":
		sprite.texture = load("res://girl.png")
		sprite.scale = Vector2(0.13, 0.13)
	else:
		sprite.texture = load("res://boy.png")
		sprite.scale = Vector2(0.18, 0.18)


func switch_activated():
	switches_activated += 1

	print("SWITCHES: ", switches_activated, "/3")

	if switches_activated >= 3:
		exit_unlocked = true
		$DoorStatus.text = "UNLOCKED"
	else:
		$DoorStatus.text = "SYNC: " + str(switches_activated) + "/3"


func _on_exit_door_body_entered(body: Node2D) -> void:
	print("EXIT TOUCHED BY: ", body.name)

	if body.name == "Player" and exit_unlocked:
		print("GOING TO ROOM COMPLETE")
		get_tree().change_scene_to_file("res://room_complete.tscn")
