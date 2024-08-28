extends Control

class_name UIHandler

@export_category("Plugging in Nodes")
@export var toolTipLabel : Label
@export var inspectionDisplay : TextureRect
@export var blurCurtain : TextureRect


func SetTooltip(newTooltip):
	toolTipLabel.text = newTooltip


func Inspect(currentInspectable):
	blurCurtain.visible = true
	inspectionDisplay.texture = currentInspectable.imageToShow
	inspectionDisplay.visible = true


func StopInspecting():
	blurCurtain.visible = false
	inspectionDisplay.visible = false
