extends Node2D

var json_file = "res://offline_levels/json/level3_script.json"
var json_data = []
var textSpeed = 1
var total_character = 0
var click = 0
var size = 0
var game_scene = "res://offline_levels/level3/level3.tscn"

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
		var content = json_data[size]["dialog"]
		var channel = json_data[size]["channel"]
		
		$"../CanvasLayer/dialog".text = content
		total_character = content.length()
		$"../CanvasLayer/dialog".visible_characters = 0
		
		$"../CanvasLayer/title".text = title
		$"../CanvasLayer/channel".text = channel
		if size == 3:
			$AnimationPlayer.play("channel 1")
			$AnimationPlayer/server.visible = true
			$AnimationPlayer2.play("server_animation")
		elif size == 5:
			$AnimationPlayer/server.visible = false
			$AnimationPlayer/client.visible = true
			$AnimationPlayer.play("channel 2")
			$AnimationPlayer2.play("server_animation")
		elif size == 6:
			$AnimationPlayer/client.visible = false
			$AnimationPlayer/router.visible = true
			$AnimationPlayer.play("channel 3")
			$AnimationPlayer2.play("server_animation")
		elif size == 8:
			$AnimationPlayer/router.visible = false	
			$AnimationPlayer/switch.visible = true
			$AnimationPlayer.play("channel 4")
			$AnimationPlayer2.play("server_animation")
		elif size == 10:
			$AnimationPlayer/switch.visible = false
			$AnimationPlayer/firewall.visible = true
			$AnimationPlayer.play("channel 5")
			$AnimationPlayer2.play("server_animation")
		elif size == 12:
			$AnimationPlayer/firewall.visible = false
			$AnimationPlayer/modem.visible = true
			$AnimationPlayer.play("channel 6")
			$AnimationPlayer2.play("server_animation")
		elif size == 14:
			$AnimationPlayer/modem.visible = false
			$AnimationPlayer/access_point.visible = true
			$AnimationPlayer2.play("server_animation")
			$AnimationPlayer.play("channel 7")
		elif size == 16:
			$AnimationPlayer/access_point.visible = false
			$AnimationPlayer/network_cable.visible = true
			$AnimationPlayer.play("channel 8")
		elif size == 17:
			$AnimationPlayer/network_cable.visible = false
			$AnimationPlayer/NIC.visible = true
			$AnimationPlayer.play("channel 9")
		elif size == 18:
			$AnimationPlayer/NIC.visible = false
			$AnimationPlayer/cloud_infrastructure.visible = true
			$AnimationPlayer2.play("server_animation")
			$AnimationPlayer.play("channel 10")
		elif size == 20:
			$AnimationPlayer/cloud_infrastructure.visible = false
			$AnimationPlayer.play("ending_animation")

			
	else:
		print("Dialog ended.")
		get_tree().change_scene(game_scene)
	# You can also return json_data here if needed
