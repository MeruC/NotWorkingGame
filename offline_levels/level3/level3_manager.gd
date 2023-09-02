extends Node2D

var json_file = "res://offline_levels/json/level3_script.json"
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
	if $"../CanvasLayer/dialog".visible_characters < total_character:
		
		 $"../CanvasLayer/dialog".visible_characters += textSpeed
		
	if Input.is_action_just_pressed("ui_accept"):
		click +=1 
		$"../CanvasLayer/dialog".visible_characters = total_character
		if click == 2:
			click = 0
			size += 1
			update_dialog()


func update_dialog():
	if size < json_data.size():
		var title = json_data[size]["title"]
		var content = json_data[size]["dialog"]
		var channel = json_data[size]["channel"]
		
		$"../CanvasLayer/dialog".text = content
		total_character = content.length()
		$"../CanvasLayer/dialog".visible_characters = 0
		
		$"../CanvasLayer/title".text = title
		$"../CanvasLayer/channel".text = channel
		if size == 3:
			$AnimationPlayer.play("channel 1")
		elif size == 5:
			$AnimationPlayer.play("channel 2")
		elif size == 6:
			$AnimationPlayer.play("channel 3")
		elif size == 8:
			$AnimationPlayer.play("channel 4")
		elif size == 10:
			$AnimationPlayer.play("channel 5")
		elif size == 12:
			$AnimationPlayer.play("channel 6")
		elif size == 14:
			$AnimationPlayer.play("channel 7")
		elif size == 16:
			$AnimationPlayer.play("channel 8")
		elif size == 17:
			$AnimationPlayer.play("channel 9")
		elif size == 18:
			$AnimationPlayer.play("channel 10")
		elif size == 20:
			$AnimationPlayer.play("ending_animation")

			
	else:
		print("Dialog ended.")

	# You can also return json_data here if needed
