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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func pickupAndDrop(handPosition : Node3D):
	if holding:
		reparent(holdingRay.get_collider())
		position = holdingRay.get_collision_point() + Vector3(0, placementOffset, 0)
		holding = false
	
	else:
		reparent(handPosition, false)
		position = Vector3.ZERO
		rotation = rotationOffset
		scale = scaleOffset
		holding = true
