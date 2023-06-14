extends Button
onready var object_cursor = get_node("/root/main/Editor_Object")
var player
onready var ui = get_node("/root/main/UI")
onready var main = $".."

export(PackedScene) var playerSpawn

var edit_mode = true

func _on_play_pressed():
	if(edit_mode==true):
		var new_item = playerSpawn.instance() 
		main.add_child(new_item)
		new_item.owner = main
		player = get_node("/root/main/Player")
		#new_item.global_translation = Vec
		$"../Editor_Camera/Camera".current=false
		$"../Player/Camera/Camera".current=true
		object_cursor.can_place = false
		player.can_move = true
		player.set_visible(true)
		ui.set_visible(false)
		edit_mode=false
	elif(edit_mode==false):
		get_parent().remove_child(player)
		player.queue_free()
		$"../Editor_Camera/Camera".current=true
		object_cursor.can_place = true
		player.can_move = false
		player.set_visible(false)
		ui.set_visible(true)
		edit_mode=true
	pass # Replace with function body.


func _on_play_mouse_entered():
	object_cursor.can_place = false
	print(object_cursor.can_place)


func _on_play_mouse_exited():
	object_cursor.can_place = true
