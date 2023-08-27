class_name Inventory extends InnerPanel

## Signals ##
signal content_changed()

## Exports ##
export( String ) var inventory_name
export( int ) var size = 0 setget set_inventory_size
export( NodePath ) onready var slot_container = get_node( slot_container ) as Control

## Variables ##
var groups : Array = []
var slots : Array = []
var is_open = false
var has_upgradable_items = false

## Setters ##
func set_inventory_size( value ):
	size = value
	
	for s in size:
		var new_slot = ResourceManager.get_instance( "inventory_slot" )
		slots.append( new_slot )

## Built-in ##
func _ready():
	for s in slots:
		s.connect( "item_changed", self, "_on_item_changed" )
		slot_container.add_child( s )
	
	set_title( inventory_name )
	SignalManager.emit_signal( "inventory_ready", self )
	connect( "content_changed", InventoryManager, "_on_inventory_content_changed" )

## Functions ##
func add_item( item ):
	# Place items that can stack on unfinished stack first
	if item.stack_size > 1:
		for s in slots:
			if s.item and s.item.id == item.id and s.item.quantity < s.item.stack_size:
				item = s.put_item( item )
				if item == null: break
	# Place item on first available slot
	if item:
		for s in slots:
			if s.try_put_item( item ):
				item = s.put_item( item )
				if not item: break
	content_has_changed()
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
						var temp = items[ i ]
						items.remove( i )
						temp.queue_free()
					else:
						items[ i ].quantity -= free_space
						break
	return items

func accept_items( items : Array ):
	for s in slots:
		for i in range( items.size() - 1, -1, -1 ):
			if s.accept_item( items[ i ] ):
				var temp = items[ i ]
				items.remove( i )
				temp.queue_free()
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
				slots[ s ].item.queue_free()
				slots[ s ].item = null
			else:
				slots[ s ].item.quantity -= quantity
				content_has_changed()
				return 0
	content_has_changed()
	return quantity

func open():
	if is_open: return
	is_open = true
	InventoryManager.remove_hidden_node( self )

func close():
	if not is_open: return
	is_open = false
	get_parent().remove_child( self )
	InventoryManager.add_hidden_node( self )
	
	for s in slots:
		s.emit_signal( "mouse_exited" )

func content_has_changed():
	set_upgradable_items()
	emit_signal( "content_changed", groups )

func get_data() -> Dictionary:
	var data = {}
	for s in slots.size():
		if slots[ s ].item:
			data[ s ] = slots[ s ].item.get_data()
	return data

func set_data( data ):
	for i in slots.size():
		var old_item = slots[ i ].put_item( null )
		if old_item: old_item.queue_free()
		if data.has( i ):
			slots[ i ].put_item( ItemManager.get_item_from_data( data[ i ] ) )

## Signal Connexions ##
func _on_item_changed():
	content_has_changed()
