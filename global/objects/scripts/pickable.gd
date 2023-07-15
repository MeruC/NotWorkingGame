extends Area


export( String ) var item_id

var item : Item
var action = "pickup"
var object_name = ""

func _ready():
	if not item:
		item = ItemManager.get_item( item_id )
	
	object_name = item.item_name


func interact():
	SignalManager.emit_signal( "item_picked", item, self )


func item_picked():
	queue_free()
	
