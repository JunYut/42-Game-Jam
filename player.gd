extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var projectile
var can_parry = false
var is_alive = true

func _physics_process(delta):
	can_parry = false
	
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
	
func _parry():
	#$Parry/CollisionShape2D.disabled = 0
	print("parry!")
	if can_parry:
		projectile.position.x *= -1
		velocity.y = JUMP_VELOCITY

func _respawn():
	get_tree().reload_current_scene()

func _die():
	is_alive = false
	queue_free()

func _on_hitbox_area_entered(_area):
	if _area.is_in_group("projectile"):
		_die()


func _on_parry_area_entered(_area):
	print("projectile incoming")
	can_parry = true
	projectile = $projectile
