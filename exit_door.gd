extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		if body.get_meta("has_key", false):
			get_tree().change_scene_to_file("res://title_screen.tscn")
