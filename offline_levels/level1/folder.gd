extends Node2D

export (String) var folder_type
var file

func _ready():
	pass



func _on_Area2D_area_entered(area):
	file = area.get_parent()
	file.onFolder = true
	print(file.onFolder)
	file.folderType = folder_type
	pass # Replace with function body.
	


func _on_Area2D_area_exited(area):
	file = area.get_parent()
	file.onFolder = false
	print(file.onFolder)
	pass # Replace with function body.
