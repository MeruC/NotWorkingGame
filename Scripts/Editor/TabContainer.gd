extends TabContainer

onready var object_cursor = get_node("/root/main/Editor_Object")

func _on_TabContainer_mouse_entered():
	object_cursor.can_place = false
	print(object_cursor.can_place)
	pass # Replace with function body.


func _on_TabContainer_mouse_exited():
	object_cursor.can_place = true
	print(object_cursor.can_place)
	pass # Replace with function body.
