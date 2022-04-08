extends "res://src/actors/Actor.gd"
class_name Player

enum STATES {IDLE, MOVE, CROUCH, AERIAL}

export var fireball: PackedScene
export var accel: float
export var friction: float
export var air_resistance: float

onready var headbutt_area := $HeadbuttArea
onready var stomp_area := $StompArea
onready var death_line: int = $Camera2D.limit_bottom + 128

var state = STATES.IDLE
var direction: float
var can_jump_cancel: bool = true
var can_shoot: bool = true
var is_facing_right: bool = true
var is_jumping: bool = false

func control() -> void:
	get_input_direction()
	
	match state:
		STATES.IDLE:
			idle_state()
		STATES.MOVE:
			move_state()
		STATES.CROUCH:
			crouch_state()
		STATES.AERIAL:
			aerial_state()
	
	if position.y > death_line:
		die()
	
	var snap = Vector2.DOWN * 16 if !is_jumping else Vector2.ZERO
	velocity.y = move_and_slide_with_snap(velocity, snap, FLOOR_UP, true).y

func idle_state() -> void:
	$AnimationPlayer.play("idle")
	
	velocity.x = lerp(velocity.x, 0, friction)
	
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot()
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_force
		is_jumping = true
		$JumpSFX.play()
	
	if direction != 0:
		state = STATES.MOVE
	
	if Input.is_action_pressed("ui_down"):
		state = STATES.CROUCH
	
	if !is_on_floor():
		state = STATES.AERIAL

func move_state() -> void:
	$AnimationPlayer.play("walk")
	
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * max_speed, accel)
	
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot()
	
	if Input.is_action_just_pressed("jump"):
		velocity.y = -jump_force
		is_jumping = true
		$JumpSFX.play()

	if direction == 0:
		state = STATES.IDLE

	if Input.is_action_pressed("ui_down"):
		state = STATES.CROUCH
	
	if !is_on_floor():
		state = STATES.AERIAL

func crouch_state() -> void:
	$AnimationPlayer.play("crouch")
	velocity.x = lerp(velocity.x, 0, friction)
	
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot()
	
	if Input.is_action_just_pressed("jump"):
		position.y += 3

	if Input.is_action_just_released("ui_down"):
		state = STATES.IDLE
	
	if !is_on_floor():
		state = STATES.AERIAL

func aerial_state() -> void:
	$AnimationPlayer.play("aerial")
	
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * max_speed, accel)
	
	if Input.is_action_just_pressed("shoot") and can_shoot:
		shoot()
	
	if Input.is_action_just_released("jump") and can_jump_cancel and velocity.y < 0:
		can_jump_cancel = false
		velocity.y *= 0.25
	
	if is_on_floor():
		can_jump_cancel = true
		is_jumping = false
		state = STATES.IDLE

func get_input_direction() -> void:
	direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if direction > 0:
		is_facing_right = true
		$Sprite.flip_h = false
		$ProjectileEmitter.position.x = abs($ProjectileEmitter.position.x)
	elif direction < 0:
		is_facing_right = false
		$Sprite.flip_h = true
		$ProjectileEmitter.position.x = -abs($ProjectileEmitter.position.x)

func shoot() -> void:
	var fb = fireball.instance()
	owner.add_child(fb)
	fb.speed = abs(fb.speed) if is_facing_right else -abs(fb.speed)
	fb.transform = $ProjectileEmitter.global_transform
	can_shoot = false
	$ShootTimer.start()
	$FireSFX.play()

func hit() -> void:
	health -= 1
	if health <= 0:
		die()

func die() -> void:
	GameData.score = 0
	get_tree().reload_current_scene()

func _on_HeadbuttArea_body_entered(body: Node) -> void:
	if body.is_in_group("boxes"):
		if body.has_method("hit"):
			body.hit()

func _on_StompArea_body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		if body.has_method("stomped") and global_position.y < body.global_position.y:
			body.stomped()
			velocity.y = -jump_force * 0.75
		elif body.has_method("hit") and global_position.y < body.global_position.y:
			body.hit()
			velocity.y = -jump_force * 0.75

func _on_ShootTimer_timeout() -> void:
	can_shoot = true

