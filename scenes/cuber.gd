extends Area2D

@export var speed = 500

func _ready():
	var tween = create_tween()
	tween.tween_property($Sprite2D, "scale" , Vector2(0.11,0.11),0.2).from(Vector2(0,0))

func _process(delta):
	position.y -= speed * delta
