extends Node3D

@export var rotationAmount : float = 1
var radRotationAmount

# Called when the node enters the scene tree for the first time.
func _ready():
	radRotationAmount = deg_to_rad(rotationAmount)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_object_local(Vector3(0, 1, 0), radRotationAmount/2)
