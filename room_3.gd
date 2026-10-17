extends Node2D

var switches_activated := 0
var exit_unlocked := false


func _ready():
	var sprite = $Player/Sprite2D

	if CharacterData.selected_character == "boy":
		sprite.texture = load("res://boycanva.png")
		sprite.scale = Vector2(0.09, 0.09)
	else:
		sprite.texture = load("res://girlcanva.png")
		sprite.scale = Vector2(0.09, 0.09)

	$Player.show()
	sprite.show()

	$DoorStatus.text = "SYNC: 0/3"


func switch_activated():
	switches_activated += 1

	print("SWITCHES: ", switches_activated, "/3")

	if switches_activated >= 3:
		exit_unlocked = true
		$DoorStatus.text = "UNLOCKED"

		# agar player already exit area ke andar hai
		for body in $ExitDoor.get_overlapping_bodies():
			if body.name == "Player":
				print("PLAYER ALREADY AT EXIT")
				get_tree().change_scene_to_file("res://room_complete.tscn")
				return
	else:
		$DoorStatus.text = "SYNC: " + str(switches_activated) + "/3"


func _on_exit_door_body_entered(body: Node2D) -> void:
	print("EXIT TOUCHED BY: ", body.name)

	if body.name == "Player" and exit_unlocked:
		print("GOING TO ROOM COMPLETE")
		get_tree().change_scene_to_file("res://room_complete.tscn")
