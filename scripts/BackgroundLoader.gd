extends Node

var thread = null
var new_scene
var res
var can_change = false
var scene_to_preload
var target_parent:Node = null
var can_use:bool = true

func _thread_load(path):
	var ril = ResourceLoader.load_interactive(path)
	assert(ril)
	var total = ril.get_stage_count()
	# Call deferred to configure max load steps
#	progress.call_deferred("set_max", total)
#
	res = null
	
	while true: #iterate until we have a resource
		# Update progress bar, use call deferred, which routes to main thread
#		progress.call_deferred("set_value", ril.get_stage())
		# Simulate a delay
		# Poll (does a load step)
		var err = ril.poll()
		# if OK, then load another one. If EOF, it' s done. Otherwise there was an error.
		if err == ERR_FILE_EOF:
			# Loading done, fetch resource
			res = ril.get_resource()
			can_change = true
			break
		elif err != OK:
			# Not OK, there was an error
			print("There was an error loading")
			break

func _thread_done(resource):
	assert(resource)
	
	# Always wait for threads to finish, this is required on Windows
	thread.wait_to_finish()
	
	#Hide the progress bar
#	progress.hide()
	
	# Instantiate new scene
	var node = resource.instantiate()
	# Free current scene
#	get_tree().current_scene.free()
#	get_tree().current_scene = null
	# Add new one to root
	target_parent.add_child(node)
	node.global_transform.origin = Vector3(12.4004154205322266,3.9239518642425537,11.0017118453979492)
	print('SCENE PRELOADED!') 
	# Set as current scene
#	progress.visible = false
	clear_stuff()

func clear_stuff():
#	thread = null
	can_use = true
	new_scene = null
	res = null
	can_change = false
	scene_to_preload = ""
	
func preload_scene(path, the_parent):
	if can_use == false:
		print("in use... try later")
		return
	can_use = false
	target_parent = the_parent
	scene_to_preload = path
	can_change = false
	print(str('PRELOADING SCENE: ' + path + '...'))
	thread = Thread.new()
	thread.start(_thread_load,path)
	raise() # show on top
#	progress.visible = true

func change_scene_to_preloaded():
	call_deferred("_thread_done", res)
