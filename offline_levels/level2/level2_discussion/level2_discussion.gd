extends Node2D

export( NodePath ) onready var VoiceGen = get_node( VoiceGen ) as AudioStreamPlayer
export( NodePath ) onready var dialog = get_node( dialog ) as Label
var json_file = "res://offline_levels/json/level2_script.json"
var json_data = []
var textSpeed = 1
var total_character = 0
var click = 0
var size = 0
var game_scene = "res://offline_levels/level2/level2.tscn"

func _ready():
	VoiceGen.pitch_scale = 1.5
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
			
func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		click += 1
		$"../CanvasLayer/dialog".visible_characters = total_character
		if click == 2:
			click = 0
			size += 1
			update_dialog()

func update_dialog():
	if size < json_data.size():
		var title = json_data[size]["title"]
		var content = json_data[size]["content"]
		$"../CanvasLayer/dialog".text = content
		
		total_character = content.length()
		$"../CanvasLayer/dialog".visible_characters = 0
		
		$"../AnimationPlayer/title".text = title
		VoiceGen.read(dialog.text)
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
		get_tree().change_scene(game_scene)
	# You can also return json_data here if needed
