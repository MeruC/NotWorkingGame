class_name Item extends TextureRect

signal item_placed_in_player_inventory( is_on_player )
signal quantity_changed( quantity )
signal depleted()

var id : String
var type # Game_Enums.ITEM_TYPE
var item_name : String
var rarity = Game_Enums.RARITY.NORMAL
var equipment_type = Game_Enums.EQUIPMENT_TYPE.NONE
var stack_size : int = 1
var quantity : int = 1 setget set_quantity
var level : int = 1
var components = {}
var unique_data = null

var lbl_quantity
var item_slot setget set_slot

func _init( item_id, data ):
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	id = item_id
	item_name = data.name
	level = data.level
	texture = ResourceManager.sprites[ id ]
	type = Game_Enums.ITEM_TYPE[ data.type ]
	
	if type == Game_Enums.ITEM_TYPE.EQUIPMENT: equipment_type = Game_Enums.EQUIPMENT_TYPE[ data.equipment_type ]
	if data.has( "rarity" ): rarity = Game_Enums.RARITY[ data.rarity ]
	if data.has( "stack_size" ): stack_size = data.stack_size
	if data.has( "base_stats" ): components[ "base_stats" ] = Base_stat.new( data.base_stats )
	if data.has( "unique" ): unique_data = data[ "unique" ]
	if data.has( "usable" ):
		components[ "usable" ] = ItemManager.get_usable( data.usable, self )
		add_child( components.usable )


func _ready():
	lbl_quantity = ResourceManager.get_instance( "quantity" )
	add_child( lbl_quantity )
	lbl_quantity.quantity = quantity

func set_quantity( value ):
	quantity = value
	emit_signal( "quantity_changed", quantity )
	
	if lbl_quantity:
		lbl_quantity.quantity = quantity
	
	if quantity <= 0:
		emit_signal( "depleted" )
		destroy()

func add_item_quantity( value ):
	var remainder = quantity + value - stack_size
	quantity = int( min( quantity + value, stack_size ) )
	set_quantity( quantity )
	return remainder

func get_name():
	if components.has( "affix_list" ) and rarity == Game_Enums.RARITY.MAGIC:
		var prefix = ""
		var suffix = ""
		
		for affix_item in components.affix_list.affixes:
			if affix_item.affix_group.type == Game_Enums.AFFIX_TYPE.PREFIX:
				prefix = affix_item.affix.affix_name
			else:
				suffix = affix_item.affix.affix_name
		return ( "%s %s %s" % [ prefix, item_name, suffix ] ).strip_edges()
	return item_name

func set_slot( value ):
	item_slot = value
	emit_signal( "item_placed_in_player_inventory", item_slot.is_on_player if item_slot else false )

func destroy():
	if item_slot:
		item_slot.remove_item()
