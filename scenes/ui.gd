extends CanvasLayer

static var image = load("res://bruh.png")
var time_elapsed := 0

func set_health(amount):
	#remove
	for child in $MarginContainer2/HBoxContainer.get_children():
		child.queue_free()

	#create
	for i in amount:
		var text_rect = TextureRect.new()
		text_rect.texture = image
		$MarginContainer2/HBoxContainer.add_child(text_rect)
		text_rect.stretch_mode = TextureRect.STRETCH_KEEP
		


func _on_score_timer_timeout():
	time_elapsed += 1
	$MarginContainer/Label.text = str(time_elapsed)
	Global.score = time_elapsed
	
