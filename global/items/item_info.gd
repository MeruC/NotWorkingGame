class_name Item_Info extends Scale_Control

export( NodePath ) onready var item_name = get_node( item_name ) as Label
export( NodePath ) onready var line_container = get_node( line_container ) as Control

func display( slot : Inventory_Slot ):
	for c in line_container.get_children():
		line_container.remove_child( c )
		c.queue_free()
	
	rect_size.x = 0
	rect_global_position = ( slot.rect_size * SettingsManager.scale ) + slot.rect_global_position
	item_name.text = slot.item.get_name()
	var rarity_name = Game_Enums.RARITY.keys()[ slot.item.rarity ].capitalize()
	var line_type = Item_Info_Line.new( rarity_name + "   " + ItemManager.get_type_name( slot.item ), slot.item.rarity )
	line_container.add_child( line_type )
	
	for c in slot.item.components.values():
		c.set_info( self )
	
	show()
	yield( get_tree(), "idle_frame" )
	
	var max_width = 0
	var height = 0
	for c in line_container.get_children():
		height += c.rect_size.y + 2
		if c.rect_size.x > max_width:
			max_width = c.rect_size.x
	rect_size = Vector2( max_width + 30, height + 8 )


func add_line( line ):
	line_container.add_child( line )

func add_splitter():
	add_line( ResourceManager.tscn.splitter.instance() )




