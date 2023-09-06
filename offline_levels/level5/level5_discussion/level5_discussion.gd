extends Node2D

var json_file = "res://offline_levels/json/level5_script.json"
var json_data = []
var textSpeed = 1
var total_character = 0
var click = 0
var size = 0
var game_scene = "res://offline_levels/level5/level5.tscn"

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
	if $CanvasLayer/NinePatchRect/dialog.visible_characters < total_character:
		$CanvasLayer/NinePatchRect/dialog.visible_characters += textSpeed
		
func _input(event):
	if event is InputEventScreenTouch and event.pressed:
		click += 1
		$CanvasLayer/NinePatchRect/dialog.visible_characters = total_character
		if click == 2:
			click = 0
			size += 1
			update_dialog()
	
func update_dialog():
	if size < json_data.size():
		var title = json_data[size]["title"]
		var content = json_data[size]["dialog"]
	
		$CanvasLayer/NinePatchRect/dialog.text = content
		total_character = content.length()
		$CanvasLayer/NinePatchRect/dialog.visible_characters = 0
		$CanvasLayer/NinePatchRect/title.text = title
		
		if size == 0:
			$CanvasLayer/AnimationPlayer.play("opening")
		if size == 3:
			$CanvasLayer/AnimationPlayer/physical_layer.visible = true
			$CanvasLayer/AnimationPlayer.play("physical_layer")
		if size == 4:
			$CanvasLayer/AnimationPlayer/physical_layer.visible = false
			$CanvasLayer/AnimationPlayer.play("opening")
		if size == 5:
			$CanvasLayer/AnimationPlayer/physical_layer.visible = false
			$CanvasLayer/AnimationPlayer/datalink_layer.visible = true
			$CanvasLayer/AnimationPlayer.play("datalink_layer")
		if size == 6:
			$CanvasLayer/AnimationPlayer/datalink_layer.visible = false
		if size == 7:
			$CanvasLayer/AnimationPlayer/network_layer.visible = true
			$CanvasLayer/AnimationPlayer.play("network_layer")
		if size == 8:
			$CanvasLayer/AnimationPlayer/network_layer.visible = false
		if size == 9:
			$CanvasLayer/AnimationPlayer/transport_layer.visible = true
			$CanvasLayer/AnimationPlayer.play("transport_layer")
		if size == 10:
			$CanvasLayer/AnimationPlayer/transport_layer.visible = false
		if size == 11:
			$CanvasLayer/AnimationPlayer/session_layer.visible = true
			$CanvasLayer/AnimationPlayer.play("session_layer")
		if size == 12:
			$CanvasLayer/AnimationPlayer/session_layer.visible = false
		if size == 13:
			$CanvasLayer/AnimationPlayer/presentation_layer.visible = true
			$CanvasLayer/AnimationPlayer.play("presentation_layer")
		if size == 14:
			$CanvasLayer/AnimationPlayer/presentation_layer.visible = false
		if size == 15:
			$CanvasLayer/AnimationPlayer/application_layer.visible = true
			$CanvasLayer/AnimationPlayer.play("application_layer")
		if size == 16:
			$CanvasLayer/AnimationPlayer/application_layer.visible = false
			$CanvasLayer/AnimationPlayer.play("opening")
	else:
		get_tree().change_scene(game_scene)
