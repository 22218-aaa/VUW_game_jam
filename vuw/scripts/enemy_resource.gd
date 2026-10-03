extends Resource
class_name enemy_resource

@export_category("enemy")
@export var accelleration = 0 #1500.0
@export var friction = 20.0
@export var jump_velocity = -200.0
@export var jump_rate = 0.1
@export var health = 10.0

@export_category("bullet")
@export var damage = 2.0
@export var fire_rate = 1.5
@export var bullet_speed = 200.0

@export_category(("ranges"))
@export var fire_range = 1000 # fire only within this range (melee/ranged)
@export var attack_minimum = -1.0 # move to player before this distance
@export var attack_maximum = 1000.0 #
