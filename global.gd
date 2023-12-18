extends Node2D

func _ready():
	print('Global script loaded')
	
func get_file_lines(path):
	var complete_path = "res://inputs/" + path
	var content: String
	if FileAccess.file_exists(complete_path):
		var file = FileAccess.open(complete_path, FileAccess.READ)
		content = file.get_as_text()
	else:
		content = "File does not exists : " + complete_path
	var lines = Array(content.split('\n')) # casting the PackedStringArray to normal array
	lines.pop_back()  # godot adds an empty last line, remove it
	return lines
	
func build_grid(lines):
	var grid = []
	for i in range(0, lines.size()):
		var row = Array(lines[i].split(''))
		grid.append(row)
	return grid

func pretty_print_array(array):
	print(','.join(array))

func pretty_print_grid(grid):
	for i in range(0, grid.size()):
		var row = grid[i]
		print(''.join(row))
	
func pretty_print_dict(dict):
	print('{')
	for k in dict:
		var v = dict[k]
		print('  ' + str(k) + ': ' + str(v))
	print('}')
