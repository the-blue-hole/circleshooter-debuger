extends Control



func _ready():
	pass



func _process(delta):
	pass


func _on_start_pressed():
	get_tree().change_scene_to_file("res://scenes/level.tscn")


func _on_setting_pressed():
	print("no")


func _on_exit_pressed():
	get_tree().quit()
