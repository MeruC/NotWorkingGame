extends Control

export(PackedScene) var question_container
export(PackedScene) var lesson_instance
export(NodePath) onready var level_name = get_node(level_name) as LineEdit
export(NodePath) onready var question_vbox = get_node(question_vbox) as VBoxContainer
export(NodePath) onready var selected_vbox = get_node(selected_vbox) as VBoxContainer
export(NodePath) onready var lesson_button = get_node(lesson_button) as Button
export(NodePath) onready var lessons_container = get_node(lessons_container) as GridContainer
export(NodePath) onready var level_selection = get_node(level_selection) as Control
export(NodePath) onready var delete_confirmation = get_node(delete_confirmation) as Control
export(NodePath) onready var confirmation_yes_button = get_node(confirmation_yes_button) as Button
export(NodePath) onready var create_confirmation = get_node(create_confirmation) as Control
export(NodePath) onready var error = get_node(error) as Control
export(NodePath) onready var minute = get_node(minute) as LineEdit
export(NodePath) onready var second = get_node(second) as LineEdit

var new_json = {}
var question_list = []
var json_file = "res://online_mode/json/question_bank.json"
var json_data = ""
var initial_text = ""

func show_questions():
	initial_text = lesson_button.text
	var lesson_number = lesson_button.text.replace(" ", "").to_lower()
	
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
	
	# To display questions from the question bank
	for entry in json_data[lesson_number]:
		var new_question = question_container.instance()
		question_vbox.add_child(new_question)
		new_question.find_node("question_content").text = entry["question"]
		new_question.find_node("answer_content").text = entry["answer"]
		new_question.delete_confirmation = delete_confirmation
		new_question.selected_container = $"TabContainer/View Selected Questions/ScrollContainer/VBoxContainer"
	##
	
	# To list all the lessons with available questions
	var i = 1
	for entry in json_data:
		var new_lesson_button = lesson_instance.instance()
		lessons_container.add_child(new_lesson_button)
		new_lesson_button.text = "Lesson " + str(i)
		new_lesson_button.lesson_number = $"TabContainer/Question List/lesson_number"
		new_lesson_button.popup = $popup/level_selection
		i += 1
	##
	
	# If a question is already selected, make the checkbox "checked"
	for entry in question_vbox.get_children():
		for selected in selected_vbox.get_children():
			if entry.find_node("question_content").text == selected.find_node("question_content").text:
				entry.find_node("CheckBox").pressed = true
	##

func _ready():
	show_questions()
	
func _process(delta):
	# To display other lesson's set of questions
	if lesson_button.text != initial_text:
		for entry in question_vbox.get_children():
			entry.queue_free()
		for entry in lessons_container.get_children():
			entry.queue_free()
		show_questions()

func _on_lesson_number_pressed():
	level_selection.visible = true


func _on_yes_pressed():
	for entry in selected_vbox.get_children():
		if entry.find_node("question_content").text == confirmation_yes_button.question:
			entry.queue_free()
			for question in question_vbox.get_children():
				if question.find_node("question_content").text == confirmation_yes_button.question:
					question.find_node("CheckBox").pressed = false
				
	delete_confirmation.visible = false


func _on_no_pressed():
	delete_confirmation.visible = false
	create_confirmation.visible = false


func _on_create_pressed():
	new_json["level_name"] = level_name.text
	new_json["time"] = (int(minute.text) * 60) + int(second.text)
	for entry in selected_vbox.get_children():
		var question_dict = {}
		question_dict["question"] = entry.find_node("question_content").text
		question_dict["answer"] = entry.find_node("answer_content").text
		question_list.append(question_dict)
	new_json["questions"] = question_list
	var json_string = to_json(new_json)
	var file_path = "res://online_mode/createQuiz_student/test.json"
	var file = File.new()
	
	if file.open(file_path, File.WRITE) == OK:
		file.store_string(json_string)
		file.close()
		print("JSON file saved to: " + file_path)
	else:
		print("Failed to open the file for writing")
	
	create_confirmation.visible = false

func _on_create_button_pressed():
	if level_name.text != "" && minute.text != "" && minute.text.is_valid_integer() && second.text != "" && second.text.is_valid_integer():
		create_confirmation.visible = true
	else:
		error.visible = true


func _on_continue_pressed():
	error.visible = false
