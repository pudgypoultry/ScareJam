extends Node3D

class_name DoorSlam

@export var slammedRotation = Vector3(90, -90, 0)
var currentTween : Tween

func _ready():
	slammedRotation = Vector3(deg_to_rad(slammedRotation.x), deg_to_rad(slammedRotation.y), deg_to_rad(slammedRotation.z))

func Slam():
	TweenRotation(slammedRotation, 0.25)


func TweenRotation(desiredRotation, desiredLength):
	currentTween = create_tween().bind_node(self)
	#currentTween.set_trans(Tween.TRANS_SINE)
	#currentTween.set_ease(Tween.EASE_IN_OUT)
	currentTween.tween_property(self, "rotation", desiredRotation, desiredLength)
