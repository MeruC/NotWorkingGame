extends Node2D

export(PackedScene) var this_scene
var score = 0
var json_file = "res://offline_levels/json/level1_questions.json"
var json_data = ""

func _ready():
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
	
	
	var size = json_data.size() - 1
	var i = rand_range(0, size)
	var name = json_data[i]["name"]
	var type = json_data[i]["type"]
	var content = json_data[i]["content"]
	json_data.remove(i)
	print(content)
	$"../object".type = type
	$"../object".content = content
	$"../notepad_content".text = $"../object".content
	return json_data
		
	
func spawn_new():
	while(json_data.size() != 0):
		var size = json_data.size() - 1
		var i = rand_range(0, size)
		var name = json_data[i]["name"]
		var type = json_data[i]["type"]
		var content = json_data[i]["content"]
		json_data.remove(i)
		print(content)
		
		var new_item = this_scene.instance() 
		if (new_item != null):
			$"..".add_child(new_item)
			new_item.owner = $".."
			new_item.position = Vector2(355, 492)
			new_item.type = type
			new_item.content = content
			$"../notepad_content".text = new_item.content
		return json_data
	$"../notepad_content".text = ""
	$"../notepad".queue_free()
