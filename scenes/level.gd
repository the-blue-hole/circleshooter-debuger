extends Node2D

#1. load
var circle_scene: PackedScene = load("res://scenes/circle.tscn")
var cuber_scene: PackedScene = load("res://scenes/cuber.tscn")

var health: int = 3

func _ready():
	#set up
	get_tree().call_group("ui", "set_health", health)
	
	#lines
	var size = get_viewport().get_visible_rect().size
	var rng := RandomNumberGenerator.new()
	for line in $Lines.get_children():
		# pos
		var _random_x = rng.randi_range(0, int(size.x))
		var _random_y = rng.randi_range(0, int(size.y))
		#line.position = Vector2(random_x, random_y)
		
		#scale
		var _random_scale = rng.randf_range(1, 2)
		#line.scale = Vector2(random_x, random_y)

		#speed
		#line.speed_scale = rng.randf_range(0.6,1.4)

func _on_circle_timer_timeout():
	#2. create
	var circle = circle_scene.instantiate()
	
	#3. attach
	$Circles.add_child(circle)
	
	#connect
	circle.connect("collision", _on_circle_collision)

func _on_circle_collision():
	health -= 1
	get_tree().call_group("ui", "set_health", health)
	if health <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	$Player.player_collision_sound()

func _on_player_cuber(pos):
	var cuber = cuber_scene.instantiate()
	$Cubers.add_child(cuber)
	cuber.position = pos
