extends Node2D

var regex

func _ready():
	pass
	#print('Day 3')
	#run_1(Global.get_file_lines("day-3/test-1.txt"))
	#run_1(Global.get_file_lines("day-3/part-1.txt"))
	#run_2(Global.get_file_lines("day-3/test-2.txt"))
	#run_2(Global.get_file_lines("day-3/part-2.txt"))

func run_1(lines):
	var grid = build_grid(lines)
	Global.pretty_print_array(grid)
	var numbers = {}
	for x in range(0, grid.size()):
		for y in range(0, grid[x].size()):
			print('x: ' + str(x) + ', y:' + str(y))

func run_2(lines):
	Global.pretty_print_array(lines)
	print('Result part 2 : ?')
	
# ---

func build_grid(lines):
	var grid = []
	for i in range(0, lines.size()):
		var row = lines[i].split('')
		grid.append(row)
	return grid
	
func check_neighbors(position, length, grid):
	var x = position.x
	var y = position.y
	var neighbors = []
	if x > 0: # check left
		neighbors.append(grid[x-1][y])
		if y > 0:
			neighbors.append(grid[x-1][y-1]) # top left
		if y < grid.size(): 
			neighbors.append(grid[x-1][y+1]) # bottom-left
		# TODO
		
	return false
