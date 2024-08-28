extends StaticBody3D

class_name OilHandler

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
	scale *= amountOfOil * 1.05

# Add time/function for animation of filling the basin
func FillUpBasin(timeToFill : float):
	pass
