extends CharacterBody2D

# Variables
const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var projectile
var parry_window = 0.5
var double_jump = 1
var is_alive = true

# Preparations
func  _ready():
	pass
	
	
# In game events
func _physics_process(delta):
	if not is_alive:
		_respawn()

	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("parry"):
		_parry()

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_just_pressed("ui_left") and $Marker2D.position.x > 0:
		$Marker2D.position.x *= -1
	elif Input.is_action_just_pressed("ui_right") and $Marker2D.position.x < 0:
		$Marker2D.position.x *= -1
		
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
# Functions
func _parry():
	$Marker2D/Parry/CollisionShape2D.disabled = false
	$"Marker2D/Parry/Parry window".start(parry_window)


func _respawn():
	get_tree().reload_current_scene()


func _die():
	is_alive = false
	queue_free()

# Signals
func _on_hitbox_area_entered(area):
	if area.is_in_group("projectile"):
		_die()


func _on_parry_area_entered(area):
	if area.is_in_group("projectile"):
		if not is_on_floor():
			if velocity.y > 0:
				velocity.y += -500
			else:
				velocity.y += -100


func _on_parry_window_timeout():
	$Marker2D/Parry/CollisionShape2D.disabled = true
