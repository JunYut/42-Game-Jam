extends Area2D

var speed = 300

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(Vector2(speed * delta, 0))
	
func set_linear_velocity(velocity: Vector2):
	position += velocity * get_physics_process_delta_time()

func _destroy_projectile(_area):
	pass # Replace with function body.


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	print("DEBUG")
	self.queue_free()
