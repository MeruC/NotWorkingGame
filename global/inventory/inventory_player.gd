extends Window

export( NodePath ) onready var inventory_right = get_node( inventory_right ) as Inventory
export( NodePath ) onready var inventory_left = get_node( inventory_left ) as Inventory
#export( NodePath ) onready var equipment = get_node( equipment ) as Inventory

export( Resource ) var player_data

func _ready():
	SignalManager.connect( "upgrade_item", self, "_on_upgrade_item" )
	#InventoryManager.add_inventory_to_group( equipment, "player" )
	#InventoryManager.add_inventory_to_group( equipment, "equipment" )
	InventoryManager.add_inventory_to_group( inventory_left, "player" )
	InventoryManager.add_inventory_to_group( inventory_right, "player" )
	InventoryManager.add_inventory_to_group( inventory_left, "crafting" )
	InventoryManager.add_inventory_to_group( inventory_right, "crafting" )
	SignalManager.connect( "saving_game", self, "_on_saving_game" )
	player_data.connect( "changed", self, "_on_changed_data" )
	_on_changed_data()

func _on_upgrade_item():
	var valid_items = InventoryManager.get_upgradable_items( "player" )
	valid_items.shuffle()
	var item = valid_items[ 0 ]
	ItemManager.generate_rarity( item, item.level, item.rarity + 1 )
	item.item_slot.emit_signal( "item_changed" )

func _on_changed_data():
	if player_data.inventories.size() > 0:
		#equipment.set_data( player_data.inventories.equipment )
		inventory_left.set_data( player_data.inventories.inventory_left )
		inventory_right.set_data( player_data.inventories.inventory_right )

func _on_saving_game():
	#player_data.inventories.equipment = equipment.get_data()
	player_data.inventories.inventory_left = inventory_left.get_data()
	player_data.inventories.inventory_right = inventory_right.get_data()


#extends Window
#
#export( NodePath ) onready var inventory_right = get_node( inventory_right ) as Inventory
#export( NodePath ) onready var inventory_left = get_node( inventory_left ) as Inventory
##export( NodePath ) onready var equipment = get_node( equipment ) as Inventory
#
#export( Resource )
#
#func _ready():
#	SignalManager.connect( "upgrade_item", self, "_on_upgrade_item" )
#	#InventoryManager.add_inventory_to_group( equipment, "player" )
#	InventoryManager.add_inventory_to_group( inventory_left, "player" )
#	InventoryManager.add_inventory_to_group( inventory_right, "player" )
#	InventoryManager.add_inventory_to_group( inventory_left, "crafting" )
#	InventoryManager.add_inventory_to_group( inventory_right, "crafting" )
#
#func _on_upgrade_item():
#	var valid_items = InventoryManager.get_upgradable_items( "player" )
#	valid_items.shuffle()
#	var item = valid_items[ 0 ]
#	ItemManager.generate_rarity( item, item.level, item.rarity + 1 )
#	item.item_slot.emit_signal( "item_changed" )
