extends Node2D

export( NodePath ) onready var VoiceGen = get_node( VoiceGen ) as AudioStreamPlayer
export( NodePath ) onready var dialog = get_node( dialog ) as Label

var json_file = "res://offline_levels/json/level5_script.json"
var json_data = []
var textSpeed = 1
var total_character = 0
var click = 0
var size = 0
var game_scene = "res://offline_levels/level5/level5.tscn"

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
		VoiceGen.read(dialog.text)
		if size == 0:
			$AnimationPlayer.play("introduction")
		if size == 3:
			$CanvasLayer/osi_layer.visible = true
			$AnimationPlayer.play("physical_layer")
		if size == 4:
			$AnimationPlayer.play("datalink_layer")
		if size == 5:
			$AnimationPlayer.play("network_layer")
		if size == 6:
			$AnimationPlayer.play("transport_layer")
		if size == 7:
			$AnimationPlayer.play("session_layer")
		if size == 8:
			$AnimationPlayer.play("presentation_layer")
		if size == 9:
			$AnimationPlayer.play("application_layer")
		if size == 10:
			$AnimationPlayer.play("osi_laayer")
		if size == 11:
			$CanvasLayer/osi_layer.visible = false
			$AnimationPlayer.play("ending")
	else:
		get_tree().change_scene(game_scene)
