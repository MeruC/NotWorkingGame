extends CanvasLayer

func _process(delta):
	$cursor.global_position = get_viewport().get_mouse_position()
