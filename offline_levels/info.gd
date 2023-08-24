extends Node2D

var selected = false

export (String) var type
export (String, MULTILINE) var content
var onFolder = false
var folderType

func _ready():
	pass
	
func _process(delta):
	if selected:
		followMouse()

func followMouse():
	position = get_global_mouse_position()


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			selected = true
		else:
			selected = false
			if (folderType == type and onFolder):
				get_parent().get_node("manager").score += 1
				print(get_parent().get_node("manager").score)
				get_parent().get_node("manager").spawn_new()
				queue_free()
			elif (onFolder):
				queue_free()
				print(get_parent().get_node("manager").score)
				get_parent().get_node("manager").spawn_new()
