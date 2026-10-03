extends CharacterBody2D


#stat vars
const ACCELLERATION: float = 4000.0
const FRICTION: float = 10.0
const JUMP_VELOCITY: float = -320.0

var energy: float = 100.0
var energy_capacity: float = 100.0

var damage: float = 10.0
var bullet_speed: float = 200
var fire_rate: float = 0.1
var loaded: bool = true

var max_jumps: int = 2
@onready var jumps: int = max_jumps

# objects
const BULLET = preload("uid://ciua73xce7h8j")
@onready var reload_timer: Timer = $reload_timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label


func _input(_event: InputEvent) -> void:
	if InputEvent:
		if Input.is_action_just_pressed("escape"):
			get_tree().quit()
		if Input.is_action_pressed("shoot"):
			if loaded:
				fire()


func _ready() -> void:
	energy = Global.energy
	energy_capacity = Global.energy_capacity
	damage = Global.damage
	bullet_speed = Global.bullet_speed
	fire_rate = Global.fire_rate
	max_jumps = Global.max_jumps



func _physics_process(delta: float) -> void:
	label.text = str(energy) + "/" + str(energy_capacity)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jumps = max_jumps
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and jumps > 0:
		velocity.y = JUMP_VELOCITY
		jumps -= 1
	
	
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


func damaged(bullet_damage):
	energy -= bullet_damage
	animation_player.play("damaged")
	
	if energy <= 0:
		get_tree().change_scene_to_file("res://scenes/death_screen.tscn")


func _on_reload_timer_timeout() -> void:
	loaded = true


func _on_tree_exiting() -> void:
	Global.energy = energy
	Global.energy_capacity = energy_capacity
	Global.damage = damage
	Global.bullet_speed = bullet_speed
	Global.fire_rate = fire_rate
	Global.max_jumps = max_jumps
