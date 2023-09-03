extends Node2D


var json_file = "res://offline_levels/json/level1_script.json"
var json_data = []
var textSpeed = 1
var total_character = 0
var click = 0

var size = 0

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

	update_dialog()
	
func _process(_delta):
	if $"../CanvasLayer/NinePatchRect/dialog".visible_characters < total_character:
		
		 $"../CanvasLayer/NinePatchRect/dialog".visible_characters += textSpeed
		
	if Input.is_action_just_pressed("ui_accept"):
		click +=1 
		$"../CanvasLayer/NinePatchRect/dialog".visible_characters = total_character
		if click == 2:
			click = 0
			size += 1
			update_dialog()


func update_dialog():
	if size < json_data.size():
		
		var title = json_data[size]["title"]
		var content = json_data[size]["content"]
		$"../CanvasLayer/NinePatchRect/dialog".text = content
		
		total_character = content.length()
		$"../CanvasLayer/NinePatchRect/dialog".visible_characters = 0
		
		$"../example1/AnimationPlayer/title"
		$"../CanvasLayer/NinePatchRect/title".text = title
		
		if size == 2:
			
			$"../example1/AnimationPlayer/file".visible = true
			$"../example1/AnimationPlayer/name".visible = true
			$"../example1/AnimationPlayer/age".visible = true
			$"../example1/AnimationPlayer".play("file_animation")
			
		if size == 3:
			
			$"../example1/AnimationPlayer".play("name_animation")
			
		if size == 4:
			
			$"../example1/AnimationPlayer".play_backwards("file_animation")
			$"../example1/AnimationPlayer/file".visible = false
			$"../example1/AnimationPlayer/name".visible = false
			$"../example1/AnimationPlayer/age".visible = false
			
	else:
		
		print("Dialog ended.")

	# You can also return json_data here if needed

