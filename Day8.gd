extends Node


func _ready():
	pass
	#print('Day 8')
	#run_1(Global.get_file_lines("day-8/test-1-1.txt"))
	#run_1(Global.get_file_lines("day-8/test-1-2.txt"))
	#run_1(Global.get_file_lines("day-8/part-1.txt"))
	
func run_1(lines):
	var directions = lines[0].split('')
	var nodes = {}
	for i in range(2, lines.size()):
		var line = lines[i]
		var node_name = line.split('=')[0].strip_edges()
		var childs = line.substr(7, 8).split(',')
		var left_child = childs[0].strip_edges()
		var right_child = childs[1].strip_edges()
		nodes[node_name] = { 'L': left_child, 'R': right_child }
		
	# ça me fait un dict "nodes" comme ça :
	# {
	# 	"AAA": { "L": "BBB", "R": "CCC" },
	#	"BBB": { "L": "DDD", "R": "EEE" },
	#	"CCC": { "L": "ZZZ", "R": "GGG" },
	#	"DDD": { "L": "DDD", "R": "DDD" },
	#	"EEE": { "L": "EEE", "R": "EEE" },
	#	"GGG": { "L": "GGG", "R": "GGG" },
	#	"ZZZ": { "L": "ZZZ", "R": "ZZZ" }
	# }
	print(nodes)
	
	var current_node = 'AAA'
	var pointer = 0
	var done = false
	var step_counter = 0
	var directions_size = directions.size()
	while !done:
		step_counter += 1
		var direction = directions[pointer]
		pointer += 1
		if pointer == directions_size:
			pointer = 0
		var next_node = nodes[current_node][direction]
		#print(direction + ' of ' + current_node + ' is ' + next_node)
		if next_node == 'ZZZ':
			done = true
		current_node = next_node
	print('Result : ' + str(step_counter))
		
