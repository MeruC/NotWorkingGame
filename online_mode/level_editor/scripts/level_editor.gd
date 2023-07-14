extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var level = get_node("/root/main/level/")
onready var wall = get_node("/root/main/level/wall/")
onready var playarea = get_node("/root/main/level/wall/playarea")
onready var inventory = get_node("/root/main/level/inventory")


var timer = null
var x = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	wall.owner = level
	playarea.owner = level
	inventory.owner = level
	playarea.set_width(Global.w * 2)
	playarea.set_depth(Global.d * 2)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func on_timeout_complete():
	#print(x)
	#x += 1
	pass
