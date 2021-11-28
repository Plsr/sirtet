extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("block instanciated")
	var sprites = get_tree().get_nodes_in_group("Sprites")
	for sprite in sprites:
		sprite.modulate = Color.limegreen


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
