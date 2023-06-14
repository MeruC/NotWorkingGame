extends Button

export(PackedScene) var this_scene
onready var object_cursor = get_node("/root/main/Editor_Object")

#onready var cursor_sprite = object_cursor.get_node("Sprite")

func _ready():
	connect("gui_input",self,"_item_clicked")
	pass # Replace with function body.


func _item_clicked(event):
	if(event is InputEvent):
		if(event.is_action_pressed("mb_left")):
			object_cursor.current_item = this_scene
			#cursor_sprite.texture = texture
		
	pass

func _on_item_texture_mouse_entered():
	object_cursor.can_place = false
	print(object_cursor.can_place)


func _on_item_texture_mouse_exited():
	object_cursor.can_place = true
	print(object_cursor.can_place)
