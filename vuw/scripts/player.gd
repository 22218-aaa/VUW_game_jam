extends CharacterBody2D


const ACCELLERATION = 4000.0
const FRICTION = 10
const JUMP_VELOCITY = -400.0

func _process(delta: float) -> void:
	if $".".is_paused():
		print("yes")

func _input(_event: InputEvent) -> void:
	if InputEvent:
		if Input.is_action_just_pressed("escape"):
			get_tree().quit()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	velocity.x += ((direction * ACCELLERATION) - (velocity.x * FRICTION)) * delta

	move_and_slide()
