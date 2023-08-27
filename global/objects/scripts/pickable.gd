extends Area

export( String ) var item_id

var item : Item
var action = "pickup"
var object_name = ""

func _ready():
	if not item:
		item = ItemManager.get_item( item_id )
	object_name = item.item_name
	InventoryManager.add_hidden_node( item )

func interact():
	if InventoryManager.has_space_for_items( [ item.get_data() ], "player" ):
		InventoryManager.remove_hidden_node( item )
		InventoryManager.add_items( [ item ], "player" )
		queue_free()
