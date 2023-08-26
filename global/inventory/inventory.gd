class_name Inventory extends InnerPanel

signal content_changed()

var inventory_slot_res = preload("res://global/inventory/inventory_slot.tscn")

export( String ) var inventory_name
export( int ) var size = 0 setget set_inventory_size

export( NodePath ) onready var slot_container = get_node( slot_container ) as Control

var groups : Array = []
var slots : Array = []
var is_open = false
var has_upgradable_items = false

func _ready():
	for s in slots:
		s.connect( "item_changed", self, "_on_item_changed" )
		slot_container.add_child( s )
	
	set_title( inventory_name )
	SignalManager.emit_signal( "inventory_ready", self )

func set_inventory_size( value ):
	size = value
	
	for s in size:
		var new_slot = inventory_slot_res.instance()
		slots.append( new_slot )


func add_item( item ):
	# Place items that can stack on unfinished stack first
	item = add_stack_item( item )
	
	# Place item on first available slot
	if item:
		for s in slots:
			if s.try_put_item( item ):
				item = s.put_item( item )
				if not item: break
	content_has_changed()
	return item

func add_stack_item( item ):
	if item.stack_size > 1:
		for s in slots:
			if s.item and s.item.id == item.id and s.item.quantity < s.item.stack_size:
				item = s.put_item( item )
				if item == null: break
	return item

# Try to place the stakable items in the array, if they can be placed they are removed if the stack is empty.
func try_place_stack_items( items : Array ):
	for s in slots:
		if s.item and s.item.quantity < s.item.stack_size:
			var free_space = s.item.stack_size - s.item.quantity
			for i in range( items.size() - 1, -1, -1 ):
				if s.item.id == items[ i ].id:
					if items[ i ].quantity <= free_space:
						free_space -= items[ i ].quantity
						items.remove( i )
					else:
						items[ i ].quantity -= free_space
						break
	return items

func accept_items( items : Array ):
	for s in slots:
		for i in range( items.size() - 1, -1, -1 ):
			if s.accept_item( items[ i ] ):
				items.remove( i )
				break
	return items

func add_group( group_id ):
	groups.append( group_id )
	for s in slots:
		s.add_group( group_id )

func set_upgradable_items():
	for s in slots:
		if s.item and s.item.type == Game_Enums.ITEM_TYPE.EQUIPMENT and s.item.rarity < Game_Enums.RARITY.RARE:
			has_upgradable_items = true
			return
	has_upgradable_items = false

func get_item_count( id ):
	var count = 0
	for s in slots:
		if s.item and s.item.id == id:
			count += s.item.quantity
	return count

func remove_item_quantity( id, quantity ):
	for s in range( slots.size() - 1, -1, -1 ):
		if slots[ s ].item and slots[ s ].item.id == id:
			if quantity >= slots[ s ].item.quantity:
				quantity -= slots[ s ].item.quantity
				slots[ s ].item.quantity = 0
				slots[ s ].item = null
			else:
				slots[ s ].item.quantity -= quantity
				content_has_changed()
				return 0
	content_has_changed()
	return quantity

func open():
	is_open = true

func close():
	is_open = false
	
	for s in slots:
		s.emit_signal( "mouse_exited" )

func content_has_changed():
	set_upgradable_items()
	emit_signal( "content_changed", groups )

func _on_item_changed():
	content_has_changed()
