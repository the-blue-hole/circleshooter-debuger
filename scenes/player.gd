extends CharacterBody2D

@export var speed := 500
@export var dash_speed := 1500
@export var dash_duration := 0.2
@export var dash_cooldown := 3.0

var can_shoot: bool = true
var is_dashing: bool = false
var dash_timer: float = 0.0
var dash_cooldown_timer: float = 0.0  # New cooldown timer

signal cuber(pos)

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(100, 500)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if is_dashing:
		handle_dashing(delta)
	else:
		handle_movement(delta)

	# Update cooldown timer
	if dash_cooldown_timer > 0:
		dash_cooldown_timer -= delta

	# Shoot
	if Input.is_action_just_pressed("shoot") and can_shoot:
		cuber.emit($CuberStartPos.global_position)
		can_shoot = false
		$CuberTimer.start()
		$CuberSound.play()

func handle_movement(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")

	# Dash input
	if Input.is_action_just_pressed("dash") and not is_dashing and dash_cooldown_timer <= 0:
		start_dashing(direction)
		return

	# Normal movement
	velocity = direction * speed
	move_and_slide()

func start_dashing(direction: Vector2) -> void:
	is_dashing = true
	velocity = direction.normalized() * dash_speed
	dash_timer = dash_duration
	dash_cooldown_timer = dash_cooldown  # Start the cooldown timer

func handle_dashing(delta: float) -> void:
	move_and_slide()  # Move while dashing
	dash_timer -= delta
	if dash_timer <= 0.0:
		is_dashing = false

func player_collision_sound():
	if $DamageSound.is_inside_tree():
		$DamageSound.play()

func _on_cuber_timer_timeout():
	can_shoot = true
