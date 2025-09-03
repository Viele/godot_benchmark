class_name BenchmarkResult
extends RefCounted

enum UnitType {
    SIZE,
    TIME,
}

var name: String
## X-value is the key to y-value
var result: Dictionary
var x_unit: UnitType
