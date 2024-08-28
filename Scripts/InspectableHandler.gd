extends Area3D

class_name InspectableHandler

@export_category("Tooltip")
@export var tooltipText : String = "(E) to inspect\n(F) to put down"

@export_category("Plugging in Nodes")
@export var UINode : UIHandler
@export var imageToShow : CompressedTexture2D

func InspectMe(player : PlayerController):
	UINode.Inspect(self)
	# Deal with showing this to the UI and blurring the area behind it


func IgnoreMe(player : PlayerController):
	UINode.StopInspecting()
	# Deal with putting it back where it belongs and unblurring the area behind it
