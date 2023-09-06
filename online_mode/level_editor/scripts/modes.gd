extends Scale_Control

export( NodePath ) onready var main = get_node(main) as Spatial
export( NodePath ) onready var current = get_node(current) as Label

var player
export( NodePath ) onready var ui = get_node(ui) as CanvasLayer
var inventory
var mobile_controls
var joystick
export( NodePath ) onready var previews = get_node(previews) as Spatial
export( NodePath ) onready var no_sign = get_node(no_sign) as StaticBody
export( NodePath ) onready var item_select = get_node(item_select) as Control
export( NodePath ) onready var other_ui = get_node(other_ui) as Control

export(PackedScene) var playerSpawn
var last_mode = "place"

func _ready():
	Global.editor_mode = "place"
	current.text = "Current Mode: Place"

func _on_modes_mouse_entered():
	Global.can_place = false
	print(Global.can_place)


func _on_modes_mouse_exited():
	Global.can_place = true
	print(Global.can_place)

func _process(delta):
	match (Global.editor_mode):
		"place":
			current.text = "Current Mode: Place"
		"rotate":
			current.text = "Current Mode: Rotate"
		"remove":
			current.text = "Current Mode: Remove"
		_:
			current.text = "Current Mode: Play"


func _on_place_pressed():
	Global.editor_mode = "place"
	item_select.set_visible(true)
	yield(get_tree().create_timer(0.2),"timeout")
	Global.can_place = true


func _on_rotate_pressed():
	Global.editor_mode = "rotate"
	item_select.set_visible(false)


func _on_remove_pressed():
	Global.editor_mode = "remove"
	item_select.set_visible(false)

func _on_play_pressed():
	inventory = main.get_node("level/inventory/ui")
	mobile_controls = main.get_node("level/mobile_controls")
	joystick = main.get_node("level/mobile_controls/joystick")
	if(Global.editor_mode != "play"):
		#Editor Mode
		last_mode = Global.editor_mode
		Global.editor_mode = "play"
		
		#Spawning Player
		var new_item = playerSpawn.instance() 
		main.add_child(new_item)
		new_item.owner = main
		player = main.get_node("Player")
		
		#Changing Camera
		main.get_node("Editor_Camera/Camera").current=false
		main.get_node("Player/Camera/Camera").current=true
		
		#Changing UI
		other_ui.set_visible(true)
		ui.set_visible(false)
		inventory.set_visible(true)
		mobile_controls.set_visible(true)
		joystick.use_input_actions = true
		previews.set_visible(false)
		no_sign.set_visible(false)
	elif(Global.editor_mode == "play"):
		#Editor Mode
		Global.editor_mode = last_mode
		#Deleting player
		main.remove_child(player)
		player.queue_free()
		
		#Changing Camera
		main.get_node("Editor_Camera/Camera").current=true
		
		#Changing UI
		other_ui.set_visible(false)
		ui.set_visible(true)
		inventory.set_visible(false)
		mobile_controls.set_visible(false)
		joystick.use_input_actions = false
		previews.set_visible(true)
		no_sign.set_visible(true)


func _on_select_pressed():
	Global.editor_mode = "select"
	item_select.set_visible(false)
