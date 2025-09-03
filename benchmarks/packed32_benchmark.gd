class_name PackedInt32Benchmark
extends AbstractBenchmark

const _BASE_COLOR = Color(0.8, 0.2, 0.2)

static func run() -> Array[BenchmarkResult]:
    var results: Array[BenchmarkResult] = []

    var memory_result := BenchmarkResult.new()
    memory_result.name = "PackedIn32 Memory Usage"
    results.append(memory_result)
    memory_result.x_unit = BenchmarkResult.UnitType.DATA_SIZE
    memory_result.y_unit = BenchmarkResult.UnitType.MEMORY
    memory_result.color = _BASE_COLOR * 0.9

    var time_result := BenchmarkResult.new()
    time_result.name = "PackedIn32 Allocation Time"
    results.append(time_result)
    time_result.color = _BASE_COLOR * Color(0.8, 0.8, 1)

    var size = 1
    while size < BenchmarkConstants.MAX_ITERABLE_LENGTH:
        var memory_start := int(Performance.get_monitor(Performance.MEMORY_STATIC))
        var time_start := Time.get_ticks_usec()

        var test_array := PackedInt32Array()
        for i in range(size):
            test_array.append(i)

        var time_after := Time.get_ticks_usec()
        time_result.data.append(Vector2(size, time_after - time_start))

        var memory_bytes := int(Performance.get_monitor(Performance.MEMORY_STATIC)) - memory_start
        memory_result.data.append(Vector2(size, memory_bytes))

        size *= 2

    return results