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
	# If we are trying to place an item
	if new_item:
		return has_new_item( new_item )
	
	# If we want to pick up the item already in the slot with an empty hand
	elif item:
		new_item = item
		set_item( null )
	
	# Return an item or null
	emit_signal( "item_changed" )
	return new_item


func has_new_item( new_item ):
	# if there is already an item in the slot
	if item:
		return has_both_item( new_item )
	
	# simply place the item in the empty slot
	else:
		set_item( new_item )
		emit_signal( "item_changed" )
		return null


func has_both_item( new_item ):
	# Check if the item in hand and the one in the slot can be stacked
	if can_stack( new_item ):
		var remainder = item.add_item_quantity( new_item.quantity )
		new_item.quantity = remainder
	
	# swap the item in hand with the one in the slot
	else:
		var temp_item = item
		remove_item_child()
		set_item( new_item )
		new_item = temp_item
	
	return new_item if new_item.quantity > 0 else null

func can_stack( new_item ) -> bool:
	return item.id == new_item.id and item.quantity < item.stack_size

func remove_item_child():
	item_container.remove_child( item )

func remove_item():
	put_item( null )

func _on_item_container_visibility_changed():
	emit_signal( "mouse_exited" )
