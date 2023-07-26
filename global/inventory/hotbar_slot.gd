class_name Hotbar_Slot extends Inventory_Slot

export ( NodePath ) onready var lbl_key = get_node( lbl_key ) as Label
export ( NodePath ) onready var item_texture = get_node( item_texture ) as TextureRect

var key : String
var cooldown_node : Control
var lbl_quantity : Label

func _ready():
	lbl_key.text = key
	lbl_quantity = ResourceManager.get_instance( "quantity" )
	add_child( lbl_quantity )

func _input( event ):
	if event.is_action_pressed( "hotbar_" + key ) and item and item.components.has( "usable" ):
		print( "Used hotbar slot: ", key )
		item.components.usable.use()

func set_item( new_item ):
	if item:
		item_texture.texture = null
		item.disconnect( "quantity_changed", self, "_on_quantity_changed" )
		item.disconnect( "depleted", self, "remove_item" )
		lbl_quantity.quantity = 0
		
		if item.components.has( "usable" ):
			var usable = item.components.usable
			usable.disconnect( "start_cooldown", self, "_on_start_cooldown" )
			usable.disconnect( "can_use_changed", self, "_on_can_use_changed" )
			
			if usable.is_in_cooldown:
				cooldown_node.queue_free()
	
	if new_item:
		item_texture.texture = new_item.texture
		new_item.connect( "quantity_changed", self, "_on_quantity_changed" )
		new_item.connect( "depleted", self, "remove_item" )
		lbl_quantity.quantity = new_item.quantity
		
		if new_item.components.has( "usable" ):
			var usable = new_item.components.usable
			usable.connect( "start_cooldown", self, "_on_start_cooldown" )
			usable.connect( "can_use_changed", self, "_on_can_use_changed" )
			set_enabled_color( false )
			
			if usable.is_in_cooldown:
				set_cooldown( usable )
	else:
		set_enabled_color( true )
	
	item = new_item


func remove_item_child():
	pass

func can_stack( _new_item ):
	return false

func put_item( new_item ):
	.put_item( new_item )
	return new_item


func set_enabled_color( value ):
	modulate = Color( 1, 1, 1, 1 ) if value else Color( 0.5, 0.5, 0.5, 0.5 )

func set_cooldown( usable ):
	cooldown_node = usable.get_cooldown_instance()
	item_texture.add_child( cooldown_node )

func _on_quantity_changed( qty ):
	lbl_quantity.quantity = qty

func _on_start_cooldown( usable ):
	set_cooldown( usable )

func _on_can_use_changed( value ):
	set_enabled_color( value )
