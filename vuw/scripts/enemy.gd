extends CharacterBody2D


@export var stats: enemy_resource

# misc
var loaded = false
@onready var player = get_tree().get_first_node_in_group("player")
var player_distance: float = 0.0
var direction: Vector2 = Vector2.ZERO

# objects
@onready var timer: Timer = $Timer
@onready var jump_timer: Timer = $"jump timer"
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
const BULLET = preload("uid://ciua73xce7h8j")

func _ready() -> void:
	print(stats.colour)
	sprite.modulate = stats.colour
	jump_timer.start(stats.jump_rate)
	timer.start(stats.fire_rate)


func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if player_distance > stats.attack_minimum and player_distance < stats.attack_maximum:
		movement(delta)
	
	if loaded and player_distance < stats.fire_range:
		fire()
	
	
	move_and_slide()


func movement(delta):
	player_distance = position.distance_to(player.position)
	#len(player.position - position)
	direction = (player.position - position).normalized()
	velocity.x += ((direction.x * stats.accelleration) - (velocity.x * stats.friction)) * delta


func fire():
	var inst = BULLET.instantiate()
	inst.damage = stats.damage
	inst.speed = direction * stats.bullet_speed
	get_parent().add_child(inst)
	inst.position = position
	inst.look_at(player.position)
	inst.set_collision_mask_value(2, true)
	loaded = false
	timer.start(stats.fire_rate)


func damaged(bullet_damage):
	stats.health -= bullet_damage
	animation_player.play("hurt")
	if stats.health <= 0.0:
		death()
		queue_free()


func death():
	pass


func _on_timer_timeout() -> void:
	loaded = true


func _on_jump_timer_timeout() -> void:
	if is_on_floor():
		if player_distance > stats.attack_minimum and player_distance < stats.attack_maximum:
			velocity.y += stats.jump_velocity
