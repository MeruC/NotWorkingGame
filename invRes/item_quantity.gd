extends ColorRect

export ( NodePath ) onready var item_container = get_node( item_container ) as Control
export ( NodePath ) onready var lbl_quantity = get_node( lbl_quantity ) as Label

func set_info( item : Item, quantity : int ):
	item_container.add_child( item )
	lbl_quantity.text = str( quantity )
