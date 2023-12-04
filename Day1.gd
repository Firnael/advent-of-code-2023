extends Node2D

func _ready():
	print('Day 1')
	#run_1(Global.get_file_lines("day-1/test-1.txt"))
	#run_2(Global.get_file_lines("day-1/test-2.txt"))
	#run_1(Global.get_file_lines("day-1/part-1.txt"))
	#run_2(Global.get_file_lines("day-1/part-2.txt"))
	
func run_1(lines):
	var result = 0
	for line in lines:
		if line == "":
			continue
		#print(line)
		var value = work(line)
		#print(value)
		result += value
	print("Result : " + str(result))

func run_2(lines):
	var result = 0
	for line in lines:
		if line == "":
			continue
		#print(line)
		var replaced = line
		replaced = replaced.replace("one", "o1e")
		replaced = replaced.replace("two", "t2o")
		replaced = replaced.replace("three", "t3e")
		replaced = replaced.replace("four", "f4r")
		replaced = replaced.replace("five", "f5e")
		replaced = replaced.replace("six", "s6x")
		replaced = replaced.replace("seven", "s7n")
		replaced = replaced.replace("eight", "e8t")
		replaced = replaced.replace("nine", "n9e")
		#print(replaced)
		var value = work(replaced)
		result += value
	print("Result : " + str(result))
		
func work(line):
	var chars = line.split()
	var results = []
	for char in chars:
		var stuff = int(char)
		if stuff > 0:
			results.append(char)
	var first = results[0]
	var last = results[0] if results.size() == 1 else results[results.size() -1]
	return int(first + last)
