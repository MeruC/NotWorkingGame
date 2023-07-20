extends Button

export(PackedScene) var this_scene
export( Array, String ) var placeOn
export(float) var height
onready var object_cursor = get_node("/root/main/Editor_Object")

#onready var cursor_sprite = object_cursor.get_node("Sprite")

func _ready():
	connect("gui_input",self,"_item_clicked")
	pass # Replace with function body.


func _item_clicked(event):
	if event is InputEventMouseButton:
		object_cursor.current_item_name = self.text
		object_cursor.current_item = this_scene
		object_cursor.placeOn = placeOn
		object_cursor.height = height * 0.0625

func _on_item_texture_mouse_entered():
	pass


func _on_item_texture_mouse_exited():
	pass
