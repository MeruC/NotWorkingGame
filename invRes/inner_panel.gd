class_name InnerPanel extends PanelContainer

export ( NodePath ) onready var lbl_panel_title = get_node( lbl_panel_title ) as Label

var title : String setget set_title

func set_title( value ):
	title = value
	lbl_panel_title.text = "- " + title + " -"
