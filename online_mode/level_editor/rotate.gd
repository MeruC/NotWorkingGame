extends Scale_Control

var current_object

func _on_rotate_pressed():
	current_object.rotate(Vector3(0,1,0),-(PI/2))


func _on_done_pressed():
	Global.editor_mode = "rotate"
	set_visible(false)
