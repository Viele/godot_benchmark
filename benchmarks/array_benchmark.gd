class_name ArrayBenchmark
extends AbstractBenchmark


static func run() -> Array[BenchmarkResult]:
    var results: Array[BenchmarkResult] = []

    var memory_result := BenchmarkResult.new()
    memory_result.name = "Array Memory Usage"
    memory_result.y_unit = BenchmarkResult.UnitType.MEMORY
    results.append(memory_result)

    var time_result := BenchmarkResult.new()
    time_result.name = "Array Allocation Time"
    time_result.y_unit = BenchmarkResult.UnitType.TIME
    results.append(time_result)

    var size = 1
    while size < BenchmarkConstants.MAX_ITERABLE_LENGTH:
        var memory_start := int(Performance.get_monitor(Performance.MEMORY_STATIC))
        var time_start := Time.get_ticks_usec()

        var test_array := Array()
        for i in range(size):
            test_array.append(i)

        var time_after := Time.get_ticks_usec()
        time_result.data.append(Vector2(size, time_after - time_start))

        var memory_bytes := int(Performance.get_monitor(Performance.MEMORY_STATIC)) - memory_start
        memory_result.data.append(Vector2(size, memory_bytes))

        size *= 2

    return results