class_name Mirror
extends StaticBody2D

@export var required_players_count: int

@onready var JoinDetector: Area2D = $"Join Detector"


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Action"):
		get_tree().reload_current_scene()

	if JoinDetector.has_overlapping_bodies():
		var bodies := JoinDetector.get_overlapping_bodies() \
			.filter(func(body): return body is Player)

		var bodies_names := bodies.map(
			func(body: Player): return body.name)
		var bodies_name := "[%s]" % ",".join(bodies_names)

		var bodies_coords := bodies.map(
			func(body: Player): return Vector2i(body.global_position))
		var bodies_coord := "{%s}" % ",".join(bodies_coords)

		print("Bodies = %s" % bodies_name)

		if bodies.size() == required_players_count:
			var bodies_x := bodies_coords.map(
				func(coord: Vector2i): return coord.x)

			var bodies_same_x := bodies_x.all(
				func(x: int): return absi(x - bodies_x[0]) < 10)

			var bodies_y := bodies_coords.map(
				func(coord: Vector2i): return coord.y)

			var bodies_same_y := bodies_y.all(
				func(y: int): return absi(y - bodies_y[0]) < 10)

			print("Bodies_x? [%s]" % ",".join(bodies_x))
			print("Bodies_x[0] = %s" % bodies_x[0])
			print("Bodies_same_x = %s" % bodies_same_x)

			if bodies_same_x or bodies_same_y:
				for body in bodies:
					var player: Player = body
					player.merge_into_main()

				#print("Mirror activated!" +
					#"\nNames = %s" % bodies_name +
					#"\nCoords = %s" % bodies_coord)
