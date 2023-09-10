extends Node2D

export( NodePath ) onready var VoiceGen = get_node( VoiceGen ) as AudioStreamPlayer
export( NodePath ) onready var dialog = get_node( dialog ) as Label

var json_file = "res://offline_levels/json/level4_script.json"
var json_data = []
var textSpeed = 1
var total_character = 0
var click = 0
var size = 0
var touch = true
var game_scene = "res://offline_levels/level4/level4.tscn"

func _ready():
	VoiceGen.pitch_scale = 1.5
	$CanvasLayer/well_done.visible == false
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
	if $CanvasLayer/dialog.visible_characters < total_character:
		$CanvasLayer/dialog.visible_characters += textSpeed
		
	if Input.is_action_just_pressed("ui_accept"):
		click +=1 
		$CanvasLayer/dialog.visible_characters = total_character
		if click == 2:
			click = 0
			size += 1
			update_dialog()
			
func _input(event):
	if touch and event is InputEventScreenTouch and event.pressed:
		click += 1
		$CanvasLayer/dialog.visible_characters = total_character
		if click == 2:
			click = 0
			size += 1
			update_dialog()


func update_dialog():
	if size < json_data.size():
		var title = json_data[size]["title"]
		var content = json_data[size]["dialog"]
		var channel = json_data[size]["channel"]
	
		
		$CanvasLayer/dialog.text = content
		total_character = content.length()
		$CanvasLayer/dialog.visible_characters = 0
		
		$CanvasLayer/title.text = title
		VoiceGen.read(dialog.text)
		$CanvasLayer/channel.text = channel
		if size == 0:
			$AnimationPlayer.play("level4_animation")
		if size == 1:
			$AnimationPlayer.play("level4_animation")
		if size == 3:
			$AnimationPlayer.play("channel_1")
			$AnimationPlayer2.play("illustration_animation")
			$CanvasLayer/LAN.visible = true
		if size == 5:
			$CanvasLayer/LAN.visible = false
			$CanvasLayer/MAN.visible = true
			$AnimationPlayer.play("channel_2")
			$AnimationPlayer2.play("illustration_animation")
		if size == 7:
			$CanvasLayer/MAN.visible = false
			$CanvasLayer/WAN.visible = true
			$AnimationPlayer.play("channel_3")
			$AnimationPlayer2.play("illustration_animation")
		if size == 10:
			$CanvasLayer/WAN.visible = false
			$CanvasLayer/video_cover.visible = true
			$AnimationPlayer.play("video")
		if size == 11:
			$CanvasLayer/video_cover.visible = false
			$CanvasLayer/play_btn.visible = false
			$AnimationPlayer.play("ending_animation")
	else:
		get_tree().change_scene(game_scene)
	
	# You can also return json_data here if needed


func _on_video_player_cancel():
	$CanvasLayer/video_player.visible = false
	$CanvasLayer/title.visible = true
	$CanvasLayer/dialog.visible = true
	$CanvasLayer/video_cover.visible = true
	$CanvasLayer/play_btn.visible = true
	touch = true
	click = 0

func _on_play_btn_pressed():
	touch = false
	$CanvasLayer/video_player.visible = true
	$CanvasLayer/title.visible = false
	$CanvasLayer/dialog.visible = false
	$CanvasLayer/video_cover.visible = false
	$CanvasLayer/play_btn.visible = false
	click = 0

func _on_video_player_finish():
	$"../video_player".visible = false
	$"../video".visible = true
	$"../play_btn".visible = true
	touch = true
	click = 0
