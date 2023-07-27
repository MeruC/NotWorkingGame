extends Window

export( NodePath ) onready var inventory_right = get_node( inventory_right ) as Inventory
export( NodePath ) onready var inventory_left = get_node( inventory_left ) as Inventory
export( NodePath ) onready var equipment = get_node( equipment ) as Inventory

func _ready():
	var inventories = [ equipment, inventory_left, inventory_right ]
	SignalManager.emit_signal( "player_inventory_ready", inventories )
	SignalManager.connect( "upgrade_item", self, "_on_upgrade_item" )
	inventory_left.connect( "content_changed", self, "_on_content_changed" )
	inventory_right.connect( "content_changed", self, "_on_content_changed" )
	
	for i in inventories:
		for s in i.slots:
			s.is_on_player = true

func get_upgradable_items():
	var valid_items = []
	for i in [ inventory_left, inventory_right ]:
		for s in i.slots:
			if s.item and s.item.type == Game_Enums.ITEM_TYPE.EQUIPMENT and s.item.rarity < Game_Enums.RARITY.RARE:
				valid_items.append( s.item )
	return valid_items

func content_changed():
	var valid_items = get_upgradable_items()
	SignalManager.emit_signal( "has_upgradable_item", valid_items.size() > 0 )

func _on_content_changed():
	content_changed()

func _on_upgrade_item():
	var valid_items = get_upgradable_items()
	valid_items.shuffle()
	ItemManager.generate_rarity( valid_items[ 0 ], valid_items[ 0 ].level, valid_items[ 0 ].rarity + 1 )
	content_changed()
