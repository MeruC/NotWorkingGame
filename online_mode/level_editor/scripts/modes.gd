extends Scale_Control

export( NodePath ) onready var main = get_node(main) as Spatial
export( NodePath ) onready var current = get_node(current) as Label

var player
export( NodePath ) onready var ui = get_node(ui) as CanvasLayer
export( NodePath ) onready var inventory = get_node(inventory) as CanvasLayer
export( NodePath ) onready var mobile_controls = get_node(mobile_controls) as CanvasLayer
export( NodePath ) onready var joystick = get_node(joystick) as Control
export( NodePath ) onready var previews = get_node(previews) as Spatial
export( NodePath ) onready var no_sign = get_node(no_sign) as StaticBody

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


func _on_rotate_pressed():
	Global.editor_mode = "rotate"


func _on_remove_pressed():
	Global.editor_mode = "remove"

func _on_play_pressed():
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
		ui.set_visible(false)
		inventory.set_visible(true)
		mobile_controls.set_visible(true)
		joystick.use_input_actions = true
		previews.set_visible(false)
		no_sign.set_visible(false)
	elif(Global.editor_mode == "play"):
		#Editor Mode
		Global.editor_mode = last_mode
		#Deleting pLayer
		get_parent().remove_child(player)
		player.queue_free()
		
		#Changing Camera
		main.get_node("Editor_Camera/Camera").current=true
		
		#Changing UI
		ui.set_visible(true)
		inventory.set_visible(false)
		mobile_controls.set_visible(false)
		joystick.use_input_actions = false
		previews.set_visible(true)
		no_sign.set_visible(true)
