extends Node2D

export(PackedScene) var letter_scene
export(PackedScene) var blank_scene
var json_file = "res://offline_levels/json/level2_questions.json"
var json_data = ""
var answer
var score = 0
var i
export(NodePath) onready var clue_label = get_node(clue_label) as Label
export(NodePath) onready var score_label = get_node(score_label) as Label
export(NodePath) onready var letter_container = get_node(letter_container) as GridContainer
export(NodePath) onready var blank_container = get_node(blank_container) as GridContainer
export(NodePath) onready var submit_button = get_node(submit_button) as Button

# Gameover popup paths
export(NodePath) onready var popup_score_label = get_node(popup_score_label) as Label
export(NodePath) onready var game_over_popup = get_node(game_over_popup) as Control
export(NodePath) onready var popup_next_button = get_node(popup_next_button) as Button
export(NodePath) onready var popup_indicator_label = get_node(popup_indicator_label) as Label
##

# Instructions popup paths
export(NodePath) onready var instructions_popup = get_node(instructions_popup) as Control
export(NodePath) onready var instructions_sprite = get_node(instructions_sprite) as Sprite
var level2_scene = "res://offline_levels/level2/level2.tscn"
##

func _ready():
	# To store JSON Contents into file variable
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
	##
	
	i = 0

	var scrambled = json_data[i]["scrambled"]
	var clue = json_data[i]["clue"]
	answer = json_data[i]["answer"]
	clue_label.text = clue
	
	var x = 0
	for child in letter_container.get_children():
		if child is Button:
			child.text = scrambled[x]
			x += 1
			
	return json_data
	
func _process(delta):
	# To enable the submit button when all blanks are filled and to disable if not
	var blank_counts = blank_container.get_child_count()
	var last_blank = blank_container.get_child(blank_counts - 1)
	if last_blank != null:
		if last_blank.text != "_":
			submit_button.disabled = false
		else:
			submit_button.disabled = true
	##


func _on_clear_pressed():
	# To clear every blank when Clear Button is Clicked
	for child in blank_container.get_children():
		child.text = "_"
	for child in letter_container.get_children():
		child.disabled = false
	##


func _on_submit_pressed():
	# To check the user's answer
	i += 1
	var user_answer = ""
	for child in blank_container.get_children():
		user_answer = user_answer + child.text
	if user_answer == answer:
		score += 1
		score_label.text = str(score)
	##
		
	
	for child in blank_container.get_children():
		child.queue_free()
	for child in letter_container.get_children():
		child.queue_free()
	clue_label.text = ""
	
	# To display the next question
	while (i < 5):
		var scrambled = json_data[i]["scrambled"]
		var clue = json_data[i]["clue"]
		answer = json_data[i]["answer"]
		clue_label.text = clue
		var x = 0
		for Char in scrambled:
			var new_letter = letter_scene.instance()
			var new_blank = blank_scene.instance()
			if (new_blank != null):
				blank_container.add_child(new_blank)
				new_blank.text = "_"
				new_blank.rect_min_size = Vector2(75, 75)
				new_blank.letter_container = letter_container
				letter_container.add_child(new_letter)
				new_letter.text = scrambled[x]
				new_letter.rect_min_size = Vector2(75, 75)
				new_letter.blank_container = blank_container
				x += 1
		return i
	##
	
	# To show popup and set its contents
	popup_score_label.text = "Your Score: " + score_label.text + " / 5"
	if int(score_label.text) >= 4:
		popup_next_button.disabled = false
		popup_indicator_label.text = "Level Complete!"
	else:
		popup_next_button.disabled = true
		popup_indicator_label.text = "Level Failed!"
	game_over_popup.visible = true
	##


func _on_tap_pressed():
	instructions_popup.visible = false
	instructions_sprite.visible = false


func _on_retry_pressed():
	get_tree().change_scene(level2_scene)
