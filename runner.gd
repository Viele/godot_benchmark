extends Node


func _ready():
	var results: Array[BenchmarkResult] = []
	for benchmark in BenchmarkRegistry.registry:
		var bench_results = benchmark.run()
		results.append_array(bench_results)

	$%result_list.load(results)
