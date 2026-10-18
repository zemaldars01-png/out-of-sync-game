
extends Control

@onready var continue_button = $ContinueButton

func _on_continue_button_pressed() -> void:
	continue_button.disabled = true
	continue_button.pivot_offset = continue_button.size / 2

	var tween = create_tween()

	tween.tween_property(
		continue_button,
		"scale",
		Vector2(1.10, 1.10),
		0.12
	)

	tween.tween_property(
		continue_button,
		"scale",
		Vector2(1.0, 1.0),
		0.12
	)

	await tween.finished
	await get_tree().create_timer(0.15).timeout

	get_tree().change_scene_to_file("res://final_ending.tscn")
