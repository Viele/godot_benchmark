class_name DictionaryBenchmark
extends AbstractBenchmark

const _BASE_COLOR = Color(0.2, 0.8, 0.2)

static func run() -> Array[BenchmarkResult]:
	var results: Array[BenchmarkResult] = []

	var memory_result := BenchmarkResult.new()
	memory_result.name = "Dictionary Memory Usage"
	results.append(memory_result)
	memory_result.y_unit = BenchmarkResult.UnitType.MEMORY
	memory_result.color = _BASE_COLOR * 0.9

	var time_result := BenchmarkResult.new()
	time_result.name = "Dictionary Insert Time"
	results.append(time_result)
	time_result.y_unit = BenchmarkResult.UnitType.TIME
	time_result.color = _BASE_COLOR * Color(0.8, 0.8, 1)

	var access_time_result := BenchmarkResult.new()
	access_time_result.name = "Dictionary Access Time"
	results.append(access_time_result)
	access_time_result.y_unit = BenchmarkResult.UnitType.TIME
	access_time_result.color = _BASE_COLOR * Color(0.8, 0.7, 0.7)

	var search_time_result := BenchmarkResult.new()
	search_time_result.name = "Dictionary Search Time"
	results.append(search_time_result)
	search_time_result.y_unit = BenchmarkResult.UnitType.TIME
	search_time_result.color = _BASE_COLOR * Color(1, 0.8, 0.8)

	var size = 1
	while size < BenchmarkConstants.MAX_ITERABLE_LENGTH:
		var memory_start := int(Performance.get_monitor(Performance.MEMORY_STATIC))
		var time_start := Time.get_ticks_usec()

		var test_dict := Dictionary()
		for i in range(size):
			test_dict[i] = i

		var time_after := Time.get_ticks_usec()
		time_result.data.append(Vector2(size, time_after - time_start))

		var memory_bytes := int(Performance.get_monitor(Performance.MEMORY_STATIC)) - memory_start
		memory_result.data.append(Vector2(size, memory_bytes))

		var access_time_start := Time.get_ticks_usec()
		for i in range(BenchmarkConstants.ACCESS_TIME_TEST_COUNT):
			var _value = test_dict[size-1]
		time_after = Time.get_ticks_usec()
		access_time_result.data.append(Vector2(size, time_after - access_time_start))

		var search_time_start := Time.get_ticks_usec()
		test_dict.get(size-1)
		time_after = Time.get_ticks_usec()
		search_time_result.data.append(Vector2(size, time_after - search_time_start))

		size *= 2

	return results
