extends Node

var _results: Array[AbstractBenchmark]

func _ready():
	_results = []
	for benchmark in BenchmarkRegistry.registry:
		var results = benchmark.run()
		_results.append_array(results)
