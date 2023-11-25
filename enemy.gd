extends Node2D


var projectile = preload("res://projectile.tscn")
var launch_timer = 0

func _launch_projectile():
	var projectiles = projectile.instantiate()
	
	get_parent().add_child(projectiles)
	projectiles.global_position = $Marker2D.global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	launch_timer += delta
	if launch_timer >= 0.5:
		launch_timer = 0
		_launch_projectile()

func _on_area_2d_area_entered(_area):
	queue_free()
