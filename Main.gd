extends Node

export (PackedScene) var Block
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var block = Block.instance()
	print($BlockPath/BlockSpawnLocation.position)
	print(block)
	block.position = $BlockPath/BlockSpawnLocation.position
	add_child(block)
	print(block.position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
