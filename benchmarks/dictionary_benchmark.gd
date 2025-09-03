class_name DictionaryBenchmark
extends AbstractBenchmark


static func run() -> Array[BenchmarkResult]:
    var results: Array[BenchmarkResult] = []

    var memory_result := BenchmarkResult.new()
    memory_result.name = "Dictionary Memory Usage"
    results.append(memory_result)

    var time_result := BenchmarkResult.new()
    time_result.name = "Dictionary Allocation Time"
    results.append(time_result)

    var size = 1
    while size < BenchmarkConstants.MAX_ITERABLE_LENGTH:
        var memory_start := int(Performance.get_monitor(Performance.MEMORY_STATIC))
        var time_start := Time.get_ticks_usec()

        var test_dict := Dictionary()
        for i in range(size):
            test_dict[i] = i

        var time_after := Time.get_ticks_usec()
        time_result.result[size] = time_after - time_start

        var memory_bytes := int(Performance.get_monitor(Performance.MEMORY_STATIC)) - memory_start
        memory_result.result[size] = memory_bytes
        @warning_ignore("integer_division")
        var kb := memory_bytes / 1024

        print("size: %d - mem: %dkB %dB" % [size, kb, memory_bytes - kb * 1024])
        print("Allocation time: %dusec" % (time_after - time_start))

        size *= 2

    return results
