extends Node

var _results: Array[AbstractBenchmark] = []

func _ready():
	for benchmark in BenchmarkRegistry.registry:
		var results = benchmark.run()
		_results.append_array(results)
