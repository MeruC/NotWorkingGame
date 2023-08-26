class_name Item_Upgrade extends Item_Usable

func _init( data, parent_item ).( data, parent_item ):
	on_use_text = "Uprade an item to mag or rare."
	condition = "Have an item that is normal or magic in your inventory."

func get_use_text():
	return on_use_text

func execute():
	SignalManager.emit_signal( "upgrade_item" )

func _on_inventory_group_content_changed( groups ):
	if groups.has( "player" ):
		can_use = InventoryManager.has_upgradable_items( "player" )
		emit_signal( "can_use_changed", get_can_use() )
