extends Control


func _ready() -> void:
	_on_hs_scale_value_changed(1.0)
	_on_hs_bias_value_changed(0.0)
	_on_hs_sharpness_value_changed(0.2)


func _process(delta: float) -> void:
	# in order to get more performance this is called once in a sec
	if Engine.get_frames_drawn() % 60 != 0: return
	
	var string := ""
	
	string += "MEM STATIC: " + str( _to_mbytes( Performance.get_monitor(Performance.MEMORY_STATIC) ) ) + "MB\n"
	string += "MEM STATIC MAX: " + str( _to_mbytes( Performance.get_monitor(Performance.MEMORY_STATIC_MAX) ) ) + "MB\n"
	string += "BUFFER MAX: " + str( _to_mbytes( Performance.get_monitor(Performance.MEMORY_MESSAGE_BUFFER_MAX) ) ) + "MB\n"
	string += "BUFFER: " + str( _to_mbytes( Performance.get_monitor(Performance.RENDER_BUFFER_MEM_USED) ) ) + "MB\n"
	string += "MEM TEXTURE: " + str( _to_mbytes( Performance.get_monitor(Performance.RENDER_TEXTURE_MEM_USED) ) ) + "MB\n"
	string += "MEM VIDEO: " + str( _to_mbytes( Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED) ) ) + "MB\n"
	string += "DRAW CALLS: " + str( Performance.get_monitor(Performance.RENDER_TOTAL_DRAW_CALLS_IN_FRAME) ) + "\n"
	string += "OBJECTS: " + str( Performance.get_monitor(Performance.RENDER_TOTAL_OBJECTS_IN_FRAME) ) + "\n"
	string += "PRIMITIVES: " + str( Performance.get_monitor(Performance.RENDER_TOTAL_PRIMITIVES_IN_FRAME) ) + "\n"
	string += "FPS: " + str( Performance.get_monitor(Performance.TIME_FPS) ) + "\n"
#	string += "" + str() + "\n"
#	string += "" + str() + "\n"
#	string += "" + str() + "\n"
#	string += "" + str() + "\n"
#	string += "" + str() + "\n"
	$Panel/VBoxContainer/debug.text = string
	
	
	pass

func _to_mbytes(bytes:float) -> float:
	return bytes / 1048576

func _on_hs_scale_value_changed(value: float) -> void:
	$Panel/VBoxContainer/HBoxContainer/lb_scale.text = str(value)
	get_viewport().scaling_3d_scale = value

	pass # Replace with function body.


func _on_hs_sharpness_value_changed(value: float) -> void:
	$Panel/VBoxContainer/HBoxContainer2/lb_sharp.text = str(value)
	get_viewport().fsr_sharpness = value
	pass # Replace with function body.


func _on_hs_bias_value_changed(value: float) -> void:
	$Panel/VBoxContainer/HBoxContainer3/lb_bias.text = str(value)
	get_viewport().fsr_mipmap_bias = value
	pass # Replace with function body.

@onready var environment:Environment = get_parent().get_node("WorldEnvironment").environment
func _on_cb_sdf_toggled(button_pressed: bool) -> void:
	environment.sdfgi_enabled = button_pressed
	pass # Replace with function body.
