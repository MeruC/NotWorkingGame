extends Control

var json_file = "res://online_mode/createQuiz_student/test.json"
var json_data = ""
var score = 0
var i = 0

export(NodePath) onready var instructions = get_node(instructions) as Control
export(NodePath) onready var game_over = get_node(game_over) as Control
export(NodePath) onready var level_name = get_node(level_name) as Label
export(NodePath) onready var minute = get_node(minute) as Label
export(NodePath) onready var second = get_node(second) as Label
export(NodePath) onready var timer = get_node(timer) as Timer
export(NodePath) onready var current_item = get_node(current_item) as Label
export(NodePath) onready var total_item = get_node(total_item) as Label
export(NodePath) onready var question_content = get_node(question_content) as Label
export(NodePath) onready var choices_container = get_node(choices_container) as GridContainer
export(NodePath) onready var choice1 = get_node(choice1) as Button
export(NodePath) onready var choice2 = get_node(choice2) as Button
export(NodePath) onready var choice3 = get_node(choice3) as Button
export(NodePath) onready var choice4 = get_node(choice4) as Button

func _ready():
	#for getting data in a JSON file and putting it in the json_data variable as dictionary
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
	
	display_question()
	level_name.text = json_data["level_name"]
	total_item.text = str(json_data["questions"].size())
	timer.wait_time = float(json_data["time"])
	
func _process(delta):
	set_time()
	
func set_time():
	minute.text = str(int(timer.time_left / 60))
	second.text = str("%02d" % (int(timer.time_left) % 60))
	
func display_question():
	current_item.text = str(i + 1)
	question_content.text = json_data["questions"][i]["question"]
	question_content.answer = json_data["questions"][i]["answer"]
	
	for child in choices_container.get_children():
		child.text = ""
	
	var choices = []
	choices.append(json_data["questions"][i]["answer"])
	while choices.size() != 4:
		var number = rand_range(0, json_data["questions"].size())
		if json_data["questions"][number]["answer"] in choices:
			pass
		else:
			choices.append(json_data["questions"][number]["answer"])
	choices.shuffle()
	var counter = 0
	for child in choices_container.get_children():
		child.text = choices[counter]
		counter += 1
	i += 1

func show_gameover():
	game_over.find_node("user_score").text = str(score)
	game_over.find_node("total_items").text = total_item.text
	timer.paused = true
	game_over.visible = true

func _on_Timer_timeout():
	show_gameover()

func _on_start_pressed():
	instructions.visible = false
	timer.start()

func _on_choice_pressed():
	if choice1.text == question_content.answer:
		score += 1
	print(str(score))
	if current_item.text != total_item.text:
		display_question()
	else:
		show_gameover()

func _on_choice2_pressed():
	if choice2.text == question_content.answer:
			score += 1
	print(str(score))
	if current_item.text != total_item.text:
		display_question()
	else:
		show_gameover()


func _on_choice3_pressed():
	if choice3.text == question_content.answer:
			score += 1
	print(str(score))
	if current_item.text != total_item.text:
		display_question()
	else:
		show_gameover()


func _on_choice4_pressed():
	if choice4.text == question_content.answer:
			score += 1
	print(str(score))
	if current_item.text != total_item.text:
		display_question()
	else:
		show_gameover()


func _on_exit_pressed():
	pass
