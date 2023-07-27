extends Window

export( NodePath ) onready var inventory_container = get_node( inventory_container ) as Control

var current_inventories : Array = []

func _ready():
	SignalManager.connect( "inventory_opened", self, "_on_inventory_opened" )
	SignalManager.connect( "inventory_closed", self, "_on_inventory_closed" )


func close():
	for i in current_inventories:
		inventory_container.remove_child( i )
		i.open()
	
	current_inventories = []
	hide()


func _on_inventory_opened( inventory : Inventory ):
	inventory.is_open = true
	
	if current_inventories.has( inventory ):
		return
	
	inventory_container.add_child( inventory )
	current_inventories.append( inventory )
	show()

func _on_inventory_closed( inventory : Inventory ):
	inventory.close()
	inventory_container.remove_child( inventory )
	current_inventories.remove( current_inventories.find( inventory ) )
	
	if current_inventories.size() == 0:
		hide()
