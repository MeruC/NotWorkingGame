extends TextureRect

export (String) var type
export (String) var id
var json_file = "res://offline_levels/json/level5_questions.json"
var json_data = ""

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
	return true
	
func drop_data(position, data):
	pass


func _on_layer_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		var file = File.new()
		if file.open(json_file, File.READ) == OK:
			var json_content = file.get_as_text()
			file.close()
			var json_result = JSON.parse(json_content)
			if json_result.error == OK:
				json_data = json_result.result
			else:
				print("JSON parsing error:", json_result.error_string)
		else:
			print("Failed to open JSON file.")
		
		var content = json_data[int(id)]["content"]
		$"../popup_layer/popup/main_popup/logo".texture = load("res://offline_mode_Asset/level_5/info.png")
		$"../popup_layer/popup/main_popup/explaination".text = content
		$"../popup_layer/popup".visible = true
		
