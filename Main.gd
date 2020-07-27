extends Node2D

const WHITE  = Color(1, 1, 1)
const BLACK  = Color(0, 0, 0)
const GREEN  = Color(0, 1, 0)
const YELLOW = Color(1, 1, 0)
const RED    = Color(1, 0, 0)

const map = [
	[1, 1, 1, 1, 1, 1, 1, 1],
	[1, 0, 0, 1, 0, 0, 0, 1],
	[1, 0, 0, 1, 0, 0, 0, 1],
	[1, 0, 0, 0, 0, 0, 0, 1],
	[1, 0, 0, 0, 0, 0, 0, 1],
	[1, 1, 0, 0, 0, 1, 0, 1],
	[1, 0, 0, 0, 0, 0, 0, 1],
	[1, 1, 1, 1, 1, 1, 1, 1]
]
const cell_size = 64

var player = {
	size = Vector2(8, 8),
	position = Vector2(256, 256),
	angle = PI/4,
	direction = Vector2(cos(PI/4), sin(PI/4))
}
const indicator_length = 32
const move_speed = 128
const turn_speed = 4


func _process(delta):
	if Input.is_action_pressed("ui_left"):
		player.angle -= turn_speed * delta
		if (player.angle < 0):
			player.angle += 2*PI
		player.direction = Vector2(cos(player.angle), sin(player.angle))
	if Input.is_action_pressed("ui_right"):
		player.angle += turn_speed * delta
		if (player.angle > 2*PI):
			player.angle -= 2*PI
		player.direction = Vector2(cos(player.angle), sin(player.angle))
	if Input.is_action_pressed("ui_up"):
		player.position += player.direction * move_speed * delta
	if Input.is_action_pressed("ui_down"):
		player.position -= player.direction * move_speed * delta
	update();


func _draw():
	### MAP
	for row in range(len(map)):
		for col in range(len(map[row])):
			var color = WHITE if map[row][col] == 1 else BLACK
			var position = Vector2(col*cell_size+1, row*cell_size+1)
			var size = Vector2(cell_size-1, cell_size-1)
			draw_rect(Rect2(position, size), color)
	
	### PLAYER
	# Player body
	draw_rect(Rect2(player.position, player.size), GREEN)
	
	# Direction indicator
	var from_player = player.position+player.size/2
	var to = from_player+player.direction*indicator_length
	draw_line(from_player, to, YELLOW)
