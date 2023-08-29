class_name Equipment_Slot extends Inventory_Slot

export( NodePath ) onready var placeholder = get_node( placeholder ) as TextureRect

export ( Game_Enums.EQUIPMENT_TYPE ) var type

func _ready():
	placeholder.texture = ItemManager.get_placeholder( type )

func accept_item( new_item ) -> bool:
	return new_item.equipment_type == type and .accept_item( new_item )

func try_put_item( new_item : Item ) -> bool:
	return accept_item( new_item ) and .try_put_item( new_item )


func put_item( new_item : Item ) -> Item:
	if new_item:
		if new_item.equipment_type != type:
			return new_item
		
		placeholder.hide()
	else:
		placeholder.show()
	
	return .put_item( new_item )

func get_stat( stat ):
	return item.get_stat( stat ) if item else 0
