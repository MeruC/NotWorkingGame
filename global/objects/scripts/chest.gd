class_name Chest extends Area

export( int ) var size = 1
export( String ) var inventory_name
export( Array, String ) var items

var inventory : Inventory
var action = "open"
var object_name = "Chest"

func _ready():
	inventory = ResourceManager.get_instance( "inventory" )
	object_name = inventory_name
	inventory.size = size
	inventory.inventory_name = inventory_name
	set_items()
	InventoryManager.add_hidden_node( inventory )

func set_items():
	for i in items:
		inventory.add_item( ItemManager.get_item( i ) )

func interact():
	SignalManager.emit_signal( "inventory_opened", inventory )

func out_of_range():
	if inventory.is_open:
		SignalManager.emit_signal( "inventory_closed", inventory )
