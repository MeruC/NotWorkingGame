extends TextureRect

export (String) var type
export (String) var content

func get_drag_data(position):
	var data = {}
	data["origin_slot"] = $"."
	data["origin_texture"] = content
	var drag_texture = TextureRect.new()
	drag_texture.expand = true
	drag_texture.texture = content
	drag_texture.rect_size = Vector2(33, 369)
	
	var control = Control.new()
	control.add_child(drag_texture)
	drag_texture.rect_position = -0.5 * drag_texture.rect_size
	set_drag_preview(control)
	
	return data
	
func can_drop_data(position, data):
	return true
	
func drop_data(position, data):
	pass
	
