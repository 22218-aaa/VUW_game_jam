extends CharacterBody2D


#stat vars
const ACCELLERATION = 4000.0
const FRICTION = 10
const JUMP_VELOCITY = -250.0

var damage = 10.0
var bullet_speed = 200
var fire_rate = 0.1
var loaded = true


# objects
const BULLET = preload("uid://ciua73xce7h8j")
@onready var reload_timer: Timer = $reload_timer


func _input(_event: InputEvent) -> void:
	if InputEvent:
		if Input.is_action_just_pressed("escape"):
			get_tree().quit()
		if Input.is_action_pressed("shoot"):
			if loaded:
				fire()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	
	var direction := Input.get_axis("left", "right")
	velocity.x += ((direction * ACCELLERATION) - (velocity.x * FRICTION)) * delta
	
	
	move_and_slide()




func fire():
	var aim = (get_global_mouse_position() - position).normalized()
	var inst = BULLET.instantiate()
	inst.damage = damage
	inst.speed = aim * bullet_speed
	get_parent().add_child(inst)
	inst.position = position
	inst.look_at(position + aim)
	inst.set_collision_mask_value(3, true)
	loaded = false
	reload_timer.start(fire_rate)


func _on_reload_timer_timeout() -> void:
	loaded = true
