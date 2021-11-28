extends Node

export (PackedScene) var Block

const TICK_SPEED_MS = 1000
const CELL_SIZE     = 40

var _current_block = null

# DEBUG SECTION
var _DEBUG_auto_move_disabled = false
var _DEBUG_up_move_enabled = false

func _ready():
	print($BlockArea/BlockMoveArea)
	_current_block = Block.instance()
	
	add_child(_current_block)
	_current_block.position = $BlockSpawn/BlockSpawnArea.position
	
	
	$BlockMoveTimer.start()

func _on_BlockMoveTimer_timeout():
	if _DEBUG_auto_move_disabled:
		return
	if _current_block_can_move(Vector2.DOWN):
		_current_block.position.y += CELL_SIZE

func _process(delta):
	pass


func _current_block_can_move(direction):
	var ray = _current_block.get_node("Ray")
	var block_widht = _current_block.get_node("CollisionShape2D").shape.extents.x
	ray.cast_to = direction * (CELL_SIZE + block_widht)
	ray.force_raycast_update()
	return !ray.is_colliding()


func _input(event):
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
		if(_current_block_can_move(Vector2.UP) && _DEBUG_up_move_enabled):
			_current_block.position.y -= CELL_SIZE
