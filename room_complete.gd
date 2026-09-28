extends Control

@onready var continue_button = $ContinueButton
@onready var sparkle = $ContinueButton/Sparkle
@onready var sparkle2 = $ContinueButton/Sparkle2
@onready var sparkle3 = $ContinueButton/Sparkle3
@onready var sparkle4 = $ContinueButton/Sparkle4


func _ready() -> void:
	sparkle.visible = false
	sparkle2.visible = false
	sparkle3.visible = false
	sparkle4.visible = false


func _on_continue_button_mouse_entered() -> void:
	sparkle.visible = true
	sparkle2.visible = true
	sparkle3.visible = true
	sparkle4.visible = true


func _on_continue_button_mouse_exited() -> void:
	sparkle.visible = false
	sparkle2.visible = false
	sparkle3.visible = false
	sparkle4.visible = false


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
