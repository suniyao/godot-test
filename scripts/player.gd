extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@onready var is_swimming = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		$AnimatedSprite2D.play("jump")
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		$AnimatedSprite2D.flip_h = direction < 0
		$AnimatedSprite2D.play("walk")
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		$AnimatedSprite2D.stop()
		
	if Input.is_action_just_pressed("swim_jump"):
		$AnimatedSprite2D.play("swimming-dive")
		is_swimming = true
	
	if Input.is_key_pressed(KEY_A):
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("swim")
		is_swimming = true

	if Input.is_key_pressed(KEY_D):
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("swim")
		is_swimming = true
		
	if not is_swimming:
		$AnimatedSprite2D.stop()
		
	move_and_slide()
		
# handle swim 
