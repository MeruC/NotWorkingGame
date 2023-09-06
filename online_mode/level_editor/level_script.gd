extends Spatial

var player
var inventory
var mobile_controls
var joystick

func _ready():
	SignalManager.connect( "pc_opened", self, "_on_pc_opened" )
	SignalManager.connect( "pc_closed", self, "_on_pc_closed" )
	

func _on_pc_opened():
	inventory = get_node("inventory/ui")
	mobile_controls = get_node("mobile_controls")
	joystick = get_node("mobile_controls/joystick")
	#player = main.get_node("Player")
	
	#inventory.set_visible(false)
	mobile_controls.set_visible(false)
	joystick.use_input_actions = false
	
func _on_pc_closed():
	inventory = get_node("inventory/ui")
	mobile_controls = get_node("mobile_controls")
	joystick = get_node("mobile_controls/joystick")
	#player = main.get_node("Player")
	
	#inventory.set_visible(true)
	mobile_controls.set_visible(true)
	joystick.use_input_actions = true
