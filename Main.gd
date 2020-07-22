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
	position = Vector2(1, 1),
	angle = 0,
	direction = Vector2(cos(0), sin(0))
}
const indicator_length = 32
const move_speed = 20
const turn_speed = 3


func _process(delta):
	if Input.is_action_pressed("ui_left"):
		player.angle -= turn_speed * delta
		player.direction = Vector2(cos(player.angle), sin(player.angle))
	if Input.is_action_pressed("ui_right"):
		player.angle += turn_speed * delta
		player.direction = Vector2(cos(player.angle), sin(player.angle))
	update();


func _draw():
	### MAP
	for row in range(len(map)):
		for col in range(len(map[row])):
			var color = WHITE if map[row][col] == 1 else BLACK
			var position = Vector2(col*cell_size+1, row*cell_size+1)
			var size = Vector2(cell_size-1, cell_size-1)
			draw_rect(Rect2(position, size), color)
	
	### Player
	# Player body
	var position = player.position*cell_size+Vector2(1, 1)
	draw_rect(Rect2(position, player.size), GREEN)
	
	# Direction indicator
	var from = position+player.size/2
	var to = from+player.direction*indicator_length
	draw_line(from, to, YELLOW)
	
	# FOV indicator
	var f_theta = player.angle - PI/6
	var f_direction = Vector2(cos(f_theta), sin(f_theta))
	to = from+f_direction*indicator_length*2
	draw_line(from, to, RED)
	
	f_theta = player.angle + PI/6
	f_direction = Vector2(cos(f_theta), sin(f_theta))
	to = from+f_direction*indicator_length*2
	draw_line(from, to, RED)
	
	
