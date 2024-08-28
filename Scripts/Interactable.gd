extends Node3D

class_name Interactable

@export var grindable = true
@export var holding = true

@export_category("Positioning")
@export var placementOffset : float = 0.0
@export var rotationOffset : Vector3 = Vector3(0, -163.4, 0)
@export var scaleOffset : Vector3 = Vector3(0.242, 0.242, 0.242)

@export_category("Plugging In Objects")
@export var collisionArea : Area3D
@export var collisionNode : CollisionShape3D


# Called when the node enters the scene tree for the first time.
func _ready():
	if holding:
		collisionNode.set_disabled(false)
	else:
		collisionNode.set_disabled(true)
