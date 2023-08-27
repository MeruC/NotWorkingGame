extends Node

## Exports ##
export( NodePath ) onready var item_in_hand_node = get_node( item_in_hand_node ) as Control
export( NodePath ) onready var item_info = get_node( item_info ) as Control
export( NodePath ) onready var item_void = get_node( item_void ) as Control
export( NodePath ) onready var split_stack = get_node( split_stack ) as Split_Stack
export( NodePath ) onready var hidden_nodes = get_node( hidden_nodes ) as Control

## Variables ##
var inventory_groups : Dictionary = {}
var inventories : Array = []
var item_in_hand : Item = null
var item_offset = Vector2.ZERO

## Built-in ##
func _ready():
	SignalManager.connect( "inventory_ready", self, "_on_inventory_ready" )
	split_stack.connect( "stack_splitted", self, "_on_stack_splitted" )
	item_void.connect( "gui_input", self, "_on_void_gui_input" )

func _input( event : InputEvent ):
	if event is InputEventMouseMotion and item_in_hand:
		item_in_hand.rect_position = ( event.position - item_offset ) / SettingsManager.scale

## Functions ##
func set_hand_position( pos ):
	set_item_void_filter()
	
	if item_in_hand:
		item_in_hand.rect_position = ( pos - item_offset ) / SettingsManager.scale

func set_item_void_filter():
	item_void.mouse_filter = Control.MOUSE_FILTER_STOP if item_in_hand else Control.MOUSE_FILTER_IGNORE

func has_space_for_items( items_data, group_id ):
	var items = ItemManager.get_items( items_data )
	
	for inv in inventory_groups[ group_id ]:
		items = inv.try_place_stack_items( items )
	
	for inv in inventory_groups[ group_id ]:
		items = inv.accept_items( items )
	return items.size() <= 0

func add_items( items, group_id ):
	for item in items:
		for inv in inventory_groups[ group_id ]:
			item = inv.add_item( item )
			if item == null: break

func add_inventory_to_group( inv, group_id ) -> void:
	if not inventory_groups.has( group_id ):
		inventory_groups[ group_id ] = []
	inventory_groups[ group_id ].append( inv )
	inv.add_group( group_id )

func get_inventories_from_group( group_id ):
	return inventory_groups[ group_id ]

func get_upgradable_items( group_id ):
	var valid_items = []
	for i in inventory_groups[ group_id ]:
		for s in i.slots:
			if s.item and s.item.type == Game_Enums.ITEM_TYPE.EQUIPMENT and s.item.rarity < Game_Enums.RARITY.RARE:
				valid_items.append( s.item )
	return valid_items

func has_upgradable_items( group_id ):
	for i in inventory_groups[ group_id ]:
		if i.has_upgradable_items:
			return true
	return false

func has_items( items_data, group_id ) -> bool:
	for item_data in items_data:
		if get_item_count( item_data.id, group_id ) < item_data.quantity:
			return false
	return true

func get_item_count( id, group_id ) -> int:
	var count = 0
	for inv in inventory_groups[ group_id ]:
		count += inv.get_item_count( id )
	return count

func remove_items( items, group_id ) -> void:
	for item in items:
		for inv in inventory_groups[ group_id ]:
			item.quantity = inv.remove_item_quantity( item.id, item.quantity )
			if item.quantity == 0: break

func add_hidden_node( node ):
	hidden_nodes.add_child( node )

func remove_hidden_node( node ):
	hidden_nodes.remove_child( node )

## Signal Connexions ##
func _on_stack_splitted( slot, new_quantity ):
	slot.item.quantity -= new_quantity
	var new_item = ItemManager.get_item( slot.item.id )
	new_item.quantity = new_quantity
	item_in_hand = new_item
	item_in_hand_node.add_child( item_in_hand )
	set_hand_position( slot.rect_global_position )
func _on_inventory_ready( inventory ):
	inventories.append( inventory )

func _on_void_gui_input( event ):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		item_in_hand_node.remove_child( item_in_hand )
		SignalManager.emit_signal( "item_dropped", item_in_hand )
		item_in_hand = null
		set_item_void_filter()

func _on_mouse_entered_slot( slot ):
	if slot.item:
		item_info.display( slot )

func _on_mouse_exited_slot():
	item_info.hide()

func _on_gui_input_slot( event : InputEvent, slot : Inventory_Slot ):
	if slot.item and slot.item.quantity > 1 and item_in_hand == null and event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT and Input.is_key_pressed( KEY_SHIFT ):
		if slot.item.quantity == 2:
			_on_stack_splitted( slot, 1 )
		else:
			split_stack.display( slot )
	elif event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			var had_empty_hand = item_in_hand == null
			
			if item_in_hand:
				item_in_hand_node.remove_child( item_in_hand )
			
			item_in_hand = slot.put_item( item_in_hand )
			
			if item_in_hand:
				if had_empty_hand:
					item_offset = event.global_position - slot.rect_global_position
				
				item_in_hand_node.add_child( item_in_hand )
			
			set_hand_position( event.global_position )
		
		elif event.button_index == BUTTON_RIGHT and slot.item and slot.item.components.has( "usable" ):
			slot.item.components.usable.use()
	
	if slot.item:
		slot.emit_signal( "mouse_entered" )
	else:
		slot.emit_signal( "mouse_exited" )

func _on_inventory_content_changed( groups ):
	SignalManager.emit_signal( "inventory_group_content_changed", groups )




