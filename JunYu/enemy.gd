extends CharacterBody2D


var is_alive = true
var projectile_scene = preload("res://projectile.tscn")
var projectile_speed = 300
var launch_timer = 0

func _launch_projectile():
	var projectile = projectile_scene.instantiate()
	add_child(projectile)
	projectile.global_position = global_position + Vector2(30, 0)
	projectile.set_linear_velocity(Vector2(1, 0).normalized() * projectile_speed)

func _got_hit(area):
	if is_alive and area is Area2D:
		is_alive = false
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_got_hit(projectile_scene)	
	launch_timer += delta
	if launch_timer >= 0.5:
		launch_timer = 0
		_launch_projectile()
