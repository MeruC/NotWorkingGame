class_name Inventory_Slot extends TextureRect

export( NodePath ) onready var item_container = get_node( item_container ) as Control

var item : Item setget set_item
var ready = false

func _ready():
	ready = true
	
	if item:
		item_container.add_child( item )

func set_item( new_item ):
	if not new_item:
		item_container.remove_child( item )
	elif ready:
		item_container.add_child( new_item )
	
	item = new_item

func try_put_item( new_item : Item ) -> bool:
	return new_item and not item or ( item.id == new_item.id and item.quantity < item.stack_size )

func put_item( new_item : Item ) -> Item:
	if new_item:
		if item:
			if item.id == new_item.id and item.quantity < item.stack_size:
				var remainder = item.add_item_quantity(new_item.quantity)
				
				if remainder < 1:
					return null
			else:
				var temp_item = item
				item_container.remove_child( item )
				set_item( new_item )
				new_item = temp_item
			
			return new_item
		else:
			set_item( new_item )
			return null
	elif item:
		new_item = item
		set_item( null )
	
	return new_item
