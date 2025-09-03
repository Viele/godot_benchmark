class_name BenchmarkResult
extends RefCounted

enum UnitType {
    MEMORY,
    TIME,
    DATA_SIZE,
}

var name: String
var result: PackedVector2Array
var x_unit: UnitType
var y_unit: UnitType
