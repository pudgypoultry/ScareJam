extends StaticBody3D

class_name BreakableHandler
@export_category("Tooltip")
@export var tooltipText : String = "(E) to chop"

@export_category("Interaction Rules")
@export var grindableToProvide : Area3D
@export var itemStrength = 3
@export var positionsToInstantiate : Array[Node3D] = []

@export_category("Player Feedback")
@export var soundEffect : Array[AudioEffect] = []
@export var fullHealthMesh : MeshInstance3D
@export var damagedMesh : MeshInstance3D
@export var destroyedMesh : MeshInstance3D

@export_category("Plugging in Nodes")
@export var grindableTestScene = preload("res://Scenes/GrindableObject.tscn")

var sceneRoot : Node3D
var grindablesProvided : int = 1
var rng = RandomNumberGenerator.new()


func _ready():
	grindablesProvided = len(positionsToInstantiate)


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
			currentGrindable.rotation = positionsToInstantiate[i].rotation + Vector3(0, rng.randf_range(0, 2*PI), 0)
			print(currentGrindable.position, " : ", currentGrindable.get_parent())
			i += 1
		queue_free()
