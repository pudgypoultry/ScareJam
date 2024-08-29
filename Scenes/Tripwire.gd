extends Area3D

class_name Tripwire

@export var stoneStairs : Node3D
@export var theDoor : Node3D
@export var doorSlam : AudioStreamPlayer3D
@export var doorCollider : CollisionShape3D

func _on_body_entered(body: Node3D) -> void:
	theDoor.Slam()
	await get_tree().create_timer(0.25, true).timeout
	doorSlam.play()
	doorCollider.disabled = false
	stoneStairs.visible = true
	queue_free()
