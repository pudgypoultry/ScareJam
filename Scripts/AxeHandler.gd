extends Node3D

class_name AxeHandler

@export_category("Plugging in Nodes")
@export var holdPosition : Node3D
@export var putAwayPosition : Node3D
@export var chopSound : AudioStreamPlayer3D

var currentTween : Tween


func Equip():
	print("Equipping!")
	visible = true
	TweenPosition(position+Vector3(-0.5, 1, -0.5), 0.7)
	TweenRotation(rotation+Vector3(2*PI/3, 0, -PI/6), 0.7)
	await get_tree().create_timer(0.7, true).timeout


func PutAway():
	print("Putting Away!")
	TweenPosition(position+Vector3(0.5, -1, 0.5), 0.7)
	TweenRotation(rotation+Vector3(-2*PI/3, 0, PI/6), 0.7)
	await get_tree().create_timer(0.4, true).timeout
	visible = false
	await get_tree().create_timer(0.3, true).timeout


func Chop():
	print("Chopping!")
	TweenPosition(position+Vector3(1,1,0.3), 0.8)
	TweenRotation(rotation+Vector3(PI/2, 0, 0), 0.8)
	await get_tree().create_timer(0.8, true).timeout
	TweenPosition(position+Vector3(-1,-1,-0.3), 0.2)
	TweenRotation(rotation+Vector3(-PI/2 - 1, 0.4, 0), 0.2)
	await get_tree().create_timer(0.2, true).timeout
	chopSound.play()
	TweenRotation(rotation+Vector3(1, -0.4, 0), 0.3)
	await get_tree().create_timer(0.3, true).timeout


func TweenPosition(desiredPosition, desiredLength):
	currentTween = create_tween().bind_node(self)
	currentTween.set_trans(Tween.TRANS_SINE)
	currentTween.set_ease(Tween.EASE_IN_OUT)
	currentTween.tween_property(self, "position", desiredPosition, desiredLength)


func TweenRotation(desiredRotation, desiredLength):
	currentTween = create_tween().bind_node(self)
	currentTween.set_trans(Tween.TRANS_SINE)
	currentTween.set_ease(Tween.EASE_IN_OUT)
	currentTween.tween_property(self, "rotation", desiredRotation, desiredLength)
