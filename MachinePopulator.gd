extends Node

var selected = null

func currentlySelected(machine):
	selected = machine
	displayMachineData(selected)

func displayMachineData(data):
	print(data.name)
