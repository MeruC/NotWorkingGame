extends KinematicBody

#NodeReferences
onready var camera = $Camera
onready var player: KinematicBody = $"."
onready var pivot = $Pivot

export var max_speed = 10
export var acceleration = 70
export var friction = 60
var velocity := Vector3.ZERO

var start_pos = Vector3(0, .5, 0)

var can_move = false
var is_moving = false
var frame = 0
var prev
var timer = null#$Pivot/walk/Timer

onready var idle = $Pivot/CSGSphere
onready var walk = $Pivot/walk
onready var walking = [$"Pivot/walk/1", $"Pivot/walk/2", $"Pivot/walk/3", $"Pivot/walk/4"]

func _ready():
	timer = Timer.new()
	timer.set_one_shot(false)
	timer.set_wait_time(0.2)
	timer.connect("timeout", self, "animation")
	add_child(timer)

func _physics_process(delta: float) -> void:
	var input_vector = get_input_vector()
	var direction = get_direction(input_vector)
	apply_friction(direction, delta)
	apply_movement(input_vector, direction, delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	
	
func _process(delta):
	if velocity.x == 0 and velocity.z == 0:
		idle.set_visible(true)
		walk.set_visible(false)
		walk.global_translation.y = 1
		if (timer.time_left > 0):
			timer.stop()
	else:
		idle.set_visible(false)
		walk.set_visible(true)	
		if !(timer.time_left > 0):
			timer.start()
	
func animation():
	prev = frame
	frame += 1
	if(frame > 3): frame = 0
	walking[prev].set_visible(false)
	walking[frame].set_visible(true)
	if(frame/2==0):
		walk.global_translation.y = 0.9
	else:
		walk.global_translation.y = 1


#Getting The Input
func get_input_vector():
	var input_vector := Vector3.ZERO
	if(can_move):
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
