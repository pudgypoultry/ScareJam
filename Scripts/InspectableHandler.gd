extends Area3D

class_name InspectableHandler

@export_category("Plugging in Nodes")
@export var UINode : Control


func InspectMe():
	pass
	# Deal with showing this to the UI and blurring the area behind it


func IgnoreMe():
	pass
	# Deal with putting it back where it belongs and unblurring the area behind it
