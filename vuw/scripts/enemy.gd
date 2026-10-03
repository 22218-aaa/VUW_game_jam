extends CharacterBody2D


var accelleration = 300.0
var friction = 20.0
var jump_velocity = -200.0
var health = 10.0
var damage = 2.0
var fire_rate = 1.0
var bullet_speed = 2.0


var atteack_minimum = -1.0 # move to player before this distance
var attack_maximum = 1000.0 # can't move when further to player tha this

var loaded = true
@onready var player = get_tree().get_first_node_in_group("player")
var player_distance: float = 0.0
var direction: Vector2 = Vector2.ZERO


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
	pass


func damaged(bullet_damage):
	health -= bullet_damage


func _on_timer_timeout() -> void:
	loaded = true
