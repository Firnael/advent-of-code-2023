extends Node2D

# part 1
var RED_CUBES = 12
var GREEN_CUBES = 13
var BLUE_CUBES = 14

func _ready():
	pass
	#print('Day 2')
	#run_1(Global.get_file_lines("day-2/test-1.txt"))
	#run_1(Global.get_file_lines("day-2/part-1.txt"))
	#run_2(Global.get_file_lines("day-2/test-2.txt"))
	#run_2(Global.get_file_lines("day-2/part-2.txt"))
	
func run_1(lines):
	#Global.pretty_print_array(lines)
	var result = 0
	for i in range(0, lines.size()):
		result += check_possibility(i+1, lines[i])
	print('Result part 1 : ' + str(result))

func run_2(lines):
	Global.pretty_print_array(lines)
	var result = 0
	for line in lines:
		result += compute_power_of_cubes(line)
	print('Result part 2 : ' + str(result))
	
# ---

func check_possibility(index, line):
	var max_cubes = count_max_cubes(line)
	#print('red:' + str(red_count) + ', green count: ' + str(green_count) + ', blue: ' + str(blue_count))
	if max_cubes[0] > RED_CUBES || max_cubes[1] > GREEN_CUBES || max_cubes[2] > BLUE_CUBES:
		return 0
	return index
	
func compute_power_of_cubes(line):
	var max_cubes = count_max_cubes(line)
	return max_cubes[0] * max_cubes[1] * max_cubes[2]
	
func count_max_cubes(line):
	var bag_content = line.substr(8, -1)
	var red_count = 0
	var green_count = 0
	var blue_count = 0
	
	var sets = bag_content.split(';') # "w color, x color", "y color, z color"
	for set in sets:
		var cubes = set.split(',') # "y color, z color" -> "y color"
		for cube in cubes:
			var data = cube.strip_edges().split(' ') # "y","color"
			match data[1]:
				'red': red_count = int(data[0]) if red_count < int(data[0]) else red_count
				'green': green_count = int(data[0]) if green_count < int(data[0]) else green_count
				'blue': blue_count = int(data[0]) if blue_count < int(data[0]) else blue_count
	return [red_count, green_count, blue_count]
