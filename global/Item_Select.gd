extends Scale_Control

onready var object_cursor = get_node("/root/main/Editor_Object")
onready var current_label = get_node("Label")

func _on_Done_pressed():
	get_parent().set_visible(false)
	yield(get_tree().create_timer(0.2),"timeout")
	Global.editor_mode = "place"
	Global.just_onMenu = true

func _input(event):
	current_label.text = "Currently Selected: " + object_cursor.current_item_name
