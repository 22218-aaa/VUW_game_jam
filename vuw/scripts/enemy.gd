@tool

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
@onready var sprite: Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
const BULLET = preload("uid://ciua73xce7h8j")

@onready var bug: Sprite2D = $bug
@onready var tank: Sprite2D = $tank
@onready var slime: Sprite2D = $slime
@onready var robot: Sprite2D = $robot



func _ready() -> void:
	bug.visible = false
	tank.visible = false
	slime.visible = false
	robot.visible = false
	
	if stats.enemy_name == "bug": sprite = bug
	if stats.enemy_name == "tank": sprite = tank
	if stats.enemy_name == "slime": sprite = slime
	if stats.enemy_name == "robot": sprite = robot
	
	sprite.visible = true # error means name is wrong
	
	
	print(stats.colour)
	sprite.modulate = stats.colour
	jump_timer.start(stats.jump_rate)
	timer.start(stats.fire_rate)


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		bug.visible = false
		tank.visible = false
		slime.visible = false
		robot.visible = false
		
		if stats.enemy_name == "bug": sprite = bug
		if stats.enemy_name == "tank": sprite = tank
		if stats.enemy_name == "slime": sprite = slime
		if stats.enemy_name == "robot": sprite = robot
		
		sprite.visible = true
		return
	
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
	inst.sprite.modulate = Color(1.0, 0.0, 0.0, 1.0)
	loaded = false
	timer.start(stats.fire_rate)


func damaged(bullet_damage):
	stats.health -= bullet_damage
	animation_player.play("hurt")
	if stats.health <= 0.0:
		death()
		queue_free()


func death():
	get_tree().change_scene_to_file("res://scenes/corridor.tscn")




func _on_timer_timeout() -> void:
	loaded = true


func _on_jump_timer_timeout() -> void:
	if is_on_floor():
		if player_distance > stats.attack_minimum and player_distance < stats.attack_maximum:
			velocity.y += stats.jump_velocity
