extends KinematicBody

#something

#NodeReferences
onready var camera = $Camera
onready var player: KinematicBody = $"."
onready var pivot = $Pivot

export var max_speed = 10
export var acceleration = 70
export var friction = 60
var velocity := Vector3.ZERO

export( Resource ) var player_data

var start_pos = Vector3(0, .5, 0)

var is_moving = false

onready var walk_animation = $AnimationPlayer

onready var idle = $Pivot/CSGSphere
onready var walk = $Pivot/walk

export( NodePath ) onready var interact_zone = get_node( interact_zone ) as Area
export( NodePath ) onready var interact_labels = get_node( interact_labels ) as Control

var current_interactable

func _physics_process(delta: float) -> void:
	var input_vector = get_input_vector()
	var direction = get_direction(input_vector)
	apply_friction(direction, delta)
	apply_movement(input_vector, direction, delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	#if player_data:
	#	player_data.global_position = player.global_translation
	
func _process(delta):
	if velocity.x == 0 and velocity.z == 0:
		idle.set_visible(true)
		walk.set_visible(false)
		walk.global_translation.y = 1
		walk_animation.current_animation = "RESET"
	else:
		idle.set_visible(false)
		walk.set_visible(true)	
		walk_animation.current_animation = "player_walk"
		
	if not current_interactable:
		var overlapping_area = interact_zone.get_overlapping_areas()
		
		if overlapping_area.size() > 0 and overlapping_area[ 0 ].has_method("interact"):
			current_interactable = overlapping_area[ 0 ]
			interact_labels.display(current_interactable)


#Getting The Input
func get_input_vector():
	var input_vector := Vector3.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.z = Input.get_action_strength("down") - Input.get_action_strength("up")
	return input_vector.normalized() if input_vector.length() > 1 else input_vector

#Getting the Camera Facing Direction
func get_direction(input_vector):
	var direction = (input_vector.x * camera.transform.basis.x) + (input_vector.z * camera.transform.basis.z)
	return direction
	
#Actually Moving the Player
func apply_movement(input_vector, direction, delta):
	if direction != Vector3.ZERO:
		velocity.x = velocity.move_toward(direction * max_speed, acceleration * delta).x
		velocity.z = velocity.move_toward(direction * max_speed, acceleration * delta).z
		pivot.look_at(global_transform.origin + direction, Vector3.UP)

#Friction Physics
func apply_friction(direction, delta):
	if direction == Vector3.ZERO:
		velocity = velocity.move_toward(Vector3.ZERO, friction * delta)
		

func _on_Player_visibility_changed():
	player.global_translation = start_pos
	pass # Replace with function body.

#Interactions
func _input( event ):
	if event.is_action_pressed("interact") and current_interactable:
		current_interactable.interact()

func _on_InteractionArea_area_exited(area):
	if current_interactable == area:
		if current_interactable.has_method( "out_of_range" ):
			current_interactable.out_of_range()
		
		interact_labels.hide()
		current_interactable = null
