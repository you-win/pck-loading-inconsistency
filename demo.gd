extends Node

func _ready() -> void:
	var packer := PCKPacker.new()
	packer.pck_start("res://test.pck")
	packer.add_file("res://my//path/icon.svg", "res://assets/icon.svg")
	packer.flush()
	
	print(ProjectSettings.load_resource_pack("res://test.pck"))
	
	var ok_access := FileAccess.open("res://my//path/icon.svg", FileAccess.READ)
	print("From PCK ok: %s" % str(ok_access))
	var bad_access := FileAccess.open("res://my/path/icon.svg", FileAccess.READ)
	print("From PCK missing redundant slashes: %s" % str(bad_access))
	var other_bad_access := FileAccess.open("res://my//path/////icon.svg", FileAccess.READ)
	print("From PCK extra redundant slashes: %s" % str(other_bad_access))
	
	var not_from_pck_control_access := FileAccess.open("res://assets/icon.svg", FileAccess.READ)
	print("Not from PCK ok: %s" % str(not_from_pck_control_access))
	var not_from_pck_access := FileAccess.open("res://assets////icon.svg", FileAccess.READ)
	print("Not from PCK ok with redundant slashes: %s" % not_from_pck_access)
