extends Scale_Control

export( NodePath ) onready var item_menu = get_node( item_menu ) as PopupMenu
export( NodePath ) onready var split_stack = get_node( split_stack ) as Split_Stack

var actions = []

# Functions
func display( slot ):
	item_menu.rect_global_position = slot.rect_global_position
	item_menu.clear()
	actions = []
	
	#add_action( "Split", split_stack.display( slot ) )
	
	for c in slot.item.components:
		if not slot.item.components[ c ].has_method( "get_action" ):
			continue
		
		var action = slot.item.components[ c ].get_action()
		add_action( action.name, action.function )
	
	if InventoryManager.is_shop_open:
		add_action( "Sell", funcref( slot, "sell_item" ) )
	
	item_menu.popup()
	item_menu.rect_size = Vector2.ZERO

func add_action( action_name, action ):
	actions.append( action )
	item_menu.add_item( action_name )


func _on_PopupMenu_id_pressed( id ):
	actions[ id ].call_func()
