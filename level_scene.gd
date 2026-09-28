extends Control

func _on_boy_button_pressed() -> void:
	CharacterData.selected_character = "boy"
	print("BOY CLICKED")
	get_tree().change_scene_to_file("res://level2.tscn")

func _on_girl_button_pressed() -> void:
	CharacterData.selected_character = "girl"
	print("GIRL CLICKED")
	get_tree().change_scene_to_file("res://level2.tscn")
