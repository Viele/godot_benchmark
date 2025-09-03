class_name FunctionBenchmark
extends AbstractBenchmark

## Because run is static, this is the dummy to call functions on
class _TestClass extends RefCounted:

    signal test_signal

    func _init():
        test_signal.connect(test_function)

    func test_function():
        pass


const _BASE_COLOR = Color(0.8, 0.2, 1.0)


static func run() -> Array[BenchmarkResult]:
    var results: Array[BenchmarkResult] = []

    var function_call_result := BenchmarkResult.new()
    function_call_result.name = "Function call result"
    function_call_result.y_unit = BenchmarkResult.UnitType.TIME
    function_call_result.color = _BASE_COLOR
    results.append(function_call_result)

    var signal_result := BenchmarkResult.new()
    signal_result.name = "Signal call result"
    signal_result.y_unit = BenchmarkResult.UnitType.TIME
    signal_result.color = _BASE_COLOR * 0.8
    results.append(signal_result)

    var callable_result := BenchmarkResult.new()
    callable_result.name = "Callable call result"
    callable_result.y_unit = BenchmarkResult.UnitType.TIME
    callable_result.color = _BASE_COLOR * Color(0.6, 0.8, 1.0)
    results.append(callable_result)

    var test_object = _TestClass.new()

    var max_calls = 1 << 11
    var count = 1
    while count < max_calls:
        var start_time := Time.get_ticks_usec()
        for i in range(count):
            test_object.test_function()
        var end_time := Time.get_ticks_usec()
        function_call_result.data.append(Vector2(count, end_time - start_time))

        start_time = Time.get_ticks_usec()
        for i in range(count):
            test_object.test_signal.emit()
        end_time = Time.get_ticks_usec()
        signal_result.data.append(Vector2(count, end_time - start_time))

        var callable = test_object.test_function
        start_time = Time.get_ticks_usec()
        for i in range(count):
            callable.call()
        end_time = Time.get_ticks_usec()
        callable_result.data.append(Vector2(count, end_time - start_time))

        count *= 2

    return results
