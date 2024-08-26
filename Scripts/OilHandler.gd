extends StaticBody3D

class_name OilHandler

@export var oilAdditionAmount = 10
@export var oilFillTime = 10
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

# Add time/function for animation of filling the basin
func FillUpBasin(timeToFill : float):
	pass
