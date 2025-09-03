extends Control


var _results: Array[BenchmarkResult]


func _draw():
    for result in _results:
        pass


func draw_results(results: Array[BenchmarkResult]) -> void:
    _results = results
    queue_redraw()