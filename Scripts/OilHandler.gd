extends StaticBody3D

class_name OilHandler

@export_category("Tooltip")
@export var tooltipText : String = "(E) to fuel the lantern"

@export_category("Resource Control")
@export var oilAdditionAmount : float = 10
@export var oilFillTime : float = 10
var whoCreatedMe : MillHandler

func CollectMe(theLantern : LanternHandler):
	theLantern.refillLight(oilAdditionAmount)
	whoCreatedMe.currentlySpawned = false
	queue_free()

func PrepareMe(amountOfOil : float, amountOfTime : float, creator : MillHandler):
	oilAdditionAmount = amountOfOil
	oilFillTime = amountOfTime
	whoCreatedMe = creator
	FillUpBasin(oilFillTime)

func AddToMe(amountOfOil, amountOfTime, creator):
	oilAdditionAmount += amountOfOil
	print("Current oil: ", oilAdditionAmount)
	if oilAdditionAmount < 6:
		scale *= amountOfOil * 1.1
		position.y += amountOfOil * 0.05

# Add time/function for animation of filling the basin
func FillUpBasin(timeToFill : float):
	pass
