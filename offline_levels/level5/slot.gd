extends TextureRect

export (String) var type
export (String) var content

func get_drag_data(position):
	var data = {}
	data["origin_slot"] = $"."
	data["origin_texture"] = texture
	var drag_texture = TextureRect.new()
	drag_texture.expand = true
	drag_texture.texture = texture
	drag_texture.rect_size = Vector2(270, 50)
	
	var control = Control.new()
	control.add_child(drag_texture)
	drag_texture.rect_position = -0.5 * drag_texture.rect_size
	set_drag_preview(control)
	
	return data
	
func can_drop_data(position, data):
	if data["origin_slot"].type == "layer":
		if texture == null:
			return true
		else:
			return false
	else:
		return true
	
func drop_data(position, data):
	var origin_slot = data["origin_slot"]
	if origin_slot != null:
		if origin_slot.type == "slot":
			origin_slot.texture = $".".texture
		else:
			origin_slot.texture = null
	texture = data["origin_texture"]
	content = data["origin_texture"]
