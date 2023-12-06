extends Node


func _ready():
	pass
	#print('Day 6')
	#run_1(Global.get_file_lines("day-6/test-1.txt"))
	#run_1(Global.get_file_lines("day-6/part-1.txt"))
	#run_2(Global.get_file_lines("day-6/test-1.txt")) # same as part 1
	#run_2(Global.get_file_lines("day-6/part-1.txt")) # same as part 1

func run_1(lines):
	var times = line_to_numbers_array(lines[0]).map(func(x): return int(x))
	var distances = line_to_numbers_array(lines[1]).map(func(x): return int(x))
	var results = []
	
	for i in range(0, times.size()):
		var time = times[i]
		var distance = distances[i]
		var records = get_records_for_race(time, distance)
		print('Records for race # :' + str(i) + ','.join(records))
		results.append(records)
	
	var total = results.reduce(func(acc, array): return acc * array.size(), 1)
	print('Result: ' + str(total))
	
func run_2(lines):
	var time = int(line_to_numbers_array(lines[0]).reduce(func(acc, n): return acc + n, ''))
	var distance = int(line_to_numbers_array(lines[1]).reduce(func(acc, n): return acc + n, ''))
	var records = get_records_for_race(time, distance)
	print('Result: ' + str(records.size()))

# ---

func line_to_numbers_array(line):
	return Array(line.substr(11,-1).split(' ')).filter(func(x): return x != '')

func compute_distance(pressed_time, limit_time):
	if pressed_time >= limit_time:
		print('Pressed time is equal or greater to limit time, this is bad !')
		return 0
	var duration = limit_time - pressed_time
	return pressed_time * duration
	
func get_records_for_race(time, distance):
	var records = []
	for i in range(0, time):
		var run_distance = compute_distance(i, time)
		if run_distance > distance:
			records.append(i)
	return records
