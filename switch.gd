extends Area2D

@export var target_laser_name: String = "Laser 1"

var activated := false


func _ready():
	body_entered.connect(_on_body_entered)


func _on_body_entered(body):
	if activated:
		return

	if body.name == "Player":
		activated = true

		var laser = get_parent().get_node(target_laser_name)

		if laser:
			laser.visible = false
			laser.set_process(false)
			laser.set_deferred("monitoring", false)

		visible = false
		$CollisionShape2D.set_deferred("disabled", true)

		get_parent().switch_activated()
