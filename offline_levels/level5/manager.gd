extends Node2D

var specific_positions = [
	Vector2(50, 50), 
	Vector2(450, 50), 
	Vector2(50, 250), 
	Vector2(450, 250), 
	Vector2(50, 450), 
	Vector2(450, 450), 
	Vector2(254, 575)
	]
	
var score = 0

var textures = ["[StreamTexture:1522]", "[StreamTexture:1537]", "[StreamTexture:1525]", "[StreamTexture:1528]", "[StreamTexture:1531]","[StreamTexture:1534]" , "[StreamTexture:1519]"]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	shuffle()
	position()
	
func shuffle():
	for i in range(specific_positions.size() - 1, 0, -1):
		var j = randi() % (i + 1)
		var temp = specific_positions[i]
		specific_positions[i] = specific_positions[j]
		specific_positions[j] = temp
		
func position():
	var nodes = []
	for child in get_children():
		if child is TextureRect:
			nodes.append(child)
		
	for i in range(min(specific_positions.size(), nodes.size())):
		var node = nodes[i]
		var position = specific_positions[i]
		position_texture_rect(node, position)
		
func position_texture_rect(node: TextureRect, position: Vector2):
	node.rect_position = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_submit_pressed():
	var i = 6
	print(str($slot_container/slot1.texture))
	print(str($slot_container/slot2.texture))
	print(str($slot_container/slot3.texture))
	print(str($slot_container/slot4.texture))
	print(str($slot_container/slot5.texture))
	print(str($slot_container/slot6.texture))
	print(str($slot_container/slot7.texture))
	if str($slot_container/slot1.texture) == textures[0] and str($slot_container/slot2.texture) == textures[1] and str($slot_container/slot3.texture) == textures[2] and str($slot_container/slot4.texture) == textures[3] and str($slot_container/slot5.texture) == textures[4] and str($slot_container/slot6.texture) == textures[5] and str($slot_container/slot7.texture) == textures[6]:
		$popup_layer/game_over/main_popup/indicator.text = "Level Complete!"
		score = 7
		$popup_layer/game_over/main_popup/score.text = "Your Score: " + str(score) + " / 7"
		$popup_layer/game_over/main_popup/GridContainer/next.disabled = false
	else:
		$popup_layer/game_over/main_popup/indicator.text = "Level Failed!"
		for child in $slot_container.get_children():
			if str(child.texture) == textures[i]:
				score += 1
			i -= 1
		$popup_layer/game_over/main_popup/score.text = "Your Score: " + str(score) + " / 7"
		$popup_layer/game_over/main_popup/GridContainer/next.disabled = true
	
	$popup_layer/game_over.visible = true


func _on_reload_pressed():
	var current_scene_path = get_tree().current_scene
	get_tree().change_scene("res://offline_levels/level5/level5.tscn")
	pass # Replace with function body.


func _on_retry_pressed():
	get_tree().change_scene("res://offline_levels/level5/level5.tscn")
	pass # Replace with function body.


func _on_tap_pressed():
	$popup_layer/popup.visible = false
	pass # Replace with function body.
