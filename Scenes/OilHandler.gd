extends StaticBody3D

@export var oilAdditionAmount = 10

func CollectMe(theLantern : LanternHandler):
	theLantern.refillLight(oilAdditionAmount)
	queue_free()
