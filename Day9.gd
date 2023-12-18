extends Node


func _ready():
	pass
	#print('Day 9')
	#run_1(Global.get_file_lines("day-9/test-1.txt"))
	#run_1(Global.get_file_lines("day-9/part-1.txt"))
	#run_2(Global.get_file_lines("day-9/test-1.txt"))
	#run_2(Global.get_file_lines("day-9/part-1.txt"))
	
func run_1(lines):
	var total = 0
	for line in lines:
		var results = build_sequences(line)
		for n in range(results.size()-1,0,-1): # [["0", "3", "6", "9", "12", "15"], [3, 3, 3, 3, 3], [0, 0, 0, 0]]
			var current = Array(results[n]) # [0, 0, 0, 0]
			var above = Array(results[n-1]) # [3, 3, 3, 3, 3]
			var next = int(above.back()) + int(current.back()) # 3 + 0
			results[n-1].append(next)
		#print(results)
		total += results[0].back()
	print('Total : ' + str(total))
	
func run_2(lines):
	var total = 0
	for line in lines:
		var results = build_sequences(line)
		for n in range(results.size()-1,0,-1): # [["0", "3", "6", "9", "12", "15"], [3, 3, 3, 3, 3], [0, 0, 0, 0]]
			var current = Array(results[n]) # [0, 0, 0, 0]
			var above = Array(results[n-1]) # [3, 3, 3, 3, 3]
			var next = int(above.front()) - int(current.front()) # 0 - 3
			results[n-1].insert(0, next)
		#print(results)
		total += results[0].front()
	print('Total : ' + str(total))
	
# ---

func build_sequences(line):
	var sequences = [Array(line.split(' '))]
	var index = 0
	var done = false
	while !done:
		var sum = 0
		sequences.append([])
		for i in range(0, sequences[index].size() - 1):
			var diff = int(sequences[index][i+1]) - int(sequences[index][i])
			sequences[index+1].append(diff)
			sum += abs(diff)
		if sum > 0:
			index += 1
		else:
			done = true
	#print(results)
	return sequences
