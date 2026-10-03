extends CharacterBody2D


# stats
var accelleration = 300.0
var friction = 20.0
var jump_velocity = -200.0
var health = 10.0
var damage = 2.0
var fire_rate = 1.0
var bullet_speed = 2.0

var atteack_minimum = -1.0 # move to player before this distance
var attack_maximum = 1000.0 # can't move when further to player tha this

# misc
var loaded = false
@onready var player = get_tree().get_first_node_in_group("player")
var player_distance: float = 0.0
var direction: Vector2 = Vector2.ZERO

# objects
@onready var timer: Timer = $Timer
const ENEMY_BULLET = preload("uid://ciua73xce7h8j")

func _ready() -> void:
	timer.start(fire_rate)


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if player_distance > atteack_minimum and player_distance < attack_maximum:
		movement(delta)
	
	if loaded:
		fire()
	
	
	move_and_slide()


func movement(delta):
	player_distance = position.distance_to(player.position)
	#len(player.position - position)
	direction = (player.position - position).normalized()
	velocity.x += ((direction.x * accelleration) - (velocity.x * friction)) * delta


func fire():
	var inst = ENEMY_BULLET.instantiate()
	inst.damage = damage
	inst.speed = bullet_speed
	get_parent().add_child(inst)
	inst.position = position
	inst.look_at(player.position)
	inst.velocity.x = -inst.speed
	loaded = false
	timer.start(fire_rate)


func damaged(bullet_damage):
	health -= bullet_damage


func _on_timer_timeout() -> void:
	loaded = true
