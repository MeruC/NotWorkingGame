class_name Inventory_Slot extends TextureRect

signal item_changed()

export( NodePath ) onready var item_container = get_node( item_container ) as Control

var item : Item
var ready = false
var is_on_player

func _ready():
	ready = true
	
	if item:
		item_container.add_child( item )
		item.item_slot = self

func set_item( new_item ):
	if not new_item:
		item_container.remove_child( item )
		item.item_slot = null
	elif ready:
		item_container.add_child( new_item )
		new_item.item_slot = self
	
	item = new_item

func try_put_item( new_item : Item ) -> bool:
	return new_item and not item or ( item.id == new_item.id and item.quantity < item.stack_size )

func put_item( new_item : Item ) -> Item:
	if new_item:
		return has_new_item( new_item )
	elif item:
		new_item = item
		set_item( null )
	
	emit_signal( "item_changed" )
	return new_item


func has_new_item( new_item ):
	if item:
		return has_both_item( new_item )
	else:
		set_item( new_item )
		emit_signal( "item_changed" )
		return null


func has_both_item( new_item ):
	if can_stack( new_item ):
		var remainder = item.add_item_quantity( new_item.quantity )
		
		if remainder < 1:
			return null
	else:
		var temp_item = item
		remove_item_child()
		set_item( new_item )
		new_item = temp_item
	
	return new_item

func can_stack( new_item ) -> bool:
	return item.id == new_item.id and item.quantity < item.stack_size

func remove_item_child():
	item_container.remove_child( item )

func remove_item():
	put_item( null )
