extends StaticBody3D

class_name MillHandler

@export_category("Node Plugins")
@export var oilDestination : Node3D
@export var collectibleOilObject : OilHandler
var oilTest = preload("res://Scenes/OilObject.tscn")
var amountOfOilToDispense : float
var amountOfTimeToFillBasin : float
var currentlySpawned : bool = false:
	set(value):
		currentlySpawned = value
	get:
		return currentlySpawned

# Take in a material that the player is holding, destory it, then start the process
# Assume we've already checked and made sure that the object being inserted is of a type that can be ground up
func TakeInMaterial(amountOfOil : float, amountOfTime : float):
	# Grab object's amount of oil
	amountOfOilToDispense = amountOfOil
	amountOfTimeToFillBasin = amountOfTime
	# Destroy that object, use its own destruction function
	ProcessMaterial(amountOfOilToDispense, amountOfTimeToFillBasin)


# Take the taken in material, wait an amount of time based on that material, then output an amount of oil
func ProcessMaterial(amountOfOil : float, amountOfTime : float):
	var oil = oilTest.instantiate()
	add_child(oil)
	print(oil)
	oil.position = oilDestination.position
	oil.PrepareMe(amountOfOil, amountOfTime, self)
	currentlySpawned = true
