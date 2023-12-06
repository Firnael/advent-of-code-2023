extends Node2D


func _ready():
	print('Day 5')
	#run_1(Global.get_file_lines("day-5/test-1.txt"))
	#run_1(Global.get_file_lines("day-5/part-1.txt"))
	#run_2(Global.get_file_lines("day-5/test-1.txt")) # same as part 1
	run_2(Global.get_file_lines("day-5/part-1.txt")) # same as part 1

func run_1(lines):
	var seeds = Array(lines[0].substr(7,-1).split(' '))
	seeds = seeds.map(func(s): return int(s))
	work(seeds, lines)

func run_2(lines):
	var time_before = Time.get_ticks_msec()
	var seeds_ranges = build_seeds_ranges(lines)
	var mapping = build_mapping(lines)
	var keys = mapping.keys()
	keys.reverse() # move from bottom to top
	
	var solution = -1
	var index = 0
	var location = 0
	
	while solution < 0:
		var potential_solution = index
		location = potential_solution
		index += 1
		#print('-> Testing value : ' + str(potential_solution))
		for k in keys: # from 6 to 0
			var v = mapping[k]
			for data in v: # [ [50, 51], [98, 99] ]
				var src = data[1]
				var dest = data[0]
				if potential_solution >= dest[0] && potential_solution <= dest[1]: # index in in src or not ?
					#print('k: ' + str(k) + ', potential_solution: ' + str(potential_solution) + ' found in range : [' + str(dest[0]) + ',' + str(dest[1]) + ']')
					potential_solution = potential_solution - dest[0] + src[0]
					#print('new potential_solution: ' + str(potential_solution))
					break
				#else:
					#print('k: ' + str(k) + ', potential_solution: ' + str(potential_solution) + ' NOT found in range : [' + str(dest[0]) + ',' + str(dest[1]) + ']')
				
		# check if potential solution exists in seeds ranges
		for range in seeds_ranges:
			var start = range[0]
			var end = range[1]
			if potential_solution >= start && potential_solution <= end:
				solution = potential_solution # found it !
				print('Solution found in seeds range : [' + str(start) + ',' + str(end) + ']')
				break
	print('Result : Seed=' + str(solution) + ', Location=' + str(location))
	var total_time = Time.get_ticks_msec() - time_before
	print("Time taken: " + str(total_time) + " ms")
	
# ---

func build_seeds_ranges(lines):
	var seeds = lines[0].substr(7,-1).split(' ')
	var seeds_ranges = []
	for i in range(0, seeds.size(), 2):
		var start = int(seeds[i])
		var end = int(seeds[i+1])
		seeds_ranges.append([start, start+end -1])
	return seeds_ranges
	
func build_mapping(lines):
	var mapping = {}
	var index = 0
	var skip_next = true
	var buffer = []
	for i in range(2, lines.size()): # we already got the seeds, start at line 2
		if skip_next:
			skip_next = false # skip header lines (ex: "seed-to-soil")
			continue
		var line = lines[i]
		if line == '':
			mapping[index] = Array(buffer)
			buffer = []
			index += 1
			skip_next = true
		else:
			buffer.append(line.split(' '))
	mapping[index] = Array(buffer) # push last buffer
	#Global.pretty_print_dict(mapping)
	
	for k in mapping: # [ ["50", "98", "2"], ["52", "50", "48"] ]
		var v = mapping[k]
		var buff = []
		for x in v: # ["50", "98", "2"]
			var d = int(x[0])
			var s = int(x[1])
			var r = int(x[2])
			var dest = [d, d+r-1]
			var src = [s, s+r-1]
			buff.append([dest,src]) # [ [50,51], [98,99] ]
		mapping[k] = buff
		buff = []
	return mapping

func work(seeds, lines):
	var mapping = build_mapping(lines)
	#Global.pretty_print_dict(mapping) 
	
	var final_result = INF
	for seed in seeds:
		#print('Seed ' + str(seed))
		var result = -1
		for k in mapping: # [ [[50, 51], [98, 99]], [[52, 99], [50, 97]] ]
			var v = mapping[k] 
			for data in v: # [ [50, 51], [98, 99] ]
				var src = data[1]
				var dest = data[0]
				if seed >= src[0] && seed <= src[1]: # seed in in src or not ?
					result = seed - src[0] + dest[0] #ex: seed 98 -> soil 50, seed 99 -> soil 51
			if result < 0: # mapping is equal to the seed
				result = seed
			#print(str(result))
			seed = result
			if (k == 6): # last step, location
				#print('location : ' + str(result))
				final_result = result if result < final_result else final_result
	
	print('Result : ' + str(final_result))
