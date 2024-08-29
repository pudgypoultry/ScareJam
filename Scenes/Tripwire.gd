extends Area3D

class_name Tripwire

@export var stoneStairs : Node3D
@export var theDoor : Node3D
@export var doorSlam : AudioStreamPlayer3D

func _on_body_entered(body: Node3D) -> void:
	theDoor.Slam()
	await get_tree().create_timer(0.5, true).timeout
	stoneStairs.visible = true
	queue_free()
