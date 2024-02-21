extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -200.0

var jumpCounter = 2
var sprintAdjustment = 1.00

var finalSpeed = SPEED * sprintAdjustment

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

# Adjustment value for gravity
var gravityAdjustment = 0.5

func _process(_delta) :
	if is_on_floor() :
		jumpCounter = 2

func _physics_process(delta) :
	# Add the gravity.
	if not is_on_floor() :
		velocity.y += (gravity * gravityAdjustment) * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jumpCounter > 0 :
		velocity.y = JUMP_VELOCITY
		if not is_on_floor() :
			jumpCounter -= 2
		else :
			jumpCounter -= 1

	if Input.is_action_pressed("sprint") :
		sprintAdjustment = 1.5
	else :
		sprintAdjustment = 1.0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction :
		velocity.x = direction * (SPEED * sprintAdjustment)
	else :
		velocity.x = move_toward(velocity.x, 0, (SPEED * sprintAdjustment))

	move_and_slide()
