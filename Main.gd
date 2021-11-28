extends Node

""""
const OBlock = preload("res://Blocks/OBlock.tscn")
const TBlock = preload("res://Blocks/TBlock.tscn")
const LBlock = preload("res://Blocks/LBlock.tscn")
const JBlock = preload("res://Blocks/JBlock.tscn")
const SBlock = preload("res://Blocks/SBlock.tscn")
const ZBlock = preload("res://Blocks/ZBlock.tscn")
const IBlock = preload("res://Blocks/IBlock.tscn")
"""
var _available_blocks = {
	OBlock = preload("res://Blocks/OBlock.tscn"),
	TBlock = preload("res://Blocks/TBlock.tscn"),
	LBlock = preload("res://Blocks/LBlock.tscn"),
	JBlock = preload("res://Blocks/JBlock.tscn"),
	SBlock = preload("res://Blocks/SBlock.tscn"),
	ZBlock = preload("res://Blocks/ZBlock.tscn"),
	IBlock = preload("res://Blocks/IBlock.tscn")
}

const TICK_SPEED_MS = 1000
const CELL_SIZE     = 40

var _current_block = null
var _current_block_rotation_deg = 0

# DEBUG SECTION
# TODO: Make toggable via menu
var _DEBUG_auto_move_disabled = false
var _DEBUG_up_move_enabled = false
var _DEBUG_shop_collision_hints = false

func _ready():
	randomize()
	var random_block = _available_blocks.keys()[randi() % _available_blocks.size()]
	print(randi() % _available_blocks.size())
	_current_block = _available_blocks[random_block].instance()

	add_child(_current_block)
	_current_block.position = $BlockSpawn/BlockSpawnArea.position
	
	$BlockMoveTimer.start()
	
	if _DEBUG_shop_collision_hints:
		get_tree().debug_collisions_hint = true

func _on_BlockMoveTimer_timeout():
	if _DEBUG_auto_move_disabled:
		return
	if _current_block_can_move(Vector2.DOWN):
		_current_block.position.y += CELL_SIZE

func _process(_delta):
	pass


func _current_block_can_move(direction):
	var ray = _current_block.get_node("Ray")
	var rad_rotation = deg2rad(_current_block_rotation_deg)
	ray.cast_to = (direction * (CELL_SIZE * 2)).rotated(-rad_rotation)
	ray.force_raycast_update()
	return !ray.is_colliding()


func _input(_event):
	if Input.is_key_pressed(KEY_LEFT):
		if(_current_block_can_move(Vector2.LEFT)):
			_current_block.position.x -= CELL_SIZE
	if Input.is_key_pressed(KEY_RIGHT):
		if(_current_block_can_move(Vector2.RIGHT)):
			_current_block.position.x += CELL_SIZE
	if Input.is_key_pressed(KEY_DOWN):
		if(_current_block_can_move(Vector2.DOWN)):
			_current_block.position.y += CELL_SIZE
	if Input.is_key_pressed(KEY_UP):
		if _DEBUG_up_move_enabled:
			if(_current_block_can_move(Vector2.UP)):
				_current_block.position.y -= CELL_SIZE
	if Input.is_key_pressed(KEY_SPACE):
		# TODO: Validate rotation is possible
		# TODO: Wall evasion
		_current_block.set_rotation_degrees(_update_rotation())

func _update_rotation():
	if _current_block_rotation_deg == 270:
		_current_block_rotation_deg = 0
	else:
		_current_block_rotation_deg += 90
	
	return _current_block_rotation_deg
