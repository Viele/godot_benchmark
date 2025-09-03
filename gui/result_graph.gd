extends Control


enum ScaleMode {
	LINEAR,
	LOG,
}

const LABEL_SIZE := 12
var _font = ThemeDB.fallback_font

var _results: Array[BenchmarkResult]
var _x_mode: ScaleMode = ScaleMode.LINEAR
var _y_mode: ScaleMode = ScaleMode.LINEAR


func _scale_point(p: Vector2) -> Vector2:
	if _x_mode == ScaleMode.LOG:
		p.x = log(p.x)
	if _y_mode == ScaleMode.LOG:
		p.y = log(p.y)
	return p


func _draw_tick(pos: Vector2, direction: int) -> void:
	var offset = Vector2()
	var tick_length = 5
	if direction == 0:
		offset.x = tick_length
	elif direction == 1:
		offset.y = tick_length
	draw_line(pos + offset, pos - offset, Color.BLACK, 2)


# Simply wrapping draw_string with less args
func _draw_text(pos: Vector2, text: String) -> void:
	draw_string(_font, pos, text, HORIZONTAL_ALIGNMENT_LEFT, -1, LABEL_SIZE)


func _draw_unit_label_x(pos: Vector2, text: String) -> void:
	var text_size = _font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, LABEL_SIZE)
	_draw_text(pos - Vector2(text_size.x / 2, -text_size.y), text)


func _draw_unit_label_y(pos: Vector2, text: String) -> void:
	var text_size = _font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, LABEL_SIZE)
	_draw_text(pos - Vector2(text_size.x + 8, -(text_size.y / 4)), text)


func _draw():
	var pad = Vector2(60, 20)
	var graph_size = size - pad * 2
	var graph_start = pad + Vector2(0, graph_size.y)

	var x_units = {}
	var y_units = {}
	# There should be a range per unit.
	var scaled_range := Rect2()
	var data_range := Rect2()
	for result: BenchmarkResult in _results:
		x_units[result.x_unit] = true
		y_units[result.y_unit] = true
		for datapoint: Vector2 in result.data:
			scaled_range = scaled_range.expand(_scale_point(datapoint))
			data_range = data_range.expand(datapoint)

	var text_size: Vector2
	for result: BenchmarkResult in _results:
		for i: int in range(result.data.size() - 1):
			# 0 - graph_size range
			var a: Vector2 = (_scale_point(result.data[i]) / scaled_range.size) * graph_size
			var b: Vector2 = (_scale_point(result.data[i + 1]) / scaled_range.size) * graph_size
			# Inverting y because the positive y axis for drawing is pointing down.
			var a_fitted = graph_start + Vector2(a.x, -a.y)
			var b_fitted = graph_start + Vector2(b.x, -b.y)
			draw_line(a_fitted, b_fitted, result.color, 1, true)

		var label_pos: Vector2 = (_scale_point(result.data[-1]) / scaled_range.size) * graph_size
		var label_pos_fitted = graph_start + Vector2(label_pos.x, -label_pos.y)
		text_size = _font.get_string_size(result.name, HORIZONTAL_ALIGNMENT_LEFT, -1, LABEL_SIZE)
		_draw_text(label_pos_fitted - Vector2(text_size.x, 0), result.name)

	# Drawing the graph axes
	draw_line(graph_start, graph_start + Vector2(graph_size.x, 0), Color.BLACK, 2)
	draw_line(graph_start, pad, Color.BLACK, 2)

	_draw_tick(graph_start + Vector2(graph_size.x, 0), 1)
	_draw_tick(pad, 0)

	_draw_unit_label_x(graph_start + Vector2(graph_size.x, 0), str(data_range.size.x))
	_draw_unit_label_y(pad, str(data_range.size.y))

	# Draw units
	x_units = x_units.keys()
	x_units.sort()
	y_units = y_units.keys()
	y_units.sort()
	var x_unit_string = ""
	for u in x_units:
		x_unit_string += BenchmarkResult.unit_type_to_string(u) + " "
	text_size = _font.get_string_size(x_unit_string, HORIZONTAL_ALIGNMENT_LEFT, -1, LABEL_SIZE)
	_draw_text(graph_start + Vector2(0, text_size.y + 2), x_unit_string)


func draw_results(results: Array[BenchmarkResult]) -> void:
	_results = results
	queue_redraw()


func set_x_scale(value: ScaleMode) -> void:
	_x_mode = value
	queue_redraw()


func set_y_scale(value: ScaleMode) -> void:
	_y_mode = value
	queue_redraw()
