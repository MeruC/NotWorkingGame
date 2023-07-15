extends Dragable_Control

export( NodePath ) onready var inventory_right = get_node( inventory_right ) as Inventory
export( NodePath ) onready var inventory_left = get_node( inventory_left ) as Inventory
export(NodePath) onready var equipment = get_node(equipment) as Inventory

func _ready():
	var inventories = [ equipment, inventory_left, inventory_right ]
	SignalManager.emit_signal( "player_inventory_ready", inventories )
