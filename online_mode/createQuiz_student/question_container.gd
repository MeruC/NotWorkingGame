extends HBoxContainer

export(NodePath) onready var delete_confirmation
export(NodePath) onready var selected_container
export(PackedScene) var selected_question
export(NodePath) onready var question_content = get_node(question_content) as Label
export(NodePath) onready var answer_content = get_node(answer_content) as Label

func _ready():
	pass # Replace with function body.
	
func _on_CheckBox_toggled(button_pressed):
	# Adds the selected questions to selected questions tab
	if button_pressed:
		var new_selected = selected_question.instance()
		new_selected.find_node("question_content").text = question_content.text
		new_selected.find_node("answer_content").text = answer_content.text
		new_selected.delete_confirmation = delete_confirmation
		selected_container.add_child(new_selected)
	else:
		for entry in selected_container.get_children():
			if entry.find_node("question_content").text == question_content.text:
				entry.queue_free()
	##
