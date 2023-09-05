extends Node2D

export (PackedScene) var choice_scene
var score = 0
var json_file = "res://offline_levels/json/level3_questions.json"
var json_data = ""
var i
var answer

var level3_scene = "res://offline_levels/level3/level3.tscn"

export(NodePath) onready var clue_label = get_node(clue_label) as Label
export(NodePath) onready var score_label = get_node(score_label) as Label
export(NodePath) onready var choice1 = get_node(choice1) as TextureRect
export(NodePath) onready var choice2 = get_node(choice2) as TextureRect
export(NodePath) onready var choices = get_node(choices) as Node2D

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


	

# Called when the node enters the scene tree for the first time.
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
		
	i = 0
	var clue = json_data[i]["question"]
	var incorrect = json_data[i]["incorrect"]
	answer = json_data[i]["answer"]
	clue_label.text = clue
	
	var random = randi() % 2
	if random == 0:
		choice1.content = answer
		choice1.texture = load("res://offline_mode_Asset/level_3/" + answer + ".png")
		choice2.content = incorrect
		choice2.texture = load("res://offline_mode_Asset/level_3/" + incorrect + ".png")
	else:
		choice2.content = answer
		choice2.texture = load("res://offline_mode_Asset/level_3/" + answer + ".png")
		choice1.content = incorrect
		choice1.texture = load("res://offline_mode_Asset/level_3/" + incorrect + ".png")
	return json_data
		
	pass # Replace with function body.

func _on_choice1_pressed():
	i += 1
	var choice = choice1.content
	if choice == answer:
		score += 1
		score_label.text = str(score)
	
	while i < 5:
		var clue = json_data[i]["question"]
		var incorrect = json_data[i]["incorrect"]
		answer = json_data[i]["answer"]
		clue_label.text = clue
			
		var random = randi() % 2
		if random == 0:
			choice1.content = answer
			choice1.texture = load("res://offline_mode_Asset/level_3/" + answer + ".png")
			choice2.content = incorrect
			choice2.texture = load("res://offline_mode_Asset/level_3/" + incorrect + ".png")
		else:
			choice2.content = answer
			choice2.texture = load("res://offline_mode_Asset/level_3/" + answer + ".png")
			choice1.content = incorrect
			choice1.texture = load("res://offline_mode_Asset/level_3/" + incorrect + ".png")
		return json_data
	#	new_questions()
	
	popup_score_label.text = "Your Score: " + score_label.text + " / 5"
	if int(score_label.text) >= 4:
		popup_next_button.disabled = false
		popup_indicator_label.text = "Level Complete!"
	else:
		popup_next_button.disabled = true
		popup_indicator_label.text = "Level Failed!"
	game_over_popup.visible = true
	
	clue_label.queue_free()
	choices.queue_free()
	#show_gameover()

func _on_choice2_pressed():
	i += 1
	var choice = choice2.content
	if choice == answer:
		score += 1
		score_label.text = str(score)
	
	while i < 5:
		var clue = json_data[i]["question"]
		var incorrect = json_data[i]["incorrect"]
		answer = json_data[i]["answer"]
		clue_label.text = clue
			
		var random = randi() % 2
		if random == 0:
			choice1.content = answer
			choice1.texture = load("res://offline_mode_Asset/level_3/" + answer + ".png")
			choice2.content = incorrect
			choice2.texture = load("res://offline_mode_Asset/level_3/" + incorrect + ".png")
		else:
			choice2.content = answer
			choice2.texture = load("res://offline_mode_Asset/level_3/" + answer + ".png")
			choice1.content = incorrect
			choice1.texture = load("res://offline_mode_Asset/level_3/" + incorrect + ".png")
		return json_data
	#	new_questions()
	
	popup_score_label.text = "Your Score: " + score_label.text + " / 5"
	if int(score_label.text) >= 4:
		popup_next_button.disabled = false
		popup_indicator_label.text = "Level Complete!"
	else:
		popup_next_button.disabled = true
		popup_indicator_label.text = "Level Failed!"
	game_over_popup.visible = true
	
	clue_label.queue_free()
	choices.queue_free()
	

func _on_tap_pressed():
	instructions_popup.visible = false
	instructions_sprite.visible = false


func _on_retry_pressed():
	get_tree().change_scene(level3_scene)


# Display new set of question and options
#func new_questions():
#	var clue = json_data[i]["question"]
#	var incorrect = json_data[i]["incorrect"]
#	answer = json_data[i]["answer"]
#	clue_label.text = clue
#		
#	var random = randi() % 2
#	if random == 0:
#		choice1.content = answer
#		choice1.texture = load("res://offline_mode_Asset/level_3/" + answer + ".png")
#		choice2.content = incorrect
#		choice2.texture = load("res://offline_mode_Asset/level_3/" + incorrect + ".png")
#	else:
#		choice2.content = answer
#		choice2.texture = load("res://offline_mode_Asset/level_3/" + answer + ".png")
#		choice1.content = incorrect
#		choice1.texture = load("res://offline_mode_Asset/level_3/" + incorrect + ".png")
#	return json_data
##

# To display the gameover popup
#func show_gameover():
#	popup_score_label.text = "Your Score: " + score_label.text + " / 5"
#	if int(score_label.text) >= 4:
#		popup_next_button.disabled = false
#		popup_indicator_label.text = "Level Complete!"
#	else:
#		popup_next_button.disabled = true
#		popup_indicator_label.text = "Level Failed!"
#	game_over_popup.visible = true
#	
#	clue_label.queue_free()
#	choices.queue_free()
##
