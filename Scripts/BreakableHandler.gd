extends StaticBody3D

class_name BreakableHandler

@export var grindableToProvide : Area3D
@export var itemStrength = 3
@export var grindablesProvided : int = 1
@export var positionToInstantiate0 : Node3D = null
@export var positionToInstantiate1 : Node3D = null
@export var positionToInstantiate2 : Node3D = null
var positionsToInstantiate : Array[Node3D]
var sceneRoot : Node3D
var grindableTestScene = preload("res://Scenes/GrindableObject.tscn")

func _ready():
	print("Before: ", positionsToInstantiate)
	positionsToInstantiate.append(positionToInstantiate0)
	positionsToInstantiate.append(positionToInstantiate1)
	positionsToInstantiate.append(positionToInstantiate2)
	print("After: ", positionsToInstantiate)

func BreakMe():
	if itemStrength > 0:
		itemStrength -= 1
		print_debug(name, "'s current itemStrength: ", itemStrength)
	else:
		var i = 0
		while i < grindablesProvided:
			var currentGrindable = grindableTestScene.instantiate()
			get_tree().current_scene.add_child(currentGrindable)
			currentGrindable.position = positionsToInstantiate[i].global_position
			currentGrindable.rotation = positionsToInstantiate[i].rotation
			print(currentGrindable.position, " : ", currentGrindable.get_parent())
			i += 1
		queue_free()
