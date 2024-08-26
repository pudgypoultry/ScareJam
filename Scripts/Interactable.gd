extends Node3D

class_name Interactable

@export var grindable = true
@export var holding = true

@export_category("Positioning")
@export var placementOffset : float = 0.0
@export var rotationOffset : Vector3 = Vector3(0, -163.4, 0)
@export var scaleOffset : Vector3 = Vector3(0.242, 0.242, 0.242)

@export_category("Plugging In Objects")
@export var holdingRay : RayCast3D
@export var collisionArea : Area3D
@export var collisionNode : CollisionShape3D


# Called when the node enters the scene tree for the first time.
func _ready():
	if holding:
		collisionNode.set_disabled(false)
	else:
		collisionNode.set_disabled(true)



func PickupAndDrop(handPosition : Node3D):
	if holding:
		reparent(holdingRay.get_collider())
		position = holdingRay.get_collision_point() + Vector3(0, placementOffset, 0)
		holding = false
		collisionNode.set_disabled(false)
		print_debug(self.name, " should be enabled now")
	
	else:
		reparent(handPosition, false)
		position = Vector3.ZERO
		rotation = rotationOffset
		scale = scaleOffset
		holding = true
		collisionNode.set_disabled(true)
		print_debug(self.name, " should be disabled now")
