extends StaticBody3D

class_name MillHandler

@export_category("Tooltip")
@export var tooltipText : String = "(E) to grind object into oil"

@export_category("Node Plugins")
@export var oilDestination : Node3D
@export var collectibleOilObject : OilHandler

@export var oilTest = preload("res://Scenes/Oil/OilObject.tscn")
var amountOfOilToDispense : float
var amountOfTimeToFillBasin : float
var currentlySpawned : bool = false:
	set(value):
		currentlySpawned = value
	get:
		return currentlySpawned
var currentOilGlob : OilHandler


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
	if currentlySpawned:
		currentOilGlob.AddToMe(amountOfOil, amountOfTime, self)
	else:
		var oil = oilTest.instantiate()
		currentOilGlob = oil
		add_child(oil)
		print(oil)
		currentOilGlob.position = oilDestination.position
		currentOilGlob.PrepareMe(amountOfOil, amountOfTime, self)
		currentlySpawned = true
