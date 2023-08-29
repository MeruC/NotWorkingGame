extends Node2D

var json_file = "res://offline_levels/json/level2_script.json"
var json_data = []
export (float) var textSpeed = 0.05
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
	if Input.is_action_just_pressed("ui_accept"):
		size += 1
		update_dialog()


func update_dialog():
	if size < json_data.size():
		var title = json_data[size]["title"]
		var content = json_data[size]["content"]
		$"../CanvasLayer/dialog".text = content
		$"../AnimationPlayer/title".text = title
		if size == 1:
			$"../AnimationPlayer/4".visible = true
			$"../AnimationPlayer".play("picture_animation")
			$"../AnimationPlayer".play("title_animation")
		elif size == 2:
			$"../AnimationPlayer/1".visible = true
			$"../AnimationPlayer/4".visible = false
			$"../AnimationPlayer".play("picture_animation")
		elif size == 3:
			$"../AnimationPlayer/1".visible = false
			$"../AnimationPlayer/5".visible = true
			$"../AnimationPlayer".play("picture_animation")
		elif size == 4:
			$"../AnimationPlayer/5".visible = false
			$"../AnimationPlayer/3".visible = true
			$"../AnimationPlayer".play("picture_animation")
		elif size == 5:
			$"../AnimationPlayer/3".visible = false
			$"../AnimationPlayer/6".visible = true
			$"../AnimationPlayer".play("picture_animation")
		elif size == 6:
			$"../AnimationPlayer/6".visible = false
			$"../AnimationPlayer/2".visible = true
			$"../AnimationPlayer".play("picture_animation")
		elif size == 7:
			$"../AnimationPlayer/1".visible = false 
			$"../AnimationPlayer/2".visible = false 
			$"../AnimationPlayer/3".visible = false 
			$"../AnimationPlayer/4".visible = false  
			$"../AnimationPlayer/5".visible = false 
			$"../AnimationPlayer".play_backwards("title_animation")
		else:
			$"../AnimationPlayer/1".visible = false 
			$"../AnimationPlayer/2".visible = false 
			$"../AnimationPlayer/3".visible = false 
			$"../AnimationPlayer/4".visible = false  
			$"../AnimationPlayer/5".visible = false 
			
			
			
	else:
		print("Dialog ended.")

	# You can also return json_data here if needed
