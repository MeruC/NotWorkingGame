extends Area

export( String ) var crafting_list

var action = "craft"
var object_name = crafting_list

func interact():
	SignalManager.emit_signal( "crafting_opened", crafting_list )

func out_of_range():
	SignalManager.emit_signal( "crafting_out_of_range" )
