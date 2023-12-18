extends Node


var str_to_int_mapping = {
	'2': 2,
	'3': 3,
	'4': 4,
	'5': 5,
	'6': 6,
	'7': 7,
	'8': 8,
	'9': 9,
	'T': 10,
	'J': 11,
	'Q': 12,
	'K': 13,
	'A': 14,
}

var int_to_str_mapping = {
	2: '2',
	3: '3',
	4: '4',
	5: '5',
	6: '6',
	7: '7',
	8: '8',
	9: '9',
	10: 'T',
	11: 'J',
	12: 'Q',
	13: 'K',
	14: 'A',
}

func _ready():
	pass
	#print('Day 7')
	#run(Global.get_file_lines("day-7/test-1.txt"))
	#run(Global.get_file_lines("day-7/part-1.txt"))
	
# this is part 2 solution, I erased part 1 because f*ck this puzzle
func run(lines):
	#Global.pretty_print_array(lines)
	var hands = []
	var hands_replaced = []
	var bids = []
	var bid_for_hand = {}
	for line in lines:
		var splitted = Array(line.split(' '))
		var hand = splitted[0]
		var bid = int(splitted[1])
		bid_for_hand[hand] = bid
		hands.append(hand)
		bids.append(bid)
		var j_should_be = what_should_the_j_be(hand)
		var hand_replaced = hand.replacen('J', int_to_str_mapping[int(j_should_be)])
		#print('Hand replaced : ' + hand_replaced)
		hands_replaced.append(hand_replaced)
	var both_hands = []
	for i in range(0, hands.size()):
		var concat = hands[i] + ':' + hands_replaced[i]
		both_hands.append(concat)
	both_hands.sort_custom(sort_by_power)
	#Global.pretty_print_array(both_hands)
	
	var total = 0
	for i in range(0, both_hands.size()):
		var hand = both_hands[i].split(':')[0]
		var rank = i+1
		print(hand + ', rank = ' + str(rank))
		total += bid_for_hand[hand] * rank
	print('Result : ' + str(total)) # expected : 6440

# ---

func sort_by_power(a, b):
	var a_concat = a.split(':')
	var b_concat = b.split(':')
	
	var a_type = get_type(a_concat[1])
	var b_type = get_type(b_concat[1])
	if a_type < b_type: # a is weaker than b
		return true
	elif a_type > b_type: # a is stronger than b
		return false
	else: # both are the same type
		#print('Both are the same : ' + a + ' and ' + b)
		var a_array = a_concat[0].split('')
		var b_array = b_concat[0].split('')
		for i in range(0, a_array.size()):
			var a_card = str_to_int_mapping[a_array[i]]
			var b_card = str_to_int_mapping[b_array[i]]
			# Joker has lowest value
			if a_card == 11:
				a_card = 1;
			if b_card == 11:
				b_card = 1;
			if a_card == b_card:
				#print(str(a_card) + ' is same as ' + str(b_card))
				continue
			else:
				#print('we return a - b : ' + str(a_card) + ' - ' + str(b_card))
				return a_card - b_card < 0
	
func get_type(hand):
	var mapping = {
		2: 0,
		3: 0,
		4: 0,
		5: 0,
		6: 0,
		7: 0,
		8: 0,
		9: 0,
		10: 0, # T
		11: 0, # J
		12: 0, # Q
		13: 0, # K
		14: 0, # A
	}
	for card in hand:
		var value = str_to_int_mapping[card]
		mapping[value] += 1
	for k in mapping.keys():
		var value = mapping[k]
		if value == 5: 
			return 7 # triche (5 pareil)
		if value == 4:
			return 6 # carré (4 pareil)
		if value == 3:
			for k2 in mapping.keys():
				var v2 = mapping[k2]
				if v2 == 2:
					return 5 # full
			return 4 # brelan
		if value == 2: # full, 2 pairs or 1 pair ?
			for k2 in mapping.keys():
				var v2 = mapping[k2]
				if v2 == 3:
					return 5 # full
				if v2 == 2 && k != k2:
					return 3 # double paire
			return 2 # simple paire
	return 1 # high card

func what_should_the_j_be(hand):
	var mapping = {
		2: 0,
		3: 0,
		4: 0,
		5: 0,
		6: 0,
		7: 0,
		8: 0,
		9: 0,
		10: 0, # T
		11: 0, # J <----
		12: 0, # Q
		13: 0, # K
		14: 0, # A
	}
	for card in hand:
		var value = str_to_int_mapping[card]
		mapping[value] += 1
	var jeez = mapping[11] # count the J's...
	if jeez == 5: # only J's
		return 11
	var array = []
	for k in mapping.keys():
		var v = mapping[k]
		if v > 0:
			array.append(str(k) + ':' + str(v))
	array.sort_custom(sort_de_filou)
	#print('Hand (' + hand + '), sorted: ' + ','.join(array))
	var first_index = 0
	if (array[0].split(':')[0] == '11'):
		first_index = 1
	var j_should_be = array[first_index].split(':')[0]
	#print('J should be : ' + j_should_be) 
	return j_should_be

func sort_de_filou(a, b):
	var a_splitted = a.split(':')
	var a_k = int(a_splitted[0])
	var a_v = int(a_splitted[1])
	var b_splitted = b.split(':')
	var b_k = int(b_splitted[0])
	var b_v = int(b_splitted[1])
	if a_v > b_v:
		return true
	if a_v < b_v:
		return false
	# si on arrive ici, la value est la même, on veut retourner la plus grosse clé en premier
	return a_k - b_k > 0
	
