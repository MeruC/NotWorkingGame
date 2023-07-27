extends Node

export( NodePath ) onready var item_in_hand_node = get_node( item_in_hand_node ) as Control
export( NodePath ) onready var item_info = get_node( item_info ) as Control
export( NodePath ) onready var split_stack = get_node( split_stack ) as Split_Stack

var player_inventories : Array = []
var inventories : Array = []
var item_in_hand : Item = null
var item_offset = Vector2.ZERO

func _ready():
	SignalManager.connect( "item_picked", self, "_on_item_picked" )
	SignalManager.connect( "inventory_ready", self, "_on_inventory_ready" )
	SignalManager.connect( "player_inventory_ready", self, "_on_player_inventory_ready" )
	split_stack.connect( "stack_splitted", self, "_on_stack_splitted" )


func _on_inventory_ready( inventory ):
	inventories.append( inventory )
	
	for slot in inventory.slots:
		slot.connect( "mouse_entered", self, "_on_mouse_entered_slot", [ slot ] )
		slot.connect( "mouse_exited", self, "_on_mouse_exited_slot" )
		slot.connect( "gui_input", self, "_on_gui_input_slot", [ slot ] )

func _input( event : InputEvent ):
	if event is InputEventMouseMotion and item_in_hand:
		item_in_hand.rect_position = ( event.position - item_offset ) / SettingsManager.scale
		

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


func set_hand_position( pos ):
	if item_in_hand:
		item_in_hand.rect_position = ( pos - item_offset ) / SettingsManager.scale

func _on_stack_splitted( slot, new_quantity ):
	slot.item.quantity -= new_quantity
	var new_item = ItemManager.get_item( slot.item.id )
	new_item.quantity = new_quantity
	item_in_hand = new_item
	item_in_hand_node.add_child( item_in_hand )
	set_hand_position( slot.rect_global_position )


func _on_item_picked( item, sender ):
	for i in player_inventories:
		item = i.add_item( item )
		
		if not item:
			sender.item_picked()
			return


func _on_player_inventory_ready( inv ):
	player_inventories = inv
