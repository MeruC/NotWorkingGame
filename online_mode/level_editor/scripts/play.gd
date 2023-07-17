extends Scale_Control

var player
export( NodePath ) onready var ui = get_node(ui) as CanvasLayer
export( NodePath ) onready var inventory = get_node(inventory) as CanvasLayer
export( NodePath ) onready var mobile_controls = get_node(mobile_controls) as CanvasLayer
onready var main = $".."

export(PackedScene) var playerSpawn

func _on_play_pressed():
	if(Global.edit_mode==true):
		var new_item = playerSpawn.instance() 
		main.add_child(new_item)
		new_item.owner = main
		player = get_node("/root/main/Player")
		#new_item.global_translation = Vec
		get_node("root/main/Editor_Camera/Camera").current=false
		get_node("root/main/Player/Camera/Camera").current=true
		Global.can_place = false
		player.can_move = true
		player.set_visible(true)
		ui.set_visible(false)
		inventory.set_visible(true)
		mobile_controls.set_visible(true)
		Global.edit_mode=false
	elif(Global.edit_mode==false):
		get_parent().remove_child(player)
		player.queue_free()
		get_node("root/main/Editor_Camera/Camera").current=true
		Global.can_place = true
		player.can_move = false
		player.set_visible(false)
		ui.set_visible(true)
		inventory.set_visible(false)
		mobile_controls.set_visible(false)
		Global.edit_mode=true
	pass # Replace with function body.


func _on_play_mouse_entered():
	Global.can_place = false
	print(Global.can_place)


func _on_play_mouse_exited():
	Global.can_place = true
	
	func _on_play_pressed():
	if(Global.edit_mode==true):
		var new_item = playerSpawn.instance() 
		main.add_child(new_item)
		new_item.owner = main
		player = get_node("/root/main/Player")
		#new_item.global_translation = Vec
		$"../Editor_Camera/Camera".current=false
		$"../Player/Camera/Camera".current=true
		Global.can_place = false
		player.can_move = true
		player.set_visible(true)
		ui.set_visible(false)
		inventory.set_visible(true)
		mobile_controls.set_visible(true)
		Global.edit_mode=false
	elif(Global.edit_mode==false):
		get_parent().remove_child(player)
		player.queue_free()
		$"../Editor_Camera/Camera".current=true
		Global.can_place = true
		player.can_move = false
		player.set_visible(false)
		ui.set_visible(true)
		inventory.set_visible(false)
		mobile_controls.set_visible(false)
		Global.edit_mode=true
	pass # Replace with function body.
