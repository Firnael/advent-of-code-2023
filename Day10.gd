extends Node


func _ready():
	print('Day 10')
	#run_1(Global.get_file_lines("day-10/test-1-1.txt"))
	#run_1(Global.get_file_lines("day-10/test-1-2.txt"))
	#run_1(Global.get_file_lines("day-10/part-1.txt"))
	#run_2(Global.get_file_lines("day-10/test-2-1.txt"))
	#run_2(Global.get_file_lines("day-10/test-2-2.txt"))
	#run_2(Global.get_file_lines("day-10/test-2-3.txt"))
	run_2(Global.get_file_lines("day-10/part-1.txt"))
	
	
func run_1(lines):
	var starting_point
	var grid = Global.build_grid(lines)
	#Global.pretty_print_array(grid)
	
	for y in range(0, grid.size()):
		for x in range(0, grid[y].size()):
			var v = grid[y][x]
			if v == 'S':
				starting_point = [y,x]
			#print('y: ' + str(y) + ', x: ' + str(x) + ', v: ' + v)
			var connected = is_pipe_connected(grid, y, x)
			if !connected:
				grid[y][x] = '.'
	#print('---')
	#Global.pretty_print_array(grid)
	
	var current_cell = starting_point
	var previous_cell = starting_point
	var current_value = 0
	var done = false
	while !done:
		var next_cell = get_next_cell_coords(grid, current_cell[0], current_cell[1], previous_cell[0], previous_cell[1])
		if next_cell == null:
			done = true
		else:
			#print('Next cell: ' + grid[next_cell[0]][next_cell[1]] + '(' + str(next_cell[0]) + ',' + str(next_cell[1]) + ')')
			current_value += 1
			previous_cell = current_cell
			current_cell = next_cell
	print('Result:' + str((current_value+1) / 2))

func run_2(lines):
	var starting_point
	var grid = Global.build_grid(lines)
	
	for y in range(0, grid.size()):
		for x in range(0, grid[y].size()):
			var v = grid[y][x]
			if v == 'S':
				starting_point = [y,x]
			var connected = is_pipe_connected(grid, y, x)
			if !connected:
				grid[y][x] = '.'
	
	var current_cell = starting_point
	var path_coords = [current_cell]
	var done = false
	while !done:
		var next_cell = get_next_cell_coords(grid, current_cell[0], current_cell[1])
		if next_cell == null:
			done = true
		else:
			current_cell = next_cell
			path_coords.append(current_cell)
			
	for y in range(0, grid.size()):
		for x in range(0, grid[y].size()):
			var is_in_path = false
			for i in range(0, path_coords.size()):
				var coord = path_coords[i]
				if coord[0] == y && coord[1] == x:
					is_in_path == true
			if !is_in_path:
				grid[y][x] = '.'
				
	Global.pretty_print_grid(grid)
				
	var total = 0
	for y in range(0, grid.size()):
		for x in range(0, grid[y].size()):
			var v = grid[y][x]
			if v == '.':
				var odd = odd_check(grid, y, x)
				grid[y][x] = 'I' if odd == true else 'O'
				if odd:
					total += 1
	print('Result : ' + str(total))

# ---

func is_pipe_connected(grid, y, x):
	var pipe = grid[y][x]
	var up = '.' if y == 0 else grid[y-1][x]
	var down = '.' if y == grid.size() -1 else grid[y+1][x]
	var left = '.' if x == 0 else grid[y][x-1]
	var right = '.' if x == grid[y].size() -1 else grid[y][x+1]
	#print('pipe : ' + pipe + ' (y:' + str(y) + ', x:' + str(x) + ')')
	#print('up: ' + up + ', down: ' + down + ', left: ' + left + ', right: ' + right)
	# pour chaque case de la grille, on vérifie que le pipe est rattaché
	# à au moins 2 autres pipes, sinon c'est du ground
	match pipe:
		'|': return ( up == '|' || up == '7' || up == 'F' || up == 'S' ) && ( down == '|' || down == 'J' || down == 'L' || down == 'S')
		'-': return ( left == '-' || left == 'L' || left == 'F' || left == 'S' ) && ( right == '-' || right == 'J' || right == '7' || right == 'S' )
		'L': return ( up == '|' || up == '7' || up == 'F' || up == 'S' ) && ( right == '-' || right == 'J' || right == '7' || right == 'S' )
		'J': return ( up == '|' || up == '7' || up == 'F' || up == 'S' ) && ( left == '-' || left == 'L' || left == 'F' || left == 'S' )
		'7': return ( left == '-' || left == 'L' || left == 'F' || left == 'S' ) && ( down == '|' || down == 'J' || down == 'L' || down == 'S')
		'F': return ( right == '-' || right == 'J' || right == '7' || right == 'S' ) && ( down == '|' || down == 'J' || down == 'L' || down == 'S')
		'.': return false
		'S': return true

func get_next_cell_coords(grid, y, x, py, px):
	var value = grid[y][x]
	var up_coords = [y-1,x]
	var down_coords = [y+1,x]
	var left_coords = [y,x-1]
	var right_coords = [y,x+1]
	var up = '.' if y == 0 else grid[y-1][x]
	var down = '.' if y == grid.size() -1 else grid[y+1][x]
	var left = '.' if x == 0 else grid[y][x-1]
	var right = '.' if x == grid[y].size() -1 else grid[y][x+1]
	if value == '|':
		if up == '|' || up == '7' || up == 'F':
			return up_coords
		elif down == '|' || down == 'J' || down == 'L':
			return down_coords
	elif value == '-':
		if left == '-' || left == 'L' || left == 'F':
			return left_coords
		elif right == '-' || right == 'J' || right == '7':
			return right_coords
	elif value == 'L':
		if up == '|' || up == '7' || up == 'F':
			return up_coords
		elif right == '-' || right == 'J' || right == '7':
			return right_coords
	elif value == 'J':
		if up == '|' || up == '7' || up == 'F':
			return up_coords
		elif left == '-' || left == 'L' || left == 'F':
			return left_coords
	elif value == '7':
		if left == '-' || left == 'L' || left == 'F':
			return left_coords
		elif down == '|' || down == 'J' || down == 'L':
			return down_coords
	else: # value == 'F'
		if right == '-' || right == 'J' || right == '7':
			return right_coords
		elif down == '|' || down == 'J' || down == 'L':
			return down_coords
	return null

func odd_check(grid, y, x):	
	# check if 'on edge'
	var up = 0
	var down = 0
	var left = 0
	var right = 0
	for i in range(0, x): # à gauche
		var v = grid[y][i]
		if v != '.' && v != 'O':
			left += 1
	for i in range(x+1, grid[y].size()): # à droite
		var v = grid[y][i]
		if v != '.' && v != 'O':
			right += 1
	for i in range(0, y): # en haut
		var v = grid[i][x]
		if v != '.' && v != 'O':
			up += 1
	for i in range(y+1, grid.size()): # en bas
		var v = grid[i][x]
		if v != '.' && v != 'O':
			down += 1
	if up == 0 || down == 0 || right == 0 || left == 0:
		return false
		
	# count segments
	var surfing = false
	var surfing_start = ''
	var segments = 0
	for i in range(x+1, grid[y].size()): # uniquement à droite
		var v = grid[y][i]
		if v == '|':
			segments += 1
			continue
		if surfing == true:
			if v == '-':
				# keep surfing
				continue
			surfing = false
			if v == 'J' && surfing_start == 'F':
				segments += 1
			elif v == '7' && surfing_start == 'L':
				segments += 1
		else: # surfing == false
			if v == 'F' || v == 'L':
				surfing = true
				surfing_start = v
	return segments % 2 == 1
