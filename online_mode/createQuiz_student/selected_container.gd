extends HBoxContainer

export(NodePath) onready var delete_confirmation


func _ready():
	pass # Replace with function body.

func _on_delete_pressed():
	delete_confirmation.visible = true
	delete_confirmation.find_node("yes").question = find_node("question_content").text
