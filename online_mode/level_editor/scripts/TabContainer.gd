extends TabContainer

onready var object_cursor = get_node("/root/main/Editor_Object")

func _on_TabContainer_mouse_entered():
	Global.can_place = false
	print(Global.can_place)
	pass # Replace with function body.


func _on_TabContainer_mouse_exited():
	Global.can_place = true
	print(Global.can_place)
	pass # Replace with function body.


func _on_ScrollContainer_mouse_entered():
	Global.can_place = false


func _on_ScrollContainer_mouse_exited():
	Global.can_place = true
