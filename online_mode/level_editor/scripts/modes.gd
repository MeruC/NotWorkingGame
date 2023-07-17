extends Scale_Control

export( NodePath ) onready var main = get_node(main) as Spatial
export( NodePath ) onready var current = get_node(current) as Label

var player
export( NodePath ) onready var ui = get_node(ui) as CanvasLayer
export( NodePath ) onready var inventory = get_node(inventory) as CanvasLayer
export( NodePath ) onready var mobile_controls = get_node(mobile_controls) as CanvasLayer

export(PackedScene) var playerSpawn

func _ready():
	Global.editor_mode = "place"
	current.text = "Current Mode: Place"

func _on_modes_mouse_entered():
	Global.can_place = false
	print(Global.can_place)


func _on_modes_mouse_exited():
	Global.can_place = true
	print(Global.can_place)



func _on_place_pressed():
	Global.editor_mode = "place"


func _on_rotate_pressed():
	Global.editor_mode = "rotate"


func _on_remove_pressed():
	Global.editor_mode = "remove"

func _on_play_pressed():
	if(Global.edit_mode==true):
		Global.editor_mode = "play"
		var new_item = playerSpawn.instance() 
		main.add_child(new_item)
		new_item.owner = main
		player = main.get_node("Player")
		#new_item.global_translation = Vec
		main.get_node("Editor_Camera/Camera").current=false
		main.get_node("Player/Camera/Camera").current=true
		#player.can_move = true
		#player.set_visible(true)
		ui.set_visible(false)
		inventory.set_visible(true)
		mobile_controls.set_visible(true)
		Global.edit_mode=false
	elif(Global.edit_mode==false):
		get_parent().remove_child(player)
		player.queue_free()
		main.get_node("Editor_Camera/Camera").current=true
		Global.can_place = true
		#player.can_move = false
		#player.set_visible(false)
		ui.set_visible(true)
		inventory.set_visible(false)
		mobile_controls.set_visible(false)
		Global.edit_mode=true
