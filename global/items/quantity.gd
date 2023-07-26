extends Label

var quantity setget set_quantity

func set_quantity(value):
	text = str(value)
	visible = value > 1
