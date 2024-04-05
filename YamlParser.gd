extends Control


var table = {}

func read(string):
	var result = {}
	var token = ""
	
	string.replace("\t", " ")
	string.replace("  ", " ")
	
	
	for i in range(len(string)):
		if string[i] == "\n" or string[i] == " ":
			print(token)
			token = ""
		else:
			token = token + string[i]




func _ready():
	read("""
name: Projected time to make
type: expression

inputs:
- name: time_production
  display: Time to complete production
  type: number

- name: eff_precent
  display: Expected Efficiency
  type: number

- name: parts_number
  display: Parts Needed
  type: int8

variables:
- name: dec_efficiency
  type: number
  command:
	div:
	  input: eff_percent
	  constant: 100

outputs:
- name: time_make_one
  display: Expected time to make one
  type: number
  command:
	mult:
	  var: dec_efficiency
	  input: time_production

- name: time_make_all
  display: Expected time to make needed
  type: number
  command:
	mult:
	  input: parts_number
	  output: time_make_one
""")
