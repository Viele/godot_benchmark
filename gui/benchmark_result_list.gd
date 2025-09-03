extends ItemList

var _results: Array[BenchmarkResult]


func _ready():
    multi_selected.connect(_item_selected)


func _item_selected(_index: int, _selected: bool):
    var selected_results: Array[BenchmarkResult] = []
    for index in get_selected_items():
        selected_results.append(_results[index])
    $%graph.draw_results(selected_results)


func load(results: Array[BenchmarkResult]):
    _results = results
    clear()
    for result in results:
        var index = add_item(result.name)
        set_item_custom_bg_color(index, result.color * 0.5)
        set_item_custom_fg_color(index, Color.WHITE)
