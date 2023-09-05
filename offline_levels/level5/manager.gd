extends Node2D

export(NodePath) onready var layer1 = get_node(layer1) as TextureRect
export(NodePath) onready var layer2 = get_node(layer2) as TextureRect
export(NodePath) onready var layer3 = get_node(layer3) as TextureRect
export(NodePath) onready var layer4 = get_node(layer4) as TextureRect
export(NodePath) onready var layer5 = get_node(layer5) as TextureRect
export(NodePath) onready var layer6 = get_node(layer6) as TextureRect
export(NodePath) onready var layer7 = get_node(layer7) as TextureRect
export(NodePath) onready var slot1 = get_node(slot1) as TextureRect
export(NodePath) onready var slot2 = get_node(slot2) as TextureRect
export(NodePath) onready var slot3 = get_node(slot3) as TextureRect
export(NodePath) onready var slot4 = get_node(slot4) as TextureRect
export(NodePath) onready var slot5 = get_node(slot5) as TextureRect
export(NodePath) onready var slot6 = get_node(slot6) as TextureRect
export(NodePath) onready var slot7 = get_node(slot7) as TextureRect
export(NodePath) onready var slot_container = get_node(slot_container) as GridContainer

# Gameover popup paths
export(NodePath) onready var popup_score_label = get_node(popup_score_label) as Label
export(NodePath) onready var game_over_popup = get_node(game_over_popup) as Control
export(NodePath) onready var popup_next_button = get_node(popup_next_button) as Button
export(NodePath) onready var popup_indicator_label = get_node(popup_indicator_label) as Label
##

# Instructions popup paths
export(NodePath) onready var animation_player = get_node(animation_player) as AnimationPlayer
export(NodePath) onready var instructions_popup = get_node(instructions_popup) as Control
export(NodePath) onready var instructions_sprite = get_node(instructions_sprite) as Sprite
##

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
var textures = []


func _ready():
	textures = [layer1.texture, layer2.texture, layer3.texture, layer4.texture, layer5.texture, layer6.texture, layer7.texture]
	shuffle()
	position()

# To shuffle layers to be displayed
func shuffle():
	for i in range(specific_positions.size() - 1, 0, -1):
		var j = randi() % (i + 1)
		var temp = specific_positions[i]
		specific_positions[i] = specific_positions[j]
		specific_positions[j] = temp
##

# To set the position of layers to be displayed
func position():
	var nodes = []
	for child in get_children():
		if child is TextureRect:
			nodes.append(child)
		
	for i in range(min(specific_positions.size(), nodes.size())):
		var node = nodes[i]
		var position = specific_positions[i]
		position_texture_rect(node, position)
##
		
func position_texture_rect(node: TextureRect, position: Vector2):
	node.rect_position = position


# To check user's answer then display the gameover popup
func _on_submit_pressed():
	var i = 6
	if slot1.texture == textures[0] and slot2.texture == textures[1] and slot3.texture == textures[2] and slot4.texture == textures[3] and slot5.texture == textures[4] and slot6.texture == textures[5] and slot7.texture == textures[6]:
		popup_indicator_label.text = "Level Complete!"
		score = 7
		popup_score_label.text = "Your Score: " + str(score) + " / 7"
		popup_next_button.disabled = false
	else:
		popup_indicator_label.text = "Level Failed!"
		for child in slot_container.get_children():
			if child.texture == textures[i]:
				score += 1
			i -= 1
		popup_score_label.text = "Your Score: " + str(score) + " / 7"
		popup_next_button.disabled = true
	
	game_over_popup.visible = true
##

func _on_reload_pressed():
	var current_scene_path = get_tree().current_scene
	get_tree().change_scene("res://offline_levels/level5/level5.tscn")
	pass # Replace with function body.


func _on_retry_pressed():
	get_tree().change_scene("res://offline_levels/level5/level5.tscn")
	pass # Replace with function body.


func _on_tap_pressed():
	instructions_popup.visible = false
	instructions_sprite.visible = false
