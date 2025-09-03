class_name PackedInt32Benchmark
extends AbstractBenchmark

const _BASE_COLOR = Color(0.8, 0.2, 0.2)

static func run() -> Array[BenchmarkResult]:
    var results: Array[BenchmarkResult] = []

    var memory_result := BenchmarkResult.new()
    memory_result.name = "PackedIn32 Memory Usage"
    memory_result.y_unit = BenchmarkResult.UnitType.MEMORY
    memory_result.color = _BASE_COLOR * 0.9
    results.append(memory_result)

    var create_time_result := BenchmarkResult.new()
    create_time_result.name = "PackedIn32 Allocation Time"
    create_time_result.y_unit = BenchmarkResult.UnitType.TIME
    create_time_result.color = _BASE_COLOR * Color(0.8, 0.8, 1)
    results.append(create_time_result)

    var access_time_result := BenchmarkResult.new()
    access_time_result.name = "PackedIn32 Access Time"
    access_time_result.y_unit = BenchmarkResult.UnitType.TIME
    access_time_result.color = _BASE_COLOR * Color(0.8, 0.7, 0.7)
    results.append(access_time_result)

    var search_time_result := BenchmarkResult.new()
    search_time_result.name = "PackedIn32 Search Time"
    search_time_result.y_unit = BenchmarkResult.UnitType.TIME
    search_time_result.color = _BASE_COLOR * Color(1, 0.8, 0.8)
    results.append(search_time_result)

    var size = 1
    while size < BenchmarkConstants.MAX_ITERABLE_LENGTH:
        var memory_start := int(Performance.get_monitor(Performance.MEMORY_STATIC))
        var create_time_start := Time.get_ticks_usec()

        var test_array := PackedInt32Array()
        for i in range(size):
            test_array.append(i)

        var time_after := Time.get_ticks_usec()
        create_time_result.data.append(Vector2(size, time_after - create_time_start))

        var memory_bytes := int(Performance.get_monitor(Performance.MEMORY_STATIC)) - memory_start
        memory_result.data.append(Vector2(size, memory_bytes))

        var access_time_start := Time.get_ticks_usec()
        for i in range(BenchmarkConstants.ACCESS_TIME_TEST_COUNT):
            var _value = test_array[size-1]
        time_after = Time.get_ticks_usec()
        access_time_result.data.append(Vector2(size, time_after - access_time_start))

        var search_time_start := Time.get_ticks_usec()
        test_array.find(size-1)
        time_after = Time.get_ticks_usec()
        search_time_result.data.append(Vector2(size, time_after - search_time_start))

        size *= 2

    return results