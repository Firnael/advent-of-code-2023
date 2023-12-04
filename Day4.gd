extends Node2D

func _ready():
	print('Day 4')
	#run_1(Global.get_file_lines("day-4/test-1.txt"))
	#run_1(Global.get_file_lines("day-4/part-1.txt"))
	#run_2(Global.get_file_lines("day-4/test-2.txt"))
	#run_2(Global.get_file_lines("day-4/part-2.txt"))
	
func run_1(lines):
	#Global.pretty_print_array(lines)
	var counts = get_matching_counts(lines)
	var result = 0
	for c in counts:
		result += compute_total(c)
	print('Result : ' + str(result))

func run_2(lines):
	var starting_cards_counts = get_matching_counts(lines) # 4, 2, 2, 1, 0, 0
	print('Starting : ' + ','.join(starting_cards_counts))
	print('Size : ' + str(starting_cards_counts.size()))
	
	var total = starting_cards_counts.size()
	var counters = []
	for c in starting_cards_counts: # init counters with starting cards
		counters.append(1)
		
	for index in range(0, counters.size()):
		print('Current index : ' + str(index))
		var count = starting_cards_counts[index]
		total += count * counters[index] # increase the total
		for x in range(index+1, index + count + 1):
			counters[x] += counters[index] # increase the x next cards
	print('Result : ' + str(total))
	
# ---

func get_matching_counts(lines):
	var counts = []
	for line in lines:
		line = line.substr(8, line.length()) # remove 'Card X: '
		var splitted = line.split('|')
		var numbers = Array(splitted[0].strip_edges().split(' ')).filter(func(x): return x != '')
		var winning = Array(splitted[1].strip_edges().split(' ')).filter(func(x): return x != '')
		#print('numbers : ' + ','.join(numbers))
		#print('winning : ' + ','.join(winning))
		var count = 0
		for x in winning:
			if numbers.has(x):
				count += 1
		counts.append(count)
	return counts
	
func compute_total(number):
	return 0 if number == 0 else 1 << (number - 1) # bitshift like a B0$$
