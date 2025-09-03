extends Control


var _results: Array[BenchmarkResult]


func _draw():
    var pad = Vector2(20, 20)
    var graph_size = size - pad * 2
    var graph_start = pad + Vector2(0, graph_size.y)

    # Drawing the graph axes
    draw_line(graph_start, graph_start + Vector2(graph_size.x, 0), Color.BLACK)
    draw_line(graph_start, pad, Color.BLACK)

    # There should be a range per unit.
    var data_range := Rect2()
    for result: BenchmarkResult in _results:
        for datapoint: Vector2 in result.data:
            data_range = data_range.expand(datapoint)

    for result: BenchmarkResult in _results:
        for i: int in range(result.data.size() - 1):
            # 0 - graph_size range
            var a: Vector2 = (result.data[i] / data_range.size) * graph_size
            var b: Vector2 = (result.data[i + 1] / data_range.size) * graph_size
            var a_fitted = graph_start + Vector2(a.x, -a.y)
            var b_fitted = graph_start + Vector2(b.x, -b.y)
            draw_line(a_fitted, b_fitted, Color.BLACK)


func draw_results(results: Array[BenchmarkResult]) -> void:
    _results = results
    queue_redraw()