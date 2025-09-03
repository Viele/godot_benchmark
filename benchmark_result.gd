class_name BenchmarkResult
extends RefCounted

enum UnitType {
    MEMORY,
    TIME,
    DATA_SIZE,
}

var name: String
var data: PackedVector2Array
var x_unit: UnitType = UnitType.DATA_SIZE
var y_unit: UnitType = UnitType.DATA_SIZE
var color: Color = Color.PINK

static func unit_type_to_string(value: UnitType) -> String:
    match value:
        UnitType.MEMORY:
            return "B"
        UnitType.TIME:
            return "μs"
        UnitType.DATA_SIZE:
            return "#"

    return "unknown"