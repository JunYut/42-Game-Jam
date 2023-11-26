extends Area2D


var speed = 300
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += (speed * delta)

func _on_visible_on_screen_notifier_2d_screen_exited():
	#print("Exited the screen")
	queue_free()

func _on_area_entered(area):
	if area.is_in_group("parry hit box"):
		speed *= -1
	else:
		queue_free()
