class_name Item_Usable extends Node

signal start_cooldown( item_usable )
signal cooldown_tick( cooldown_remaining )
signal can_use_changed( can_use )

var unlimited_use = false
var cooldown = 1
var cooldown_remaining = 0
var is_in_cooldown = false
var can_use = false setget set_can_use
var can_always_use = false
var on_use_text = ""
var condition = ""

var item : Item

func _init( data, parent_item ):
	item = parent_item
	set_data( data )
	item.connect( "item_placed_in_player_inventory", self, "_on_item_placed_in_player_inventory" )

func _process( delta ):
	if is_in_cooldown:
		cooldown_remaining -= delta
		emit_signal( "cooldown_tick", cooldown_remaining )
		
		if cooldown_remaining <= 0:
			is_in_cooldown = false

func set_data( data ):
	if data.has( "unlimited_use" ): unlimited_use = data.unlimited_use
	if data.has( "cooldown" ): cooldown = data.cooldown

func set_can_use( value ):
	can_use = value
	emit_signal( "can_use_changed", get_can_use() )

func get_can_use():
	return ( can_use or can_always_use ) and item.item_slot and item.item_slot.is_on_player

func use():
	if get_can_use() and not is_in_cooldown:
		execute()
		
		if not unlimited_use:
			item.quantity -= 1
		
		is_in_cooldown = true
		cooldown_remaining = cooldown
		item.add_child( get_cooldown_instance() )
		emit_signal( "start_cooldown", self )

func execute():
	pass

func get_cooldown_instance():
	var cooldown_node = ResourceManager.get_instance( "cooldown" )
	cooldown_node.set_data( self )
	return cooldown_node

func _on_item_placed_in_player_inventory( _value ):
	emit_signal( "can_use_changed", get_can_use() )

func get_use_text():
	pass

func set_info( item_info ):
	item_info.add_splitter()
	item_info.add_line( Item_Info_Line.new( "On use:", Game_Enums.RARITY.NORMAL ) )
	item_info.add_line( Item_Info_Line.new( get_use_text(), item.rarity ) )
	item_info.add_line( Item_Info_Line.new( "Condition:", Game_Enums.RARITY.NORMAL ) )
	item_info.add_line( Item_Info_Line.new( condition, item.rarity ) )





