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
var touch = true

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
	if touch and event is InputEventScreenTouch and event.pressed:
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

		if size == 2:
			$"../AnimationPlayer".play("title_animation")
			$"../AnimationPlayer/transmission".visible = true
			$"../gif_player".play("transmission_system")
		elif size == 3:
			$"../AnimationPlayer/translator".visible = true
			$"../AnimationPlayer/transmission".visible = false
			$"../gif_player".play("interfacing")
		elif size == 4:
			$"../AnimationPlayer/translator".visible = false
			$"../AnimationPlayer/synchronization".visible = true
			$"../gif_player".play("synchronization")
		elif size == 5:
			$"../AnimationPlayer/synchronization".visible = false
			$"../AnimationPlayer/exchange_management".visible = true
			$"../gif_player".play("exchange_management")
		elif size == 6:
			$"../AnimationPlayer/exchange_management".visible = false
			$"../AnimationPlayer/routing".visible = true
			$"../gif_player".play("routing")
		elif size == 7:
			$"../AnimationPlayer/routing".visible = false
			$"../AnimationPlayer/data_security".visible = true
			$"../gif_player".play("data_security")
		elif size == 8:
			$"../AnimationPlayer/data_security".visible = false
			$"../AnimationPlayer".play("video_zoom")
			$"../video".visible = true
			$"../CanvasLayer/dialog".visible = true
		elif size == 9:
			$"../AnimationPlayer".play_backwards("title_animation")
			$"../video".visible = false
			$"../play".visible = false

	else:
		print("Dialog ended.")
		get_tree().change_scene(game_scene)
	# You can also return json_data here if needed

func _on_play_pressed():
	touch = false
	$"../AnimationPlayer/title".visible = false
	$"../video_player".visible = true
	$"../video".visible = false
	$"../play".visible = false
	click = 0

func _on_video_player_cancel():
	touch = true
	$"../AnimationPlayer/title".visible = true
	$"../video_player".visible = false
	$"../video".visible = true
	$"../play".visible = true

func _on_video_player_finish():
	touch = true
	$"../AnimationPlayer/title".visible = true
	$"../video_player".visible = false
	$"../video".visible = true
	$"../play".visible = true
