class_name DictionaryBenchmark
extends AbstractBenchmark


func run() -> Array[BenchmarkResult]:
    var results: Array[BenchmarkResult] = []
    var memory_result := BenchmarkResult.new()
    memory_result.name = "Dictionary Memory Usage"
    results.append(memory_result)

    var size = 1
    while size < BenchmarkConstants.MAX_ITERABLE_LENGTH:

        size *= 2

    return results
